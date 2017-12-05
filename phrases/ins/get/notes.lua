
--------------------------------------------------------------------------------
-- ins.get.notes
--
----Shell function for ins.get.phrase
--
--


return function (self, notes_phrase_N)
	self = self.get_object	-- change self from `o.get` to `o`
	return self.get:phrase('n', notes_phrase_N)
end