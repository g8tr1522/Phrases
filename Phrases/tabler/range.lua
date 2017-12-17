
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


local FP_ERROR = 0.0000000001 -- fixes some floating point bugs
-- try doing `range(-2.1, 0, 0.7)` when FP_ERROR = 0 to get headaches

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
			print((stop-start)/step, math.floor((stop-start)/step + FP_ERROR))
			print("creating  ascending array with length ", 1+math.floor((stop-start)/step))
			for i=1,(1+math.floor((stop-start)/step+FP_ERROR)) do
				t[i] = start + step*(i-1)
			end
		elseif start>stop then	--descending
			print("creating descending array with length ", 1+math.floor((start-stop)/math.abs(step)))
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
		if stop < start then	--descending
			local tb = range(stop,start,-1*step,center)
			for i=1,#tb do
				t[i] = tb[#tb - (i-1)]
			end
			-- error("=== Warning for tabler.range!"
					-- .."  = `center` argument not supported for descending arrays"
					-- ,2)
		elseif (start<=center) and (center<=stop) then	--ascending
			start = center - (math.floor((center-start)/step) * step)
			--print("new start would be", center - (math.floor((center-start)/step)) * step)
			print("new start would be", start)
			stop  = center + (math.floor((stop -center)/step) * step)
			--print("new stop would be", center + (math.floor((stop-center)/step)) * step)
			print("new stop would be", stop)
			
			t = algo(start,stop,step)
			
			-- print("start,stop,step,center", start,stop,step,center)
			-- local t1  = algo(center,start,-1*step)
			-- local t2  = algo(center,stop,    step)	
			-- print("t1 :",table.unpack(t1))
			-- print("t2 :",table.unpack(t2))
			-- -- now reverse the values in t1
			-- -- this loop skips the first element in `t1` so that `center` isn't included twice in `t`
			-- for i=1,(#t1-1) do 
				-- t[i] = t1[#t1 - (i-1)] 
			-- end
			-- -- now concatenate t1 and t2
			-- for i=1,#t2 do
				-- t[i + (#t1-1)] = t2[i]
			-- end
		end
	end	
	print()
	return t
end


return range
