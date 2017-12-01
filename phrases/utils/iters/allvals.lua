	
--------------------------------------------------------------------------------
-- utils.iter.allvals
--
----This will iterate over all the values of a group.
--
----example:
--		for t,i,v in allvals(g) do
--			g[t][i] = v+1
--			print(string.format("g[%d][%d] = %d", t,i,v))
--		end
--		-- this will add 1 to every value in g, and print the result.
--
----If you need to iterate only over certain phrases in g, look at utils.onvals.
--


return function (g) --allvals (g) 
	local i = 0
	
	local iter = function (g, t)
		i = i+1
		local v = g[t][i]
		
		if v then 
			return t,i,v
		elseif g[t+1] then	
			t = t+1
			i = 1
			return t,i,g[t][i]
		end	
	end
	
	return iter, g, 1
end