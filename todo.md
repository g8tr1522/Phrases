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



