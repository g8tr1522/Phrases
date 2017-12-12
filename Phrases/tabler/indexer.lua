
--------------------------------------------------------------------------------
-- tabler.indexer (last)
--
----Returns an array with elements {1,2,3, ... , last}
--


return function (last)
	t = {}
	for i = 1,last do
		t[i] = i
	end
	return t
end


