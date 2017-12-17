
--------------------------------------------------------------------------------
-- tabler.
--
----
--

require('idx')
--require('Chance/chance')

idx_shuffle = function (last)
	t = idx(last)
	t = Phrases.chance.helpers.shuffle(t)
	
	return t
end


return idx_shuffle
