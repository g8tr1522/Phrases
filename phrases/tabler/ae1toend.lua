
--------------------------------------------------------------------------------
-- tabler.ae1toend (endd)
--
----Returns an array with elements {1,2,3, ... , endd}
--


return function (endd)
	t = {}
	for i = 1,endd do
		t[i] = i
	end
	return t
end


