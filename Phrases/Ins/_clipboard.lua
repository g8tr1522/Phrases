
--------------------------------------------------------------------------------
-- ins.clipboard
--
-- module which holds all the clipboard functions for ins.lua
--

clipboard = {}
_root = (_folder_Ins..'clipboard/') or "Phrases.Ins.clipboard."


clipboard.cut 		= require (_root.."cut")
clipboard.copy 		= require (_root.."copy")
clipboard.paste 	= require (_root.."paste")
clipboard.remove 	= require (_root.."remove")
clipboard.insert 	= require (_root.."insert")


return clipboard
