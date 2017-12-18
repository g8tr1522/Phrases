
--------------------------------------------------------------------------------
-- tabler.repeat (N, object)
--			 .all
--
----Returns an array with `N` elements of `object`
--



return function (N, object)
	local rt = {}
	
	if N == 0 then
		rt[1] = 0
	else
		for i = 1,N do
			rt[i] = object
		end
	end
	
	return rt
end