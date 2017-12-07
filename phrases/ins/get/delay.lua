
--------------------------------------------------------------------------------
-- ins.get.delay
--
----Get a delay using object.count as the index for the delay phrase
--
--


delay = function (self, phrase_N)
	self = self.get_object	-- change self from `o.get` to `o`
	phrase_N = phrase_N or 1
	
	local i = self.count
	local n = self.delays.PG[phrase_N][i]
	
	return n
end


return delay