tabler = {}
_root = 'Phrases.tabler.'


tabler["repeat"]					= require(_root..'repeat')
	tabler.all								= tabler["repeat"]
tabler["range"]						= require(_root..'range')

--functions used to create arrays that index other tables
tabler["idx"] 						= require(_root..'idx')
	tabler.indexer						= tabler.idx
tabler["idx_shuffled"]			=	require(_root..'idx_shuffled')
	tabler.shuffle_indices		= tabler.idx_shuffled
	tabler.shuffled_indices		= tabler.idx_shuffled
	tabler.random_indices 		= tabler.idx_shuffled
-- tabler["idx_reverse"]			=	require(_root..'idx_reverse')
	-- tabler.reverse_indices		= tabler.idx_reverse




return tabler

