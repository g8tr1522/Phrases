
--------------------------------------------------------------------------------
-- ins.set:notes(sel, notes_array)
--
----set `o.notes[sel]` to `notes_array`
--
--

-- is_valid_phrase_index 
	-- = require('Phrases.Ins.is_valid_phrase_index')
-- require('Phrases.Ins.check_amt_of_vals_in_phrases')


notes = function (self, sel, notes_array)
	self = self.get_object	-- change self from `o.set` to `o`
	
	sel = sel or 1
	print("--- location of self",tostring(self))
	print("  - location of self.is_valid_phrase_index", tostring(self.is_valid_phrase_index))
	
	self:is_valid_phrase_index(sel, 1)
	
-- set selected notes array
	self.notes[sel] = notes_array
	
-- make sure number of vals in all phrases are the same
	if self:check_amt_of_vals_in_phrases(sel) then
		self:vc(1)
	end	
end


return notes
