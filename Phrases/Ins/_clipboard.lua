
--------------------------------------------------------------------------------
-- ins.clipboard
--
-- module which holds all the clipboard functions for ins.lua
--

clipboard = {}
_root = "Phrases.Ins.clipboard."


clipboard.cut 		= require (_root.."cut")
clipboard.copy 		= require (_root.."copy")
clipboard.paste 	= require (_root.."paste")


return clipboard
