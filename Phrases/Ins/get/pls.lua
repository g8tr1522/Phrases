
--------------------------------------------------------------------------------
-- ins.get.pls 
--
----Get the delays, but in pattern lines
--
----Returns Nth phrase in the delays group as a table of pattern lines.
-- 	If phrase_N is 0, then return all delays phrases as a group of tables of pattern lines.
-- 	Phrase_N can also be a table of which phrases you want to get back. (not recommended)
--
----Note to author:
--	- utils.forvals is already loaded in ins.lua
--
--

delays2pl = require("Phrases.utils.delays2pl")

return function (self, phrase_N)
	self = self.get_object	-- change self from `o.get` to `o`
	
	pls = {}
	
	for i,v in ipairs(self.delays) do
		pls[i] = delays2pl(v, self.delays_UB, self.nopl)
	end
	
	return pls
end