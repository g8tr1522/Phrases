
--------------------------------------------------------------------------------
-- ins.get_phrase_strings
--
---- 'n' returns "notes" and "delays", 
--		and 'd' returns "delays" and "notes"
--
--
--
--
--
--
--
--
--
--
--


return function (phrase_type_char)
-- 'n' returns "notes" and "delays", and 'd' returns "delays" and "notes"
	if 			phrase_type_char 		 == 'n' then
					phrase_type_string 		= "notes"
					phrase_type_opposite 	= "delays"
	elseif 	phrase_type_char 		 == 'd' then
					phrase_type_string 		= "delays"
					phrase_type_opposite 	= "notes"
	end
	
	return phrase_type_string, phrase_type_opposite
end
