
--------------------------------------------------------------------------------
-- ins.get.note
--
----Get a note using object.count as the index for the note phrase
--
--


note = function (self, phrase_N)
	self = self.get_object	-- change self from `o.get` to `o`
	phrase_N = phrase_N or 1
	
	local i = self.count
	local n = self.notes[phrase_N][i]
	
	return n
end


return note
