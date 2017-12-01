g = {
	{10,20,30},
	{11,21,31},
  {5,15,25,35,45},
}


function allvals (g) 
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

for t,i,v in allvals(g) do
	print(string.format("g[%d][%d] = %d", t,i,v))
end


--[==[
function sel_phrases (g, ts)
	if not ts then
		local ts = {}
		for i = 1,#g do
			ts[i] = i
		end
		print("ts was set to a table with values", table.unpack(ts))
	end
	
	pack      = {}
	pack.g    = g
	pack.ts   = ts
	
	local i 	= 0
	local tsi = 1
	--local gi  = 0
	
	local iter = function (pack, t)
		--local gi = g[t]
		i = i+1
		local v = pack.g[t][i]
		
		if v then 
			return t, i, v
		elseif pack.g[pack.ts[tsi+1]] then	
			tsi = tsi + 1
			i = 1
			return pack.ts[tsi], i, pack.g[pack.ts[tsi]][i]
		end	
	end
	
	return iter, pack, 1
end

for t,i,v in sel_phrases(g) do
	print(string.format("g[%d][%d] = %d", t,i,v))
end
--]==]

range = function (i, to, inc)
	if i == nil then return end -- range(--[[ no args ]]) -> return "nothing" to fail the loop in the caller

	if not to then
		to = i 
		i  = to == 0 and 0 or (to > 0 and 1 or -1) 
	end 

	-- we don't have to do the to == 0 check
	-- 0 -> 0 with any inc would never iterate
	inc = inc or (i < to and 1 or -1) 

	-- step back (once) before we start
	i = i - inc 

	return function () 
		if i == to then 
			return nil 
		end 
		i = i + inc 
		return i, i 
	end 
end 

--above will return an iterator with a range
--found at http://lua-users.org/wiki/RangeIterator

tabler = {}

tabler.count = function (top)
	t = {}
	for i = 1,top do
		t[i] = i
	end
	return t
end



onvals = function (g, psel, vsel, func)
	if not func then
		if not vsel then
			if type(psel)=="function" then
				func = psel
				psel = tabler.count(#g)
				vsel = tabler.count(#g[1])
			end
		elseif (type(vsel)=="function") then
			func = vsel
			vsel = tabler.count(#g[1])
		end
	end
	
	if type(psel)=="number" then
		psel = {psel}
	end
	if type(vsel)=="number" then
		vsel = {vsel}
	end
	
	for i,p in ipairs(psel) do
		for v= 1,#g[p] do
			g[p][v] = func( g[p][v] )
		end
	end 
end


onvals(g, 3, function(v) return v/5 end)

print()
for t,i,v in allvals(g) do
	print(string.format("g[%d][%d] = %g", t,i,v))
end






-- local iter = function (t, i)
		-- i = i+1
		-- print("  ~ inside iter,    g    is:",tostring(g))
		-- print("  ~ inside iter,    g[1] is:",tostring(g))
		-- print("  ~ inside iter,    t    is:",tostring(t))
		-- print("  ~ inside iter,    i    is:",tostring(i))
		-- print("  ~ inside iter,    g[t] is:",tostring(g[t]))
		-- print()
		-- local v = g[t][i]
		
		-- if v then 
			-- print("- if1   : t = ",t)
			-- print("- if1   : i = ",i)
			-- print("- if1   : v = ",v)
			-- io.read()
			-- return t, i, v
		-- elseif g[t+1] then
			-- print("- if2.1 : i = ",i)
				-- t = t+1
				-- i = 1
			-- print("- if2.2 : i = ",i)
			-- print("- if2.2 : t = ",t)
			-- io.read()
				-- return t, i, g[t][i]
		-- else
			-- print("- if3   : t = ",t)
			-- print("- if3   : i = ",i)
			-- print("- if3   : v = ",v)
			-- io.read()
			-- return nil
		-- end
	-- end