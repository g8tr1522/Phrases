
--------------------------------------------------------------------------------
-- tabler.range(start, stop, step, center)
--
----Returns a table representing the specified range.
--
----About `center`:
--	If you want your range to be centered about a certain value, then all 4 args must be supplied.
--	Example:
--		range(-8.1, 9, 4, 0)  -->  {-8, -4, 0, 4, 8}
--


local FP_ERROR = 0.0000000001 -- fixes some floating point bugs with math.floor
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
			for i=1,(1+math.floor((stop-start)/step+FP_ERROR)) do
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

--handle center argument, or perform algo without it
	local t = {}
	
	if not center then
		t = algo(start,stop,step)
	else
		
		if stop < start then	--descending
			local tb = range(stop,start,-1*step,center)
			for i=1,#tb do
				t[i] = tb[#tb - (i-1)]
			end
			
		elseif (start<=center) and (center<=stop) then	--ascending
			start = center - (math.floor((center-start)/step) * step)
			stop  = center + (math.floor((stop -center)/step) * step)
			t = algo(start,stop,step)
			
		end
	end	
	
	return t
end


return range
