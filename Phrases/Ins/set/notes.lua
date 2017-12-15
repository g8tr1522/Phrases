
--------------------------------------------------------------------------------
-- ins.set:notes(sel, notes_array)
--
----set `o.notes[sel]` to `notes_array`
--
--


require('Phrases.iters.selpairs')
unpack = unpack or table.unpack -- Renoise API uses unpack, not table.unpack


notes = function (self, sel, notes_array)
	self = self.get_object	-- change self from `o.set` to `o`
	
	if not notes_array then
		notes_array = sel
		sel = {1}
	end
	if type(sel)~="table" then sel={sel} end
	
	for _,v in pairs(sel) do
		local t = self.notes[v]
		if not t then
			print("~~~ Adding new notes phrase at `object.notes["..tostring(v).."]`\n")
		end
		
		self.notes[v] = notes_array
	end
	
-- make sure number of vals in all phrases are the same
	if self:check_amt_of_vals_in_phrases(unpack(sel)) then
		self:vc(1)
	end	
end


return notes
