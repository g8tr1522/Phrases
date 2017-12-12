
--------------------------------------------------------------------------------
-- ins.get.delays
--
----Shell function for ins.get.phrase
--
--

return function (self)
	self = self.get_object  -- change self from `o.get` to `o`
	
	return self.delays.tn
end

