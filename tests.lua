-- This is just used to test out new code. This file isn't required.
print()
Phrases = require('Phrases')

g = {
	{10,20,30},
	{11,21,31},
  {5,15,25,35,45},
}

obj = Phrases.Ins:new{subtype="mp_lead", top=5, nopl=64, nonp=3}
obj:print_info()

obj:set_notes{10,20,30,40}
obj:set_notes({12.5,22.5,32.5,42.5},2)
obj:set_notes({15,25,35,45},3)
obj:set_delays{1,2.5,3,3.5}
obj:print_info()



-- onvals(g, 0,0, function(v) return v/5 end)

-- print()
-- for t,i,v in utils.iters.allvals(g) do
	-- print(string.format("g[%d][%d] = %g", t,i,v))
-- end


print()
for _, i,v in Phrases.utils.iters.selvals(g[3], {1,2,4,5}) do
	g[i] = v*2
	print(string.format("g[%d] = %g", i,g[i]))
end