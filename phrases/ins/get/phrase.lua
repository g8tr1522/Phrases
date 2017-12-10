
--------------------------------------------------------------------------------
-- ins.get.phrase
--
----Uses utils.forvals to return phrases (where phrase_N goes to Psel)
--
----Note to author:
--	- utils.forvals 				 is already loaded in ins.lua
--	- ins.get_phrase_strings is already loaded in ins.lua
--

return function (self, phrase_type_char, phrase_N)
	self = self.get_object	-- change self from `o.get` to `o`
	
	local pts = Ins.get_phrase_strings (phrase_type_char) 
	phrase_N = phrase_N or 0
	
	local rt = {}
	rt = utils.forvals(self[pts].PG, phrase_N, 0, function (v) return v end)
	return rt
end

