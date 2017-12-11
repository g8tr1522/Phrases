
--------------------------------------------------------------------------------
-- ins.get.delays
--
----Shell function for ins.get.phrase
--
--

return function (self, delays_phrase_N)
	self = self.get_object  -- change self from `o.get` to `o`
	return self.get:phrase('d', delays_phrase_N)
end

