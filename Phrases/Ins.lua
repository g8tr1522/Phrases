Ins = {}


-- printkeys = function (t, name)	--this is used only for debugging
	-- name = name or '('..tostring(t)..')'
	-- print("\nPrinting keys for table '"..tostring(name).."'...")
	-- for k,v in pairs(t) do
		-- print(string.format("%s.%s = \n\t\t\t%s", tostring(name), tostring(k), tostring(v) ))
	-- end
	-- print()
-- end

--pathdef setup

-- _fileroot = "Phrases."
-- _libroot = "Phrases.Ins."

-- _repopath    = "Phrases/"										--folder of this repo
-- _fileroot    =          "Phrases/"					--folder this file is contained in
-- _filelibpath =                   "Ins/"			--this file is a module. Its submodules/files are kept in this folder. (ie, the 'Ins' folder)
-- _utilspath   =                   "utils/"		--this file also uses some functions in here.
-- _tablerpath  =                   "tabler/"	--this file also uses some functions in here.


-- _sch_file   = ";".._repopath.._fileroot.._filelibpath.."?.lua"		--searcher for files in 'Ins' folder
-- _sch_utils  = ";".._repopath.._fileroot.._utilspath  .."?.lua"		--searcher for files in 'utils' folders
-- _sch_tabler = ";".._repopath.._fileroot.._tablerpath .."?.lua"		--searcher for files in 'tabler' folders

-- package.path = package.path --_sch_file .. _sch_utils

_file = "?.lua"
package.path = package.path 
						.. ";./Phrases/" 				.._file
            .. ";./Phrases/Ins/" 		.._file
						.. ";./Phrases/utils/" 	.._file
						.. ";./Phrases/tabler/"	.._file
						.. ";./Phrases/DelaysMethods/"	.._file
						.. ";./Phrases/NotesMethods/"	.._file

						
unpack = unpack or table.unpack -- Renoise API uses unpack, not table.unpack

--==============================================================================
-- Metatable/namespace setup
--==============================================================================

Ins.subtype = require('ins_subtypes')
Ins.value_counter = require('value_counter')


Ins.dm = require('DelaysMethods')
Ins.dm.__index = Ins.dm
-- Ins.nm = require('NotesMethods')
-- Ins.nm.__index = Ins.nm


-- utility methods
utils = {}
utils.delays2pl = require('delays2pl')
utils.forvals		= require('forvals')
--tabler methods
tabler = {}
tabler.allidx		= require('ae1toend')



--==============================================================================
-- object Instantiation / OOP stuff
--
--==============================================================================

--------------------------------------------------------------------------------
-- new
Ins.new = function (self, argt)
	self = self or Ins
	
	local o = Ins.make_object(argt)
	
	-- object namespace setup
		o.md = {}
		setmetatable(o.md, Ins.md)
		o.md.get_object = o
		-- o.mn = {}
		-- setmetatable(o.mn, Ins.mn)
		-- o.nm.get_object = o
		o.get = {}
		setmetatable(o.get, Ins.get)
		o.get.get_object = o
	
	setmetatable(o, self)
	self.__index = self
	return o
end -- new


--------------------------------------------------------------------------------
-- Ins.make_obj
-- a sub function of `Ins:new`
Ins.make_object = function (argt)
	local o = {}
	
--handle input argument table
	if type(argt)=="table" then
		argt = argt or {subtype = "null"}
	else
		error("\n=== Wrong argument to Ins:new(argt) !\n  = Expected type(argt) to be a table, but argt is type "..type(argt).."!", 3)
	end
	
	if argt.nopl then
		o.nopl = argt.nopl
	else 
		o.nopl = 0
		print("=== Don't forget to set `object.nopl`!") 
	end
	
	if (argt.delays_UB or argt.dub) then
		o.delays_UB = argt.delays_UB or argt.dub
	else 
		o.delays_UB = 0
		print("=== Don't forget to set `object.delays_UB`!") 
	end
	
	print()
	
--rep_table function helps with creating group members
	local rep_table = function (N, object)
		local rt = {}
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
	
--value counter
	o.vc = require('value_counter')
	o.count = 1
	
--now, construct the members for the notes and phrases groups
	ins_subtype = Ins.subtype[argt.subtype]	--this makes the function more readable, nothing else
	o.ins_subtype = ins_subtype.myname
	
	o.notes     = {}
	o.notes.nP  = ins_subtype.NnotesP						-- number of phrases in notes group
	o.notes.PG  = rep_table(o.notes.nP , {})  	-- note  phrases group
	o.notes.nV  = rep_table(o.notes.nP , 0 )  	-- number of values in notes  phrase N
	--o.notes.vc  = function () end								-- notes value counter
	
	o.delays    = {}
	o.delays.nP = ins_subtype.NdelaysP  				-- number of phrases in delays group
	o.delays.PG = rep_table(o.delays.nP, {})  	-- delay phrases group
	o.delays.nV = rep_table(o.delays.nP, 0 )  	-- number of values in delays phrase N
	--o.delays.vc = function () end								-- notes value counter
	
--this discourages users from creating new keys in Ins objects
	o.__newindex = function (t,k,v)
		print("\n=== WARNING! - adding a key to object at "..tostring(t) )
		print("  = Expression looked like : `object."..tostring(k).." = "..tostring(v) )
		if type(v) == "table" then
		print("  = "..tostring(v).." is a table with "..tostring(#v).." elements :", unpack(v) )
		end
	end
	
	return o
end


--------------------------------------------------------------------------------
-- Ins.__newindex
-- prevent creating keys in `Ins` class
Ins.__newindex = function(t,k,v)
	error("=== Error : tried to add a key \""..tostring(k).."\" to the 'Ins' class.",3)
end


--==============================================================================
-- print functions
-- 
--==============================================================================

--------------------------------------------------------------------------------
-- 
Ins.print_info = function (self, options)
	options = options or 'a'
	
	if self==Ins then
		print("~~~ Location of class Ins is at "..tostring(Ins) )
		if options=='l' then
			print("  ~ class Ins has three 'namespaced' methods categories :")
			print("     - Ins.md  at "..tostring(Ins.md).. " has delays  methods.")
			print("     - Ins.mn  at "..tostring(Ins.mn).. " has notes   methods.")
			print("     - Ins.get at "..tostring(Ins.get).." has getter  methods.\n")
			--print("     - Ins.um at "..tostring(Ins.um).." has utility methods.")
		end		
		return
	end	--else, print for objects
	
	if string.find(options, 'a') then
			options = 'lndp'
	end; if string.find(options, 'l') then
		  print("~~~ Object at "..tostring(self).." is a Ins.subtype."..self.ins_subtype.." type.")
	end; if string.find(options, 'n') then
		  print("  ~ `object.notes.PG [ ]`: "..tostring(self.notes.PG) )
		   if string.find(options, 'p') then for i = 1,self.notes.nP do
			print("                     ["..tostring(i).."] --> ", unpack(self.notes.PG[i]) ) end end 
	end; if string.find(options, 'd') then
		  print("  ~ `object.delays.PG[ ]`: "..tostring(self.delays.PG) )
		   if string.find(options, 'p') then for i = 1,self.notes.nP do
			print("                     ["..tostring(i).."] --> ", unpack(self.delays.PG[i]) ) end end 
	end
	print()
end


--==============================================================================
-- validation/checker functions
--
-- These functions are used in get/set functions to make sure that
--		the 'group' construct is handled properly.
--==============================================================================
Ins.get_phrase_strings 					= require("get_phrase_strings")
Ins.is_valid_phrase_index 			= require("is_valid_phrase_index")
Ins.check_amt_of_vals_in_phrase = require("check_amt_of_vals_in_phrase")


--==============================================================================
-- getters
--==============================================================================
Ins.get = require('_get')
Ins.get.__index = Ins.get

--==============================================================================
-- setters
--
-- set_notes and set_delays are 'shell functions' for set_phrase
-- set_phrase uses several of the validation/checker functions (see related section)
--==============================================================================

--------------------------------------------------------------------------------
-- 
Ins.set_notes = function (self, new_phrase, notes_phrase_N)
	self:set_phrase('n', new_phrase, notes_phrase_N)	
end

--------------------------------------------------------------------------------
-- 
Ins.set_delays = function (self, new_phrase, delays_phrase_N)
	self:set_phrase('d', new_phrase, delays_phrase_N)
end

--------------------------------------------------------------------------------
-- 
Ins.set_phrase = function (self, phrase_type_char, new_phrase, phrase_N)
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
	local pts,pto = Ins.get_phrase_strings(phrase_type_char)
	
	if self[pts].nP == 1 then
		phrase_N = 1
	else
		self:is_valid_phrase_index(pts, phrase_N, 1)
	end	
	
-- set new_phrase
	self[pts].PG[phrase_N] =  new_phrase
	self[pts].nV[phrase_N] = #new_phrase
	
-- make sure number of vals in all phrases are the same
	if self:check_amt_of_vals_in_phrase(phrase_type_char, phrase_N) then
		self:vc(1)
	end
end



return Ins
