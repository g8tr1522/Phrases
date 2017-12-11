
--------------------------------------------------------------------------------
-- ins.get.delay
--
----Get a delay using object.count as the index for the delay phrase
--
--


delay = function (self, phrase_N)
	self = self.get_object	-- change self from `o.get` to `o`
	
	local i = self.count
	local d = self.delays[i]
	
	return d
end


return delay