ins_subtypes = {}

--------------------------------------------------------------------------------
-- instrument subtypes
_ISpath = 'Phrases.ins_subtypes.'

ins_subtypes["test"] 						= require(_ISpath..'test')
ins_subtypes["null"]						= require(_ISpath..'null')

ins_subtypes["monophonic_lead"] = require(_ISpath..'monophonic_lead')
ins_subtypes["mp_lead"] 				= require(_ISpath..'monophonic_lead')
ins_subtypes["monophonic"]			= require(_ISpath..'monophonic_lead')





return ins_subtypes
