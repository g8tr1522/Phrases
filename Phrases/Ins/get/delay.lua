
--------------------------------------------------------------------------------
-- ins.get.delay
--
----Get a delay using object.count as the index for the delay phrase
--
--


return function (self, phrase_N)
	self = self.get_object	-- change self from `o.get` to `o`
	
	local i = self.count
	
	return self.delays.tn[i]
end
