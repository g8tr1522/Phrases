
--------------------------------------------------------------------------------
-- ins.get.pl
--
----Exactly like ins.get.delay, except converts the delay to a pattern line.
--
--

delays2pl = require("Phrases.utils.delays2pl")

pl = function (self, phrase_N)
	self = self.get_object	-- change self from `o.get` to `o`
	
	local i = self.count
	local d = self.delays[i]
	d = delays2pl(d, self.delays_UB, self.nopl)
	
	return d
end


return pl
