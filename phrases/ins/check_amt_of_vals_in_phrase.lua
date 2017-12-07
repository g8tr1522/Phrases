
--------------------------------------------------------------------------------
-- ins.check_amt_of_vals_in_phrase
--
----Prints warnings if the number of values in the requested phrase.
--		doesn't match values in other phrases.
--
----If there's only 1 notes/delays phrase, 
--		then this will check against the single phrase.
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
	local gen_check = false
	if not phrase_type_char then
		gen_check = true
		phrase_type_char = 'n'
	end
	
	local pts, pto = ins:get_phrase_strings(phrase_type_char)
	-- if self[pto].nP == 1 then
		-- pto_phrase_N = 1
	-- else
		-- pto_phrase_N = phrase_N
	-- end
	
	-- self:is_valid_phrase_index(pts, phrase_N, 2)
	-- local matching = false
	
	-- if self[pts].nV[phrase_N] == self[pto].nV[pto_phrase_N] then
		-- matching = true
	-- else 
		-- matching = false
		-- print("=== Warning!!! Number of notes does not match number of delays!")
			-- print(
			  	-- "  = `object."..pts..".nV["..phrase_N.."]` = \t"							..tostring(self[pts].nV[phrase_N]).."\n"..
					-- "  = `object."..pto..".nV["..tostring(pto_phrase_N).."]` = \t"..tostring(self[pto].nV[pto_phrase_N]) .."\n"
				-- )
	-- end
	
	
	phrase_N = phrase_N or 1
	
	local amt = self[pts].nV[phrase_N]
	local matching = true
	
	-- check against all same-type phrases
	for i = 1,self[pts].nP do
		if amt ~= self[pts].nV[i] then
			matching = false
		end
	end
	
	-- check against all opoopsite-type phrases
	for i = 1,self[pts].nP do
		if amt ~= self[pto].nV[i] then
			matching = false
		end
	end
	
	if not matching then
		print("=== Warning!!! Inconsistent number of values between phrases in object "..tostring(self).."!")
		if not gen_check then
		print("  = There are "..tostring(self[pts].nV[phrase_N]).." values in `object."..pts..".PG["..tostring(phrase_N).."]." )
		end
		for i = 1,self[pts].nP do
		print("  =`object."..pts..".nV["..tostring(i).."]` \t= "..tostring(self[pts].nV[i]) )
		end
		for i = 1,self[pto].nP do
		print("  =`object."..pto..".nV["..tostring(i).."]` \t= "..tostring(self[pto].nV[i]) )
		end
		print("  = Please use object:set_notes / object:set_delays to correct \n\tso that all values reported above are the same.\n")
	end
	
	return matching
end
