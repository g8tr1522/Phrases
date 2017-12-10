Phrases = {}


---- Deprecated require style which relies on main being in the level above this file.
-------------------------------------------------------------------------------
-- __mainroot = 'Phrases.' --this is the location of the main file that requires this file

-- Phrases.Ins 		= require(__mainroot..'Ins')
-- Phrases.mDelays = require(__mainroot..'mDelays')
-- --Phrases.mNotes = require('Phrases.mNotes')

-- Phrases.utils 	= require(__mainroot..'utils')
-- --Phrases.utils.iters = require('Phrases.utils.iters')

-- Phrases.tabler 	= require(__mainroot..'tabler')



---- 'safer' require style, which assumes that main is where the `..` is in the below statement. (ie, in the assignment to package.path)
---- This style is appropriate if the Phrases submodule repo lies in the root directory of xStream.
-------------------------------------------------------------------------------
package.path = package.path .. ';./Phrases/?.lua'

Phrases.Ins 		= require('Ins')
Phrases.DelaysMethods = require('DelaysMethods')
--Phrases.NotesMethods = require('NotesMethods')

Phrases.utils 	= require('utils')
--Phrases.utils.iters = require('Phrases.utils.iters')

Phrases.tabler 	= require('tabler')





return Phrases
