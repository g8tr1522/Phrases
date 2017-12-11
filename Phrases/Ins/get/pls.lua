
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

return function (self, phrase_N)
	self = self.get_object	-- change self from `o.get` to `o`
	
	phrase_N = phrase_N or 0 
	pl = {}
	
	pl = utils.forvals(self.delays.PG, phrase_N, 0, 
		function (v) --maybe the delays_UB and nopl can be provided as arguments here?
			return (v-1) /self.delays_UB *self.nopl
		end
	)
	
	return pl
end