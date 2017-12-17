
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
	print("function range is type "..type(range))
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
		
		if start<stop then
			for i=1,math.floor((stop-start)/step) do
				t[i] = start + step*(i-1)
			end
		elseif start>stop then
			for i=1,math.floor((start-stop)/step) do
				t[i] = start - step*(i-1)
			end
		else
			t = {start}
		end
		
		return t
	end
	
--handle center argument	
	if not center then
		local t = algo(start,stop,step)
	else
		if stop < start then
			error("=== Warning for tabler.range!"
					.."  = `center` argument not supported for descending arrays"
					,2)
		else
			local t1  = algo(center,start,step)
			local t2  = algo(center,stop, step)	
			-- now reverse the values in t1
			-- this loop skips the first element in `t1` so that `center` isn't included twice in `t`
			for i=2,#t1 do
				t[ #t1 - (i-2) ] = t1[i] 
			end
			-- now concatenate t1 and t2
			for i=1,#t2 do
				t[i + #t1] = t2[i]
			end
			
			return t
		end
	end	
	
	print("t is type "..type(t))
	return t
end


return range
