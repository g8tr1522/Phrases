
--------------------------------------------------------------------------------
-- ins.get.delay_column_value
--
----Get the delay column value from the floating point part of a delay
--	using object.count as the index for the delay phrase
--
--
local floor = math.floor

return function (self, phrase_N)
	self = self.get_object	-- change self from `o.get` to `o`
	
	local i = self.count
	local mantissa = (self.delays.tn[i]) % 1
	local DCV = mantissa * 255  -- delay column value
	
--now round DCV to an 8-bit unsigned integer
	if DCV%1 < 0.5 then
		return floor(DCV)
	else
		return floor(DCV + 1)
	end
	
end
