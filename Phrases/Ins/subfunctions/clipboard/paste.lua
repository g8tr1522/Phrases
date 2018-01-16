
--------------------------------------------------------------------------------
-- Ins.clipboard:paste(rt_from_cb)
--
----paste the items returned by a clipboard function at index `I`
--	This destructively replaces any items at index I
--	This will perform a copy at I if any items existed at I.
--


paste = function (self, I, rt_from_cb )
	self = self.get_object	-- change self from `o.clipboard` to `o`
	
	local rt = {}
	if self.notes[1][I] then			--this always relies on notes[1] existing. This should be addresses in a future update.
		rt = self.clipboard:copy(I)
	end	
	
	for k,v in pairs(self.notes) do
		self.notes[k][I] = rt_from_cb.notes[k]
	end
	-- for k,v in pairs(self.delays) do
		-- if k ~= "delays_UB" then
			-- self.delays[k][I] = rt_from_cb.delays[k]
		-- end
	-- end
	
	return rt
end


return paste
