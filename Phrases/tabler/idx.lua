
--------------------------------------------------------------------------------
-- tabler.idx (last)
--
----Returns an array with elements {1,2,3, ... , last}
--	Used to index other arrays.
--	Mostly used as a subfunction in other tabler functions.
--	


return function (last)
	local t = {}
	for i = 1,last do
		t[i] = i
	end
	return t
end


