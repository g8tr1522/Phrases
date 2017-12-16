tabler = {}
_root = 'Phrases.tabler.'


tabler["repeat"]					= require(_root..'repeat')
	tabler.all								= tabler["repeat"]

--functions used to create arrays that index other tables
tabler["idx"] 						= require(_root..'idx')
	tabler.indexer						= tabler.idx
tabler["idx_shuffle"]			=	require(_root..'idx_shuffle')
	tabler.shuffle_indices		= tabler.idx_shuffle
	tabler.random_indices 		= tabler.idx_shuffle
-- tabler["idx_reverse"]			=	require(_root..'idx_reverse')
	-- tabler.reverse_indices		= tabler.idx_reverse




return tabler