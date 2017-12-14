
--------------------------------------------------------------------------------
-- utils.forgroup (group, Psel, Vsel, func)
--
----Do a function `func` on all the values in `group`.
--	See function description for iters.selpairs to get a better understanding.
--	Reminder: In this library, a `group` means a table of arrays.
--
----Input Arguments:
--	- group (table of arrays) : 
--			- A table of tables, usually a table of notes.
--	- Psel (table or number) : "Phrase Select"
--			- Selects which tables in `group` to perform `func` on.
--			- If given `nil`, then perform `func` on all tables in `group`.
--	- Vsel (table or number) : "Value Select"
--			- selects which values for the selected tables in `group` to iterate over. 
--			- If given `nil`, then perform `func` on all values in all tables selected by `Psel`.
--	- func (function) : 
--			-	This function should have at least one argument (eg, `v`).
--				`forgroup` then performs `func(v)` on all the selected values in `group`.
--			- Takes two more arguments. eg, `func(v,i,g)`
--				`i` is then the selected index. Ie, `group[g][i]`
--				`g` is then the selected tables in `group`. Ie, `group[g]`
--				If you want to use a predefined function that conflicts with these arguments,
--					then just call the function on inside `func`.
--			- If not supplied, `func` becomes `function (v) return v end` 
--					(useful for getting selected values)
--
----About type handling (for Psel and Vsel):
--	forgroup returns a group, but certain tables may be unpacked depending on whether
--	Psel or Vsel are numbers or tables.
--	- type(Psel), type(Vsel)
--				(form of return group `rg` given here)
--				(description here)
--	- "nil", "nil"
--				rg = { {...}, {...}, ... {...} }
--				Structured exactly like `group`.
--	- "table", "table"
--				rg = { {...}, {...}, ... {...} }
--				Structured just like to `group`, except for tables/values omitted depending on Psel, Vsel.
--	- "number", "table"
--				rg = {...} == group[Psel]
--	- "table", "number"
--				rg = {...} == { {...}[Vsel], {...}[Vsel], ... {...}[Vsel] }
--				This is a table of numbers, each being the element at Vsel for each table in group.
--	- "number", "number"
--				rg = (number) == group[Psel][Vsel]
--				This will return a single number.
--  -If you want to do a single element, but not unpack any tables, then put the single element
--			in a table. Eg, `forgroup(group, {Psel}, {Vsel})` where Psel and Vsel are numbers.
--
----WARNING: (noncontiguous arrays returned by forgroup) 
--	- Doing something like
--				forgroup(group, {1,2,5}, Vsel, func(v))
--		forces `rg` to only have elements at indices 1, 2, and 5. 
--	- This means that rg[3] and rg[4] are nil.
--	- So if you then did
--				for i,v in ipairs (rg) do ... end
--		then you would only iterate	over rg[1], and rg[2].
--	- You could instead do
--				local g = 0
--				for _,v in selpairs(rg, {1,2,5}) do 
--					g = g + 1
--					rg[g] = v
--				end
--		if you wanted to reindex rg so that it's contiguous.
--
--			


selpairs = require('Phrases.iters.selpairs')
unpack = unpack or table.unpack -- Renoise API uses unpack, not table.unpack


forgroup = function (group, Psel, Vsel, func)
	local rg = {}	--return group

--no supplied function?	
	if not func then 
		func = function (v)
			return v
		end
	end
	
--apply `func` to values	
	for g,p in selpairs(group, Psel) do
		rg[g] = {}
		for i,v in selpairs(group[g], Vsel) do
			rg[g][i] = func(v,i,g)
		end
	end
	
--handle return table
	if type(Vsel)=="number" then
		for i,v in ipairs(rg) do
			rg[i] = unpack(v)
		end
	elseif type(Psel)=="number" then
		rg = unpack(rg)
	end
	
	return rg
end

return forvals
