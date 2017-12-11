
--------------------------------------------------------------------------------
-- ins.check_amt_of_vals_in_phrases
--
----If all phrases have the same number of vals, return true.
--  Else, print warnings indicating which phrases offend, and return false.
--
--
--
--
--
--
--
--
--


return function (self, notes_phrase_N)
	local matching = {all = true, n = true, d = true}
	
	--notes_phrase_N = notes_phrase_N or 1
	local amt = self.notes.nV[(notes_phrase_N or 1)]
	
	-- check against all same-type phrases
	for i = 1,self.notes.nP do
		if amt ~= self.notes.nV[i] then
			matching.n   = false
			matching.all = false
		end
	end
	if matching.n then
		if amt ~= #self.delays then
			matching.d   = false
			matching.all = false
		end
	end
	
	if not matching.all then
		print("=== Warning!!! Inconsistent number of values ")
		print("      between phrases in object "..tostring(self).."!")
		if not matching.d and matching.n then
		print("  = The number of delays does not match the number of notes.")
		print("  = There are "..tostring(#self.delays).." values in `object.delays`, ")
		print("      yet there are "..tostring(amt).." values in all `object.notes` phrases!")
		elseif not matching.n then
			if notes_phrase_N then
				print("  = After setting `object.notes["..tostring(notes_phrase_N).."]`, ")
			end
		print("  = Number of notes in `object.notes[ ]` --> ...")
			for i = 1,#self.notes.PG do
				print("                                    ["..tostring(i).."]  --> "..tostring(#self.notes.PG[i]) )
			end
		end		
		print("  = Please use object:set_notes() / object:set_delays() ")
		print("      so that all values reported above are the same.\n")
	end
	
	return matching.all
end
