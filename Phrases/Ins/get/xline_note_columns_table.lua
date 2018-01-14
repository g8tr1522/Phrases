
--------------------------------------------------------------------------------
-- ins.xline_note_columns_table
--
---- gets relevant values to assign to `xline.note_columns[...]`
--
--
--
--
--
--
--
--
--
--
--


return function (self, col_name, idx)
	local col_name = col_name or 1
	local idx = idx or self.count
	
	local note_col_table = {
		instrument_value = self.instrument_value          or 0,
		note_value       = self.notes[col_name][idx]      or EMPTY_NOTE_VALUE or 0,
		volume_value     = self.default_volume_value      or 64, -- or EMPTY_VOLUME_VALUE
		delay_value      = self.get:delay_column_value()  or 0,
	}
	
	return note_col_table
end
