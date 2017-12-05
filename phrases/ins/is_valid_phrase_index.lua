
--------------------------------------------------------------------------------
-- ins.is_valid_phrase_index
--
----check if we try to set phrase.PG[phrase_N], 
--		but `phrase_N` > #phrase.PG
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


return function (self, pts, phrase_N, error_level)
-- check if we try to set phrase.PG[phrase_N], but `phrase_N` > #phrase.PG
	if error_level then
		error_level = error_level+1  -- raise outside of this function
	end
	
	if phrase_N > self[pts].nP then
		if error_level then		
			error("\n=== ERROR: bad phrase index!!\n"..
						"  = Tried setting phrase in `object."..pts..".PG["..tostring(phrase_N).."]`!\n"..
						"  = But object (at "..tostring(self)..") is ins.subtype."..self.ins_subtype.."\n"..
						"    and only has "..tostring(self[pts].nP).." "..pts.." phrases!", error_level)
		else
			return false
		end 		
	else
		return true
	end
	
end
