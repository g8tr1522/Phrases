utils = {}
_root = "Phrases.utils."



utils["delays2pls"] = require(_root..'delays2pls')
utils["delay2pl"] 	= require(_root..'delay2pl')
utils["forvals"] 		= require(_root..'forvals')
utils["onvals"] 		= require(_root..'onvals')
--right now, preloaded package is "phrases.utils"

utils.iters = {}
utils["iters"] 			= require(_root..'_iters');	
--now, preloaded package is "phrases.utils.iters"
	--for some reason
	-- if this goes before onvals, then the preloaded package become
	-- "phrases.utils.iters", and calling 
	-- require(_root..'onvals')
	-- actually does require(_root.."iters.onvals")




return utils

