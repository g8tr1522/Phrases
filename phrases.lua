phrases = {}


---- Deprecated require style which relies on main being in the level above this file.
-------------------------------------------------------------------------------
-- __mainroot = 'phrases.' --this is the location of the main file that requires this file

-- phrases.ins 		= require(__mainroot..'ins')
-- phrases.mDelays = require(__mainroot..'mDelays')
-- --phrases.mNotes = require('phrases.mNotes')

-- phrases.utils 	= require(__mainroot..'utils')
-- --phrases.utils.iters = require('phrases.utils.iters')

-- phrases.tabler 	= require(__mainroot..'tabler')



---- 'safer' require style, which relies on main being where the `..` is in the following statement
---- This style is appropriate if the Phrases submodule repo lies in the root directory of xStream.
-------------------------------------------------------------------------------
package.path = package.path .. ';../Phrases/phrases/?.lua'

phrases.ins 		= require('ins')
phrases.mDelays = require('mDelays')
--phrases.mNotes = require('phrases.mNotes')

phrases.utils 	= require('utils')
--phrases.utils.iters = require('phrases.utils.iters')

phrases.tabler 	= require('tabler')





return phrases