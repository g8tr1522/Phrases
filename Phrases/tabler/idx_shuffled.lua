
--------------------------------------------------------------------------------
-- tabler.
--
----
--

--require(_folder_tabler..'idx')
--require('Chance/chance')
local shuffle = lam.basic.shuffle

idx_shuffle = function (last)
	local t = idx(last)
	t = shuffle(t)
	
	return t
end


return idx_shuffle
