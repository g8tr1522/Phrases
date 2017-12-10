-- This is just used to test out new code. This file isn't required.
print()
Phrases = require('Phrases')

g = {
	{10,20,30},
	{11,21,31},
  {5,15,25,35,45},
}

obj = Phrases.Ins:new("mp_lead", {dub=4, nopl=64})
obj:print_info()
obj:set_notes{10,20,30,40}
obj:set_delays{1,2.5,3,3.5}
obj:print_info()



-- onvals(g, 0,0, function(v) return v/5 end)

-- print()
-- for t,i,v in utils.iters.allvals(g) do
	-- print(string.format("g[%d][%d] = %g", t,i,v))
-- end

