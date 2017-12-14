	
--------------------------------------------------------------------------------
-- utils.iter.selpairs (ary, sel)
--
----Iterator which behaves similar to ipairs, but `sel` is array of integers 
--		corresponding to indices that ipairs should iterate over.
--
----Has three 'modes' depending of what type `sel` is:
--	-- sel is nil
--		- The `selpairs` should then behave like ipairs.
--	-- sel is a number (special case)
--		- `selpairs` iterates over just a single element, `ary[sel]`
--		- Not recommended. (Do you really need an iterator?)
--	-- sel is a table of integers
--		- Works like ipairs, except `i` becomes sel[1], sel[2], ... sel[#sel]
--
----Example:
--		for i,v in selpairs(ary, {1,4,5}) do
--			str = string.format("ary[%d] = %g", i,v)
--			print(str)
--		end
--		--this should iterate only over elements 1,4,5 of `ary`
--
--


local function selpairs(ary, sel)
	local s = 0
	
	if type(sel)=="table" then				-- basic use
		return function ()
				s = s + 1
				local i = sel[s]
				local v = ary[i]
				
				if v then
					return i,v
				end
			end
	
	elseif type(sel)=="number" then		-- return element
		return function ()
				if s==0 then
					s = 1
					if ary[sel] then
						return sel, ary[sel]
					end
				end
			end
	
	elseif not sel then								-- works like ipairs
		return function ()
				s = s + 1
				local v = ary[s]
				
				if v then
					return s,v
				end
			end
	end
	
end

return selpairs


