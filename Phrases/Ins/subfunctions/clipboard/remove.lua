
--------------------------------------------------------------------------------
-- ins.clipboard:remove(I)
--
----remove and reindex notes and delays arrays
--


remove = function (self, I)
	self = self.get_object	-- change self from `o.clipboard` to `o`
	
	local rt = {notes={}, delays={}} --mini Ins object which will be returned by remove
	
	for k,v in pairs(self.notes) do
		rt.notes[k] = table.remove(self.notes[k], I)
	end 
	
	rt.delays.tn = table.remove(self.delays.tn, I)
	rt.delays.pl = table.remove(self.delays.pl, I)
	
	return rt	
end


return remove
