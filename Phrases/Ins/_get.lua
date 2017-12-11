
--------------------------------------------------------------------------------
-- ins.get
--
-- module which holds all the get functions for ins.lua
--

get = {}
_root = "Phrases.Ins.get."


get.notes 	= require (_root.."notes")
get.delays 	= require (_root.."delays")
get.pls 		= require (_root.."pls")
--get.phrase 	= require (_root.."phrase")

get.note  	= require (_root.."note")
get.delay 	= require (_root.."delay")
get.pl  		= require (_root.."pl")
-- get.value 	= require (_root.."value")


return get
