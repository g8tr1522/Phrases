ins = {}


--==============================================================================
-- Metatable/namespace setup
--==============================================================================

--create = require('create')
ins.subtype = require('ins_subtypes')

ins.dm = require('delays_methods')
ins.dm.__index = ins.dm
-- ins.nm = require('notes_methods')
-- ins.nm.__index = ins.nm
-- ins.um = require('utility_methods')
-- ins.um.__index = ins.um



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
		o.dm = {}
		setmetatable(o.dm, ins.dm)
		-- o.nm = {}
		-- setmetatable(o.nm, ins.nm)
		-- o.um = {}
		-- setmetatable(o.um, ins.um)
		
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
	
	o.notes 		= {}
	o.delays		= {}
	o.notes.NP  = ins_subtype.NnotesP		-- number of notes  phrases
	o.delays.NP = ins_subtype.NdelaysP  -- number of delays phrases
	o.notes.ph  = rep_table(o.notes.NP , {})  	-- note  phrases
	o.delays.ph	= rep_table(o.delays.NP, {})  	-- delay phrases
	o.notes.NV 	= rep_table(o.notes.NP , 0 )  	-- number of values in notes  phrase N
	o.delays.NV	= rep_table(o.delays.NP, 0 )  	-- number of values in delays phrase N
	
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
		print("~ Location of class ins is at "..tostring(ins) )
		if options=='l' then
			print("~ class ins has three 'namespaced' methods categories :")
			print("    - ins.dm at "..tostring(ins.dm).." has delays  methods.")
			print("    - ins.nm at "..tostring(ins.nm).." has notes   methods.")
			print("    - ins.um at "..tostring(ins.um).." has utility methods.")
		end		
		return
	end	--else, print for objects
	
	if string.find(options, 'a') then
			options = 'lnd'
	end; if string.find(options, 'l') then
		print("~ Object at "..tostring(self).." is a ins.subtype."..self.ins_subtype.." type.")
	end; if string.find(options, 'n') then
		print("~ notes : ", table.unpack(self.notes.ph) )
	end; if string.find(options, 'd') then
		print("~ delays: ", table.unpack(self.delays.ph) )
	end
end



--==============================================================================
-- setters
--
-- set_notes and set_delays are 'shell functions' for set_phrase
-- set_phrase uses several of the validation/checker functions (see related section)
--==============================================================================

--------------------------------------------------------------------------------
-- 
ins.set_notes = function (self, t, notes_phrase_N)
	self:set_phrase('n', t, notes_phrase_N)	
end

--------------------------------------------------------------------------------
-- 
ins.set_delays = function (self, t, delays_phrase_N)
	self:set_phrase('d', t, delays_phrase_N)
end

--------------------------------------------------------------------------------
-- 
ins.set_phrase = function (self, phrase_type_char, vals, phrase_N)
--[=[ set a single notes/delays phrase.
==== Arguments:
 = phrase_type (char):
		- should be either 'n' or 'd'
		- specifies whether to set obj.notes.ph or obj.delays.ph
		- immediately gets converted to "notes" or "delays"
		- a complementary string gets stored in `phrase_type_opposite`
		- Example: if `phrase_type` = 'n', then 
				`phrase_type` = "notes"
				`phrase_type_opposite` = "delays"
 = vals (table of numbers):
		- a single table (a phrase) of either notes or delays
		- is NOT a table of phrases of notes or delays
 = phrase_N (number):
		- specifies which phrase (in `notes.ph`/`delays.ph`) to set. 
--]=]

-- check input args
	local pts,pto = ins.get_phrase_strings(phrase_type_char)
	self:is_valid_phrase_index(pts, phrase_N, 2)
	
-- set vals
	self[pts].ph[phrase_N] =  vals
	self[pts].NV 					 = #vals
	
-- make sure number of notes/delays are consistent
	self:check_amt_of_vals_in_phrase(phrase_type_char, phrase_N)
end



--==============================================================================
-- getters
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
-- 
ins.get_pl = function (self, delays_phrase_N)
	local ret_t = self:get_delays(delays_phrase_N)		-- local return table
	
	if type(ret_t[1]) == "table" then		-- if we get a table of phrases
		for i,v in pairs(ret_t) do
			ret_t[i] = ins.delays2pl(v)	-- here, `v` (value) is a phrase 
		end
	else
		ret_t = ins.delays2pl(ret_t)
	end
	
	return ret_t
end

--------------------------------------------------------------------------------
-- 
ins.get_phrase = function (self, phrase_type_char, phrase_N)
	local pts, pto = ins.get_phrase_strings (phrase_type_char) 
	--local ret_ToP = false  -- return (all phrases) as a table of phrases
	
	if phrase_N == nil then
		if self[pts].NP == 1 then
			phrase_N 	= 1
			--ret_ToP 	= false
		else
			return self[pts].ph
			--ret_ToP 	= true
		end
	end
	
	return self[pts].ph[phrase_N]
end

--------------------------------------------------------------------------------
-- 
ins.delays2pl = function (t)
-- converts a single delay phrase to pattern lines
	for i = 1,#t do
		t[i] = (t[i] - 1) /self.delays_UB *self.nopl
	end
	
	return t
end


--==============================================================================
-- validation/checker functions
--
-- these functions are used in get/set functions to make sure that
--		the 'table of phrases' construct is handled properly.
--==============================================================================

--------------------------------------------------------------------------------
-- 
ins.get_phrase_strings = function (phrase_type_char)
-- 'n' returns "notes" and "delays", and 'd' returns "delays" and "notes"
	if 			phrase_type_char 		 == 'n' then
					phrase_type_string 		= "notes"
					phrase_type_opposite 	= "delays"
	elseif 	phrase_type_char 		 == 'd' then
					phrase_type_string 		= "delays"
					phrase_type_opposite 	= "notes"
	end
	
	return phrase_type_string, phrase_type_opposite
end

--------------------------------------------------------------------------------
-- 
ins.is_valid_phrase_index = function (self, pts, phrase_N, error_level, dont_throw_error)
-- check if object only has P phrases, but we try to set phrase.ph[phrase_N], and `phrase_N` > P
	error_level = error_level or 3
	error_level = error_level+1  -- raise outside of this function
	
	if phrase_N > self[pts].NP then
		if dont_throw_error then
			return false
		else		
			error("\n=== ERROR: bad phrase index!!\n",
						"  = Tried setting phrase in `object."..pts..".ph["..tostring(phrase_N).."]` !\n",
						"  = But object "..tostring(self).." is ins type "..self.ins_subtype..
						" and only has "..tostring(self[pts].NP).." "..pts.." phrases!", error_level)
		end
		
	else
		return true
	end
	
end
	
--------------------------------------------------------------------------------
-- 
ins.check_amt_of_vals_in_phrases = function (self, phrase_type_char, phrase_N)
--[=[ prints warnings if the number of values in (notes/delays) phrase_N doesn't match the number of values in (delays/notes) phrase_N
]=]
	local matching = false
	local pto_phrase_N = phrase_N
	
	local pts, pto = ins:get_phrase_strings(phrase_type_char)
	self:is_valid_phrase_index(pts, phrase_N, 3)
	
	if self:is_valid_phrase_index(pto, phrase_N, 3, 'b') then
		if self[pts].ph[phrase_N] == self[pto].ph[phrase_N] then
			matching = true
		end
	elseif self[pto].NP == 1 then
		pto_phrase_N = 1
		if self[pts].ph[phrase_N] == self[pto].ph[1] then
			matching = true
		end
	end
	
	if not matching then
		print("\n=== Warning!!! Number of notes does not match number of delays!",
					"  = `object."..pts..".NV["..phrase_N.."] = "							 ..tostring(self[pts].NV[phrase_N]) ,
					"  = `object."..pto..".NV["..tostring(pto_phrase_N).."] = "..tostring(self[pto].NV[pto_phrase_N]) 
		)
		return false
	else
		return true
	end
end




return ins