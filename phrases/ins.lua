ins = {}


--==============================================================================
-- Metatable/namespace setup
--==============================================================================
_root = "phrases."

--create = require('create')
ins.subtype = require(_root..'ins_subtypes')

ins.md = require(_root..'mDelays')
ins.md.__index = ins.md
-- ins.mn = require('notes_methods')
-- ins.mn.__index = ins.mn

--utility methods
utils = {}
utils.delays2pl = require('phrases.utils.delays2pl')
utils.forvals		= require('phrases.utils.forvals')



--==============================================================================
-- object instantiation
--
--==============================================================================

--------------------------------------------------------------------------------
-- new
ins.new = function (self, ins_subtype)
	ins_subtype = ins_subtype or 'null'
	--o = create.ins_obj(ins_subtype)
	o = ins.make_object(ins_subtype)
	
	-- object metatables	
		o.md = {}
		setmetatable(o.md, ins.md)
		-- o.mn = {}
		-- setmetatable(o.mn, ins.mn)
		
	o.__newindex = function (t,k,v)
		print("=== WARNING! - adding a key to object at "..tostring(t) )
		print("  = Expression looked like : `object."..tostring(k).." = "..tostring(v) )
		if type(v) == "table" then
		print("  = "..tostring(v).." is a table with "..tostring(#v).." elements :", table.unpack(v) )
		end
	end
	
	
	setmetatable(o, self)
	self.__index = self
	return o
end -- new

--------------------------------------------------------------------------------
-- __newindex
-- prevent creating keys in `ins` class
ins.__newindex = function(t,k,v)
	error("=== Error : tried to add a key \""..tostring(k).."\" to the 'ins' class.",3)
end

--------------------------------------------------------------------------------
-- make_obj
-- a sub function of `ins:new`
ins.make_object = function (subtype_string)
	local ins_subtype = ins.subtype[subtype_string]	--this makes the function more readable, nothing else
	
	local rep_table = function (N, object)
		rt = {}
		-----print("N is "..tostring(N))
		if N == 0 then
			rt[1] = 0
		else
			for i = 1,N do
				rt[i] = object
			end
		end
		
		return rt
	end
	
	
	o = {}
	-----print("subtype_string is a "..type(subtype_string).." with value '"..subtype_string.."'.\n" )
	o.ins_subtype = ins_subtype.myname
	o.nopl			= 0
	o.delays_UB = 0
	print("\n=== Don't forget to set number of pattern lines! (object.nopl) \n  = and the upper bound of the delays! (object.delays_UB) \n  = Where object is "..tostring(o).."\n")
	
	o.notes     = {}
	o.notes.nP  = ins_subtype.NnotesP						-- number of phrases in notes group
	o.notes.PG  = rep_table(o.notes.nP , {})  	-- note  phrases group
	o.notes.nV  = rep_table(o.notes.nP , 0 )  	-- number of values in notes  phrase N
	o.delays    = {}
	o.delays.nP = ins_subtype.NdelaysP  				-- number of phrases in delays group
	o.delays.PG = rep_table(o.delays.nP, {})  	-- delay phrases group
	o.delays.nV = rep_table(o.delays.nP, 0 )  	-- number of values in delays phrase N
	
	return o
end


--==============================================================================
-- print functions
-- 
--==============================================================================

--------------------------------------------------------------------------------
-- 
ins.print_info = function (self, options)
	options = options or 'a'
	
	if self==ins then
		print("~~~ Location of class ins is at "..tostring(ins) )
		if options=='l' then
			print("  ~ class ins has two 'namespaced' methods categories :")
			print("     - ins.md at "..tostring(ins.md).." has delays  methods.")
			print("     - ins.mn at "..tostring(ins.mn).." has notes   methods.\n")
			--print("     - ins.um at "..tostring(ins.um).." has utility methods.")
		end		
		return
	end	--else, print for objects
	
	if string.find(options, 'a') then
			options = 'lndp'
	end; if string.find(options, 'l') then
		  print("~~~ Object at "..tostring(self).." is a ins.subtype."..self.ins_subtype.." type.")
	end; if string.find(options, 'n') then
		  print("  ~ `object.notes.PG [ ]`: "..tostring(self.notes.PG) )
		   if string.find(options, 'p') then for i = 1,self.notes.nP do
			print("                     ["..tostring(i).."] --> ", table.unpack(self.notes.PG[i]) ) end end 
	end; if string.find(options, 'd') then
		  print("  ~ `object.delays.PG[ ]`: "..tostring(self.delays.PG) )
		   if string.find(options, 'p') then for i = 1,self.notes.nP do
			print("                     ["..tostring(i).."] --> ", table.unpack(self.delays.PG[i]) ) end end 
	end
	print()
end



--==============================================================================
-- validation/checker functions
--
-- these functions are used in get/set functions to make sure that
--		the 'group' construct is handled properly.
--==============================================================================

ins.get_phrase_strings 					= require("phrases.ins.get_phrase_strings")
ins.is_valid_phrase_index 			= require("phrases.ins.is_valid_phrase_index")
ins.check_amt_of_vals_in_phrase = require("phrases.ins.check_amt_of_vals_in_phrase")




--==============================================================================
-- setters
--
-- set_notes and set_delays are 'shell functions' for set_phrase
-- set_phrase uses several of the validation/checker functions (see related section)
--==============================================================================

--------------------------------------------------------------------------------
-- 
ins.set_notes = function (self, new_phrase, notes_phrase_N)
	self:set_phrase('n', new_phrase, notes_phrase_N)	
end

--------------------------------------------------------------------------------
-- 
ins.set_delays = function (self, new_phrase, delays_phrase_N)
	self:set_phrase('d', new_phrase, delays_phrase_N)
end

--------------------------------------------------------------------------------
-- 
ins.set_phrase = function (self, phrase_type_char, new_phrase, phrase_N)
--[=[ set a single notes/delays phrase.
==== Arguments:
 = phrase_type_char (char):
		- should be either 'n' or 'd'
		- specifies whether to set obj.notes.PG  or obj.delays.PG 
		- "notes" or "delays" is then assigned to `pts` (Phrase Type String)
		- a complementary string gets stored in `pto` (Phrase Type Opposite)
		- Example: if `phrase_type_char` = 'n', then 
				`pts` = "notes"
				`pto` = "delays"
 = new_phrase (table of numbers):
		- the new phrase that will replace the old phrase at `phrase_N`
		- is NOT a group of notes or delays, but a phrase of them.
 = phrase_N (number):
		- specifies which phrase (in `notes.PG `/`delays.PG`) to set. 
--]=]
	

-- check input args
	local pts,pto = ins.get_phrase_strings(phrase_type_char)
	
	if self[pts].nP == 1 then
		phrase_N = 1
	else
		self:is_valid_phrase_index(pts, phrase_N, 1)
	end	
	
-- set new_phrase
	self[pts].PG[phrase_N] =  new_phrase
	self[pts].nV[phrase_N] = #new_phrase
	
-- make sure number of notes/delays are consistent
	self:check_amt_of_vals_in_phrase(phrase_type_char, phrase_N)
end



--==============================================================================
-- phrase getters
-- 
-- get_notes and get_delays are 'shell functions' for get_phrase
--==============================================================================

--------------------------------------------------------------------------------
-- 
ins.get_notes = function (self, notes_phrase_N)
	return self:get_phrase('n', notes_phrase_N)
end

--------------------------------------------------------------------------------
-- 
ins.get_delays = function (self, delays_phrase_N)
	return self:get_phrase('d', delays_phrase_N)
end

--------------------------------------------------------------------------------
-- get_pls (get pattern lines)
--
-- Returns Nth phrase in the delays group as a table of pattern lines.
-- If phrase_N is 0, then return all delays phrases as a group of tables of pattern lines.
-- Phrase_N can also be a table of which phrases you want to get back. (not recommended)
--
ins.get_pls = function (self, phrase_N)
	phrase_N = phrase_N or 0 
	pl = {}
	
	pl = utils.forvals(self.delays.PG, phrase_N, 0, 
		function (v) --maybe the delays_UB and nopl can be provided as arguments here?
			return (v-1) /self.delays_UB *self.nopl
		end
	)
	
	return pl
end

--------------------------------------------------------------------------------
-- get_phrase
--
-- Uses utils.forvals to return phrases (where phrase_N goes to Psel)
--
ins.get_phrase = function (self, phrase_type_char, phrase_N)
	local pts = ins.get_phrase_strings (phrase_type_char) 
	phrase_N = phrase_N or 0
	
	local rt = {}
	rt = utils.forvals(self[pts].PG, phrase_N, 0, function (v) return v end)
	return rt
end



--==============================================================================
-- value getters
-- 
-- get_note and get_delay are 'shell functions' for get_value
-- These functions are used to get the next value in a phrase.
--		Each successive call will return the next value.
--==============================================================================






--==============================================================================
-- validation/checker functions
--
-- these functions are used in get/set functions to make sure that
--		the 'group' construct is handled properly.
--==============================================================================

ins.get_phrase_strings 					= require("phrases.ins.get_phrase_strings")
ins.is_valid_phrase_index 			= require("phrases.ins.is_valid_phrase_index")
ins.check_amt_of_vals_in_phrase = require("phrases.ins.check_amt_of_vals_in_phrase")




return ins