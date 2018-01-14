
--------------------------------------------------------------------------------
-- ins.get
--
-- module which holds all the get functions for ins.lua
--

get = {}
_root = (_folder_Ins..'get/') or "Phrases.Ins.get."


get.notes 	                  = require (_root.."notes")
get.delays 	                  = require (_root.."delays")
get.pls 		                  = require (_root.."pls")
--get.phrase 	= require (_root.."phrase")

get.note  	                  = require (_root.."note")
get.delay 	                  = require (_root.."delay")
get.pl  		                  = require (_root.."pl")
get.delay_mantissa            = require (_root.."delay_mantissa")
	get.mantissa                  = get.delay_mantissa
get.delay_column_value        = require (_root.."delay_column_value")
	get.dcval                     = get.delay_column_value
	get.DCval                     = get.delay_column_value
	get.dcv                       = get.delay_column_value
	get.DCV                       = get.delay_column_value
	get.delay_column              = get.delay_column_value
	
get.xline_note_columns_table  = require (_root.."xline_note_columns_table")
	get.note_columns_table        = get.xline_note_columns_table
	get.notecol                   = get.xline_note_columns_table
	get.xlineNCT                  = get.xline_note_columns_table
	get.NCT                       = get.xline_note_columns_table
	get.nct                       = get.xline_note_columns_table
	get.xlnct                     = get.xline_note_columns_table
	get.xlNCT                     = get.xline_note_columns_table


return get
