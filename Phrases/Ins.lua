Ins = {}

-- printkeys = function (t, name)	--this is used only for debugging
	-- name = name or '('..tostring(t)..')'
	-- print("\nPrinting keys for table '"..tostring(name).."'...")
	-- for k,v in pairs(t) do
		-- print(string.format("%s.%s = \n\t\t\t%s", tostring(name), tostring(k), tostring(v) ))
	-- end
	-- print()
-- end


--==============================================================================
-- requires
--==============================================================================

_folder_Ins = _folder_Ins 
if not _folder_Ins then error("global path string '_folder_Ins' not visible!") end

unpack = unpack or table.unpack -- Renoise API uses unpack, not table.unpack

-- utility methods
utils = {}
utils.delays2pls = require(_folder_utils..'delays2pls')
utils.forvals		 = require(_folder_utils..'forvals')



--==============================================================================
-- various Ins submodules
--==============================================================================

---------------------------------------
-- uncategorized

--Ins.subtype = require(_sourceroot..'ins_subtypes')
Ins.value_counter_closure = require(_folder_Ins..'value_counter_closure')



---------------------------------------
-- Delays/Notes methods
Ins.dm = require(_sourceroot..'DelaysMethods')
Ins.dm.__index = Ins.dm
-- Ins.nm = require('NotesMethods')
-- Ins.nm.__index = Ins.nm


---------------------------------------
-- validation/checker functions
Ins.is_valid_phrase_index 				= require(_folder_Ins.."is_valid_phrase_index")
Ins.check_amt_of_vals_in_phrases	= require(_folder_Ins.."check_amt_of_vals_in_phrases")
-- Ins.get_phrase_strings 						= require("get_phrase_strings")


---------------------------------------
-- getters
Ins.get = require(_folder_Ins..'_get')
Ins.get.__index = Ins.get


---------------------------------------
-- setters
Ins.set = require(_folder_Ins..'_set')
Ins.set.__index = Ins.set


---------------------------------------
-- clipboard functions
Ins.clipboard = require(_folder_Ins..'_clipboard')
Ins.clipboard.__index = Ins.clipboard



--==============================================================================
-- object Instantiation / OOP stuff
--==============================================================================

---------------------------------------
-- new
Ins.new = function (self, argt)
	if not argt then	-- in case user forgets to use colon syntax
		local argt = self
		local self = Ins
	end		
	
	local o = Ins.make_object(argt)
	
	setmetatable(o, self)
	self.__index = self
	return o
end -- new


---------------------------------------
-- Ins.__newindex
-- prevent creating keys in `Ins` class
-- aka, shitty encapsulation
Ins.__newindex = function(t,k,v)
	error("=== Error : tried to add a key \""..tostring(k).."\" to the 'Ins' class.",3)
end


---------------------------------------
-- Ins.make_obj
-- a sub function of `Ins:new`
Ins.make_object = function (argt)
	local o  = {} 
	o.delays = {} -- defined here bc it is assigned to in section "handle input argument table"
	
--handle input argument table
	-- is argt a table?
	if type(argt)~="table" then
		error("\n=== Wrong argument to Ins:new(argt) !"
			    .."\n= Expected type(argt) to be a table, but argt is type "..type(argt).."!"
					,3)
	end
	
	-- number of notes phrases:
	argt.nonp = argt.nonp or argt.nnp or argt.np or argt.nn or argt.nP or 1
	
	-- number of pattern lines:
	local nopl_at_pattern_1 = 0
	if renoise then nopl_at_pattern_1 = renoise.song().patterns[1].number_of_lines or 0 end
	if argt.nopl then
		o.nopl = argt.nopl
	else 
		if nopl_at_pattern_1~=0 then
			o.nopl = nopl_at_pattern_1
			print("=== `nopl` for Ins object "..tostring(o).." was automatically set to ", nopl_at_pattern_1)
		else 
			o.nopl = 0
			print("=== `renoise.song()` is not visible.")
			print("  = `object.nopl` must be set manually!")
		end
	end
	
	-- delays.tn upper bound
	argt.top = argt.top or argt.dtop or argt.dub or argt.delays_UB
	if argt.top then
		o.delays.top = argt.top
	else
		o.delays.top = 0
		print("=== Don't forget to set `object.delays.top`!") 
	end
	
	-- instrument number (used for `Ins.get:note_column_table`)
	argt.instrument_value = argt.instrument or argt.instrument_number or argt.instrument_number or argt.instrument_value or argt.inst or argt.inst_num or argt.inst_val or argt.inst_value
	if argt.instrument_value then
		if type(argt.instrument_value)=="string" then
			argt.instrument_value = tonumber(argt.instrument_value)
		end
		o.instrument_value = argt.instrument_value
	else
		o.instrument_value = 0
		print("=== WARNING : Instrument value was automatically set to 0! Set with `Ins.set:instrument_value`")
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
	--o.vc = require(_folder_Ins..'value_counter')
	o.vc = Ins.value_counter_closure()
	o.count = 1
	
--now, construct the members for the notes and phrases groups
	o.notes      = rep_table(argt.nonp, {})	-- a table of phrases (ie, note tables)
	o.delays.tn  = {}	-- Traditional Notation delays
	o.delays.pl  = {}	-- Pattern Lines delays
	--o.delays.tn0 = {}	-- programmer's Traditional Notation delays (ie, `o.delays.tn[i] - 1`)
	
--this discourages users from creating new keys in Ins objects (aka, shitty encapsulation)
	o.__newindex = function (t,k,v)
		print("\n=== WARNING! - adding a key to object at "..tostring(t) )
		print("  = Expression looked like : `object."..tostring(k).." = "..tostring(v) )
		if type(v) == "table" then
		print("  = "..tostring(v).." is a table with "..tostring(#v).." elements :", unpack(v) )
		end
	end
	
--object namespace setup
	o.dm = {}
	setmetatable(o.dm, Ins.dm)
	o.dm.get_object = o
	
	-- o.nm = {}
	-- setmetatable(o.nm, Ins.nm)
	-- o.nm.get_object = o
	
	o.get = {}
	setmetatable(o.get, Ins.get)
	o.get.get_object = o
	
	o.set = {}
	setmetatable(o.set, Ins.set)
	o.set.get_object = o
	
	o.clipboard = {}
	setmetatable(o.clipboard, Ins.clipboard)
	o.clipboard.get_object = o
--
	return o
end


--==============================================================================
-- print functions
--==============================================================================

---------------------------------------
-- print_info
-- prints out locations of submodules and prints out values in o.notes and o.delays
-- call with a string of options. Any of "alndp".
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
		  print("~~~ Object at "..tostring(self).." is an Ins object with "..tostring(#self.notes).." notes phrases.")
	end; if string.find(options, 'd') then
		  print("  ~ `object.delays.tn` :   ", unpack(self.delays.tn))
		  print("  ~ `object.delays.pl` :   ", unpack(self.delays.pl))
	end; if string.find(options, 'n') then
		  print("  ~ `object.notes[ ]`: "..tostring(self.notes) )
		   if string.find(options, 'p') then for i = 1,#self.notes do
			print("                 ["..tostring(i).."] --> ", unpack(self.notes[i]) ) end end 
	end;
	
	print()
end



return Ins
