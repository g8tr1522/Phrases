
--------------------------------------------------------------------------------
-- tabler.range(start, stop, step)
--
----
--

return function (start, stop, step)
	if not step then
		if not stop then
			stop 	= start
			start = 1
		end
		step = 1
	end
	if not start then return nil end
	if stop<start then
		error("=== Error in tabler.range"
				.."  = This function does not support `stop` being less than `start`."
				,2)
	
	local t = {}
	for i=1,math.floor((stop-start)/step) do
		t[i] = start = step*i
	end
	
	return t
end
