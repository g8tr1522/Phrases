
--------------------------------------------------------------------------------
-- ins.value_counter
--
----provides a closure for indexing through phrases
--
----The way this would be used, is to do 
--			object.vc = ins.value_counter()
--			object.vc(argt)
--
--
--


value_counter = function (self, set)
	--self = self.get_object	-- change self from `o.get` to `o`
	
	--if o:check_amt_of_vals_in_phrase() then
	--the above line should already have been asserted in ins.set_notes()
	local top = o.notes.nV[1]
	set = set or (top - 1)
	local count = set
	
	local counter = function (argt)
		if type(argt)=="number" then 
			count = count+argt
		elseif type(argt)=="table" then
			--- main functionality is here ---
			----------------------------------
			if argt.inc==true then
				count = count+1
				elseif argt.inc then
				count = count + argt.inc
			end 
			if argt.dec then
				count = count - argt.dec
			end 
			if argt.reset==true then
				count = top
			end
			----------------------------------
		--elseif type(argt)=="character" then
		end
		
		return 1 + (count % top)	 --also works for negative numbers
	end
	
	return counter
	--end
end


return value_counter

