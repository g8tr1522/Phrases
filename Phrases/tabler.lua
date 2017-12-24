tabler = {}
_folder_tabler = _folder_tabler or 'Phrases.tabler.'


tabler["repeat"]					= require(_folder_tabler..'repeat')
	tabler.all								= tabler["repeat"]
tabler["range"]						= require(_folder_tabler..'range')

--functions used to create arrays that index other tables
tabler["idx"] 						= require(_folder_tabler..'idx')
	tabler.indexer						= tabler.idx
tabler["idx_shuffled"]			=	require(_folder_tabler..'idx_shuffled')
	tabler.shuffle_indices		= tabler.idx_shuffled
	tabler.shuffled_indices		= tabler.idx_shuffled
	tabler.random_indices 		= tabler.idx_shuffled
-- tabler["idx_reverse"]			=	require(_folder_tabler..'idx_reverse')
	-- tabler.reverse_indices		= tabler.idx_reverse




return tabler

