
--------------------------------------------------------------------------------
-- tabler.
--
----
--

require(_folder_tabler..'idx')
--require('Chance/chance')

idx_shuffle = function (last)
	local t = idx(last)
	t = Phrases.chance.helpers.shuffle(t)
	
	return t
end


return idx_shuffle
