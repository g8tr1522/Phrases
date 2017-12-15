
--------------------------------------------------------------------------------
-- ins.clipboard:cut(I)
--
----'cut out' all values at `notes[I]`
--	This leaves a gap at that value. Which should then be replaced by `Ins.clipboard:paste`
--	This is exactly like `Ins.clipboard:copy`, except that a `blank slot` is left at index I
--
--


copy = function (self, I)
	self = self.get_object	-- change self from `o.clipboard` to `o`
	
	local rt = {notes={}, delays={}} --mini Ins object which will be returned by copy
	
	for k,v in pairs(self.notes) do
		rt.notes[k] = self.notes[k][I]
		--self.notes[k][I] = nil  --this line makes the difference between cut and copy
	end
	-- for k,v in pairs(self.delays) do
		-- if k ~= "delays_UB" then
			-- rt.delays[k] = self.delays[k][I]
			-- --self.delays[k][I] = nil --this line makes the difference between cut and copy
		-- end
	-- end
	
	return rt	
end


return copy