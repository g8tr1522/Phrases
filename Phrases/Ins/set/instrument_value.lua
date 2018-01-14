
--------------------------------------------------------------------------------
-- ins.set:instrument_value(value_or_string)
--
----sets the instrument value property (used for `Ins.get:note_column_table`)
--
--


return function (self, value_or_string)
	self = self.get_object	-- change self from `o.set` to `o`
	
	if type(value_or_string) == "string" then
		value_or_string = tonumber(value_or_string)
	end
	
	self.instrument_value = value_or_string
end
