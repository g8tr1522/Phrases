-- This is just used to test out new code. This file isn't required.
print()
Phrases = require('Phrases')
chance	= require('Chance/chance')

-- obj = Phrases.Ins:new{subtype="mp_lead", top=5, nopl=64, nonp=3}
-- obj:print_info()

-- obj.set:notes{10,20,30,40}
-- obj.set:notes(2, {12.5,22.5,32.5,42.5})
-- obj.set:notes(3, {15,25,35,45})
-- obj.set:delays{1,2.5,3,3.5}
-- obj:print_info()



-- require('Phrases.utils.forgroup')

g = {
	{10,20,30},
	{11,21,31},
  {5,15,25,35,45},
}

-- rg = forgroup(g, {3}, {5}, 
	-- function (v, i, g) 
		-- print(string.format("g[%d][%d] = %g", g,i,v)) 
		-- return v
	-- end
-- )

-- --print("rg       is type "..type(rg)..   ". Elements :", table.unpack(rg) )
-- --print("rg[1]    is type "..type(rg[1])..". Elements :", table.unpack(rg[1]) )
-- --print("rg[1][1] is type "..type(rg[1][1]))


-- require('Phrases.iters')
-- for i,v in selpairs(g[3], 5) do
	-- print(v)
-- end