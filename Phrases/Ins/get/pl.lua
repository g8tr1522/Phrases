
--------------------------------------------------------------------------------
-- ins.get.pl
--
----Exactly like ins.get.delay, except converts the delay is a pattern line.
--
--

return function (self, phrase_N)
	self = self.get_object	-- change self from `o.get` to `o`
	
	local i = self.count
	
	return self.delays.pl[i]
end
