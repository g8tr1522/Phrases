
--------------------------------------------------------------------------------
-- tabler.range(start, stop, step)
--
----
--

--future: 
-- allow descending ranges to be created when using center
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
	
--algorithm function (allows recursion)
	local algo = function(start, stop, step)
		local t = {}
		
		if start<stop then	--ascending
			for i=1,(1+math.floor((stop-start)/step)) do
				t[i] = start + step*(i-1)
			end
		elseif start>stop then	--descending
			for i=1,(1+math.floor((start-stop)/math.abs(step))) do
				t[i] = start + step*(i-1)
			end
		else
			t = {start}
		end
		
		return t
	end

--handle center argument	
	local t = {}
	
	if not center then
		t = algo(start,stop,step)
	else
		if stop < start then
			local tb = range(stop,start,-1*step,center)
			for i=1,#tb do
				t[i] = tb[#tb - (i-1)]
			end
			-- error("=== Warning for tabler.range!"
					-- .."  = `center` argument not supported for descending arrays"
					-- ,2)
		else
			local t1  = algo(center,start,step)
			local t2  = algo(center,stop, step)	
			-- now reverse the values in t1
			-- this loop skips the first element in `t1` so that `center` isn't included twice in `t`
			for i=1,(#t1-1) do 
				t[i] = t1[#t1 - (i-1)] 
			end
			-- now concatenate t1 and t2
			for i=1,#t2 do
				t[i + (#t1-1)] = t2[i]
			end
		end
	end	
	
	return t
end


return range
