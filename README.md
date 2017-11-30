# Phrases
My testing grounds for code I plan to eventually add as a fork in the Renoise tool, xStream.


## What will this eventually be?
As of now, once I can get this skeleton built and working, then I will create a fork in xStream 
(https://github.com/renoise/xrnx/tree/master/Tools/com.renoise.xStream.xrnx). 
I'll port this repo over to the fork I make, and complete this project over there.


## Short Term Goals
 - Get the skeleton working in plain Lua.
 - Then get it working in xStream.
 - Port this repo to my xStream fork (yet to be made).
 - Add the rest of the flesh over there. 


## For the Public:
Wow, I wasn't expecting guests! 

If you have any suggestions, I'm actually really wanting them. Three specific things I need help with: 
 - Making my screwy metatables/modules setup more elegant and efficient.
 - Adding fancy iterators for the setters/getters for the `notes` and `delays` properties of the `ins` class.
 - Should I convert all this to luabind classes? I'm very comfortable using my own lua OOP system, and I'll only go to luabind if there are significant advantages that I can't achieve otherwise.

A summary about what inspired this: 
I've made several attempts at hitting the books and finding a music software that takes advantage of algorithmic composition techniques. Renoise is my first DAW, but my first foray into xStream was discouraging. Recently, I noticed the new added documentation. Once I wrote a few cool modules, I needed my own library. I figured out how to add my own stuff to xStream, and now I'm going to make a big ol' library to streamline my module-creation process.

About me:
I'm not a good programmer at all. I think this is a good idea though. This is also my first ever attempt at a library. 



# General (desired) Organization Scheme
- Phrases (main module)
    - This is the main file to link together the entire library.
    - All submodules of this are listed below.
    - Submodules are to be used like `phrases.submodule.foo()`
    
- ins
    * The main object of this library.
    * has two main properties: `notes` and `delays`. The latter of which controls the timings for the notes. (See section 'about notes and delays')
    * methods that manipulate `notes` and `delays` should be called like this: `obj.m_notes:transpose()`
- m_notes
    * can manipulate a table of `note` values.
    * can also be called as a method of `ins`
    * yes, I'd like these to be called without the reference of an `ins` object. 
      Think: `new_note_table = phrases.m_notes.transpose(old_note_table)`
- m_delays
    * see m_notes
- ac
    * other miscellaneous functions that are algorithmic composition related, but that don't fit in `m_notes` and `m_delays`.
    * a lot of these will be array generators. 
    * a lot of these will be probability-related.
    * really just anything I miss from Sonic Pi. 
- utils
    * functions that are specific to using my screwy library system.
    * not for making music, but (mostly) for manipulating the `ins` objects.
    

## `notes` and `delays`
todo
