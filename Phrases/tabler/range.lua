
--------------------------------------------------------------------------------
-- tabler.range(start, stop, step)
--
----
--

--future: 
-- allow descending ranges to be created
-- When using center arg, use a function that concatenates t1 and t2
--		also, a function that reverses t1
--


range = function (start, stop, step, center)
--handle input args
	if not step then
		if not stop then
			stop 	= start
			start = 1
		end
		if start<stop then
			step = 1
		elseif start>stop then
			step = -1
		end
	end
	
	if not start then return nil end
	
	local t = {}
	
	if center then
		if stop < start then
			print("=== Warning for tabler.range!")
			print("  = `center` argument not supported for descending arrays")
			t = range(stop,start,step,center)
		else
			local t1  = range(center,start,step)
			local t2  = range(center,stop, step)
			-- now reverse the values in t1
			local t1  = {}
			for i=1,#t1b do
				t[ #t1b - (i-1) ] = t1[i]
			end
			-- now concatenate t1 and t2
			for i=1,#t2 do
				t[i + #t1] = t2[i]
			end
			
			return t
		end
	end
				
--perform algorithm 
	if start<stop then
		for i=1,math.floor((stop-start)/step) do
			t[i] = start + step*(i-1)
		end
	else start>stop then
		for i=1,math.floor((start-stop)/step) do
			t[i] = start - step*(i-1)
		end
	else
		t = {start}
	end
	
	return t
end


return range
