
--------------------------------------------------------------------------------
-- Ins.clipboard:paste(rt_from_cb)
--
----paste the items returned by a clipboard function at index `I`
--	This destructively replaces any items at index I
--	This will perform a copy at I if any items existed at I.
--


insert = function (self, I, rt_from_cb )
	self = self.get_object	-- change self from `o.clipboard` to `o`
	
	for k,v in pairs(self.notes) do
		table.insert(self.notes[k], I, rt_from_cb.notes[k])
	end
	
	table.insert(self.delays.tn, I, rt_from_cb.delays.tn)
	table.insert(self.delays.pl, I, rt_from_cb.delays.pl)
end


return insert
