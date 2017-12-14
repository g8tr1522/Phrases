
--------------------------------------------------------------------------------
-- ins.set:notes_group(sel, notes_array)
--
----set `o.notes[sel]` to `notes_array`
--
--

require('Phrases.Ins.is_valid_phrase_index')
require('Phrases.Ins.check_amt_of_vals_in_phrases')


notes_group = function (self, notes_group)
	self = self.get_object	-- change self from `o.set` to `o`
	
	phrase_N = phrase_N or 1
	self:is_valid_phrase_index(sel, 1)
	
-- set selected notes array
	self.notes[sel] = notes_array
	
-- make sure number of vals in all phrases are the same
	if self:check_amt_of_vals_in_phrases(sel) then
		self:vc(1)
	end	
end


return notes_group
