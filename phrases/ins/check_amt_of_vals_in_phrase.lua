
--------------------------------------------------------------------------------
-- ins.check_amt_of_vals_in_phrase
--
----Prints warnings if the number of values in (notes/delays) phrase_N 
--	doesn't match the number of values in (delays/notes) phrase_N.
--
----If there's only 1 notes/delays phrase, then this will check against the single phrase.
--
--
--
--
--
--
--
--
--


return function (self, phrase_type_char, phrase_N)
	
	local pts, pto = ins:get_phrase_strings(phrase_type_char)
	if self[pto].nP == 1 then
		pto_phrase_N = 1
	else
		pto_phrase_N = phrase_N
	end
	
	self:is_valid_phrase_index(pts, phrase_N, 2)
	local matching = false
	
	if self[pts].nV[phrase_N] == self[pto].nV[pto_phrase_N] then
		matching = true
	else 
		matching = false
		print("=== Warning!!! Number of notes does not match number of delays!")
			print(
			  	"  = `object."..pts..".nV["..phrase_N.."]` = \t"							..tostring(self[pts].nV[phrase_N]).."\n"..
					"  = `object."..pto..".nV["..tostring(pto_phrase_N).."]` = \t"..tostring(self[pto].nV[pto_phrase_N]) .."\n"
				)
	end
	
	return matching
end
