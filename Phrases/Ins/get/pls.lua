
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

return function (self)
	self = self.get_object	-- change self from `o.get` to `o`
	
	return self.delays.pl
end