	
--------------------------------------------------------------------------------
-- utils.iter.selpairs (ary, sel)
--
----Has three 'modes' depending of what type `sel` is:
--	-- sel is a table (basic usage)
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


