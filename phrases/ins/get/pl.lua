
--------------------------------------------------------------------------------
-- ins.get.pl
--
----Exactly like ins.get.delay, except converts the delay to a pattern line.
--
--

delays2pl = require("phrases.utils.delays2pl")

pl = function (self, phrase_N)
	self = self.get_object	-- change self from `o.get` to `o`
	phrase_N = phrase_N or 1
	
	local i = self.count
	local n = self.delays.PG[phrase_N][i]
	n = delays2pl(n, self.delays_UB, self.nopl)
	
	return n
end


return pl
