
--------------------------------------------------------------------------------
-- ins.is_valid_phrase_index
--
----check if we try to set `object.notes.[phrase_N]`, 
--		but `phrase_N` > `#object.notes`
--
--


return function (self, phrase_N, error_level)
	if error_level then
		error_level = error_level+1  -- raise outside of this function
	end
	
	if phrase_N > #self.notes then
		if error_level then		
			error("\n=== ERROR: bad phrase index!!\n"
						.."  = Tried setting `object.notes["..tostring(phrase_N).."]`,"
						.."  = But object only has "..tostring(#self.notes).." note phrases!"
						, error_level)
		else
			return false
		end 		
	else
		return true
	end
	
end
