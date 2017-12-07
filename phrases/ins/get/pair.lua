
--------------------------------------------------------------------------------
-- ins.get.pair
--
----Return a note / pattern line pair
--
--
----Note to Author:
--
----This function is currently not in use.
----Needs to have options in case object has multiple notes or delays phrases.
--
--

delays2pl = require('phrases.utils.delays2pl')

function pair(self, vc_argt, notes_PGN, delays_PGN)
	self = self.get_object	-- change self from `o.get` to `o`
	
	notes_PGN  = notes_PGN or 1
	delays_PGN = delays_PGN or 1
	
	
	local n, pl, count
	count = self.vc(vc_argt)
	
	n  = self.notes.PG[1]
	pl = self.delays.PG[1]
	pl = delays2pl(pl)
	
	return n, pl
end

return pair
