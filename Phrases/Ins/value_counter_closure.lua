
--------------------------------------------------------------------------------
-- Ins.value_counter_closure
--
----This closure is kept in Ins. 
--	When an object is instantiated from Ins, 
--		this closure returns its inner function, value counter.
--	The object then calls the function to
--
--
--
--
--


value_counter_closure = function ()

	local value_counter = function (self, argt)
		local count = self.count
		
		if type(argt)=="table" then
			--- main functionality is here ---
			----------------------------------
			if argt.inc then
				count = count + argt.inc
			end 
			if argt.dec then
				count = count - argt.dec
			end 
			if argt.reset==true then
				count = 1
			end
			----------------------------------
		elseif type(argt)=="number" then 
			count = argt
		--elseif type(argt)=="character" then
		else
			return self.count
		end
		
		
		local top = #self.notes[1]
		count = count % top
		
		if count==0 then count=top end
		
		self.count = count
		return count
	end
	
	return value_counter
end


return value_counter_closure

