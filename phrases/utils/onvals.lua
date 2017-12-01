
--------------------------------------------------------------------------------
-- utils.onvals (PG, Psel, Vsel, func)
--
----Args:
--	- PG   (array of phrases) : phrase group
--  - Psel (array of numbers) : selects which phrases to do
--  - Vsel (array of numbers) : selects which values to do in all phrases
--  - func (function) : a single-argument function. 
--				All values in PG will be modified according to func(v).
--
----Works kind of like an iterator.
--	
----Basic call : onvals(PG, Psel, Vsel, func)
--	if PG has three phrases, all with 7 vals, then
--			`utils.onvals(PG, {2,3}, {1,7}, function (v) do v = v+1 end )`
--  This will add 1 
--			to the first and last values 
--			in the 2nd and 3rd phrases of PG.
--
----sugar: 
--	-Psel and Vsel can be a number. Then onvals only applies func to that phrase/value.
--	-If Psel or Vsel are 0, then onvals will apply func to all phrases/values.
--  -`onvals(PG, 0,0, func)`
--		This applies func to all values in all phrases in PG.
--	-`onvals(PG, Psel, 0, func)`
--		This applies func to all values in the phrases selected by Psel.
--  -`onvals(PG, 0, Vsel, func)`
--		This applies func to the values specified in Vsel, and to all phrases.
--

onvals = nil
idx = require('phrases.tabler.ae1toend')

onvals = function (PG, Psel, Vsel, func)

	if type(Psel)=="number" then
		if Psel==0 then 
			Psel = idx(#PG)
		else
			Psel = {Psel}
		end
	end
	
	if type(Vsel)=="number" then
	
		if Vsel==0 then 
			for i,p in ipairs(Psel) do
				for v= 1,#PG[p] do
					PG[p][v] = func( PG[p][v] )
				end
			end 
			
		else
			for i,p in ipairs(Psel) do
				for i,v in ipairs(Vsel) do
					PG[p][v] = func( PG[p][v] )
				end
			end 
			
		end
	end
	
end

return onvals
