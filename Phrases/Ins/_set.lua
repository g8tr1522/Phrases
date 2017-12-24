
--------------------------------------------------------------------------------
-- ins.set
--
-- module which holds all the set functions for ins.lua
--

set = {}
_root = (_folder_Ins..'set/') or "Phrases.Ins.set."


set.notes 			= require (_root.."notes")
--set.notes_group = require (_root.."notes_group")
set.delays 			= require (_root.."delays")

-- set.note  	= require (_root.."note")
-- set.delay 	= require (_root.."delay")


return set
