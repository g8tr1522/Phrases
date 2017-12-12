
--------------------------------------------------------------------------------
-- ins.get:notes(Psel)
--
----Uses utils.forvals to return selected notes phrases
--
--


return function (self, Psel)
	self = self.get_object	-- change self from `o.get` to `o`
	
	Psel = Psel or 0
	return utils.forvals(self.notes, Psel, 0, function (v) return v end)
end