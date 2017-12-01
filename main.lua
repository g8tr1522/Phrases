-- This is just used to test out new code. This file isn't required.

phrases = require('phrases')

g = {
	{10,20,30},
	{11,21,31},
  {5,15,25,35,45},
}

-- obj = phrases.ins.new(phrases.ins, "mp_lead")

-- obj:print_info()

onvals(g, 0,0, function(v) return v/5 end)

print()
for t,i,v in utils.iters.allvals(g) do
	print(string.format("g[%d][%d] = %g", t,i,v))
end

