# Things to do in the future

This is my to do list.

Note: many files have comments with the word "future" or "Future improvements".
	Search for these comments to find things which may not be included here.

I put the sections in order of highest priority to lowest.



-------------------------------------------------------------------------------
## Known bugs
(none, afaik)



-------------------------------------------------------------------------------
## Necessary improvements
- fix Ins.print_info() to adopt new functionality in Ins.set:notes()
- error messages in `Ins.set:delays` don't work as expected
	- (when checking for `self.nopl` and `self.delays.top`)
	- Test by setting one or the other, or none, and see if messages print out.


-------------------------------------------------------------------------------
## Bad patches
- what the hell is going on in tabler.range.lua? 
	- See comments about FP_ERROR
	- May want to look at commit 'de8152a'



-------------------------------------------------------------------------------
## Implementation Improvements
- are all error functions raised to the proper level?
- newlines in errors/warnings : beginning or end?
	- try to make messages print out nice in xStream and when debugging in CMD



-------------------------------------------------------------------------------
## Efficiency Improvements
- In `Ins.make_object`, `argt.nonp` isn't completely necessary.
	- This is because `Ins.set:notes` allows new note phrases to be instantiated.
	- The only purpose `argt.nonp` serves is to give warnings when 
		`Ins.set:notes` is called.



-------------------------------------------------------------------------------
## Future feature ideas 




===============================================================================
# Organizing this library


-------------------------------------------------------------------------------
## Library location in xStream
- Ultimately, I want to have 'Phrases.lua' be in the same folder as 
"com.renoise.xStream.xrnx/source/." and the "Phrases/Phrases/." source folder 
inside that directory as well. 
- I would like to have all the files in "Phrases/." (which aren't 'Phrases.lua')
be unincluded. 
- If I could specify (maybe in "xStream-fork-thing/.gitsubmodule") a way
to 'un-include' these files, then I'd do that. AFAIK, there's no such way to do 
such a thing.
- For the time being, the Phrases submodule is kept in the root directory of 
xStream. And AFAIK, it works the same both ways.

-------------------------------------------------------------------------------
## chance submodule
- Is there a way to include it in xStream without making it a table entry in
the Phrases module?
- ie, it's its own separate submodule.
- The issue is that xStream only allows just *one* more require in main.lua.
Any other requires produces strange errors. 

-------------------------------------------------------------------------------
## `utils`
- As of now, utils is kind of a mixed bag of functions. 
- I intend for it to be any functions which are used in the `Ins` class, but
the user may have use for (outside of the `Ins` class).


===============================================================================
# How do I encapsulation
- The `Ins` class has zero encapsulation.
- I haven't bothered with encapsulation so far.
- Things that should definitely be private and only object/class accessible:
	- `o.count`
		- The user modifies this by accessing the `o.vc` method
		- `o.vc` in turn uses and modifies `o.count`.
	- The `Ins` class should be fully protected 

