Phrases = {}

-------------------------------------------------------------------------------
-- stash globals which may already be declared
-- if _mainroot   then local old_mainroot   = _mainroot   end
-- if _sourceroot~=nil then local old_sourceroot = _sourceroot end


-------------------------------------------------------------------------------
-- declare new globals for path names

--package.path = package.path .. ';./Phrases/?.lua'

_mainroot   = _phrasesroot or ''  -- path to where Phrases.lua is kept
_sourceroot = _mainroot .. "Phrases/"


-------------------------------------------------------------------------------
-- require source files

Phrases.chance	= require(_mainroot..'Chance/chance')

_folder_iters                        = _sourceroot.."iters/"
Phrases.iters                = require(_sourceroot..'iters')

_folder_tabler                       = _sourceroot.."tabler/"
Phrases.tabler 	             = require(_sourceroot..'tabler')

_folder_utils                        = _sourceroot.."utils/"
Phrases.utils 	             = require(_sourceroot..'utils')

_folder_DelaysMethods                = _sourceroot.."DelaysMethods/"
Phrases.DelaysMethods        = require(_sourceroot..'DelaysMethods')

--Phrases.NotesMethods = require('NotesMethods')

-- Ins must be required last since it requires other modules
_folder_Ins                          = _sourceroot.."Ins/"
Phrases.Ins 		             = require(_sourceroot..'Ins')


-------------------------------------------------------------------------------
-- Delete global path name variables

-- _mainroot   = old_mainroot
-- _sourceroot = old_sourceroot
_mainroot = nil
_sourceroot = nil

_folder_iters         = nil
_folder_tabler        = nil
_folder_utils         = nil
_folder_DelaysMethods = nil
_folder_Ins           = nil




return Phrases
