ins_subtypes = {}

--------------------------------------------------------------------------------
-- instrument subtypes

ins_subtypes["test"] 						= require('ins_subtypes.test')
ins_subtypes["null"]						= require('ins_subtypes.null')

ins_subtypes["monophonic_lead"] = require('ins_subtypes.monophonic_lead')
ins_subtypes["mp_lead"] 				= require('ins_subtypes.monophonic_lead')
ins_subtypes["monophonic"]			= require('ins_subtypes.monophonic_lead')





return ins_subtypes
