
--------------------------------------------------------------------------------
-- utils.forvals (PG, Psel, Vsel, func)
--
----Works similarly to utils.onvals.
--	Only difference is that instead of modifying the group directly,
--		we just return a newly created group.
--  Also, if Psel is number, then we return the phrase table, not a group.
--		When doing this, Vsel will be ignored.
--
----Be careful! if Psel is not a contiguous sequence, 
--			then doing things like `unpack(rg)` may produce unexpected results!
--
----For Author: lines that are different from onvals are marked with "--!"
--

forvals = nil
idx = require('Phrases.tabler.indexer')

forvals = function (PG, Psel, Vsel, func)
	if PG.PG then
		PG = PG.PG	--this allows user to pass `object.notes` to PG instead of `object.notes.PG`
	end
	
	local rg = {}	--return group					--!
	
	if type(Psel)=="number" then
		if Psel==0 then 
			Psel = idx(#PG)
		else
			for i,v in ipairs(PG[Psel]) do		--!	
				rg[i] = v												--!	--Vsel will be ignored.
			end																--!
			return rg													--!	--rg is a table, not a group
		end
	end
	
	if type(Vsel)=="number" then
	
		if Vsel==0 then 
			for i,p in ipairs(Psel) do
				rg[p] = {}											--!
				for v= 1,#PG[p] do
					rg[p][v] = func( PG[p][v] )		--!
				end
			end 
			
		else
			for i,p in ipairs(Psel) do
				rg[p] = {}											--!
				for i,v in ipairs(Vsel) do
					rg[p][v] = func( PG[p][v] )		--!
				end
			end 
			
		end
	end
	
	return rg															--!
end

return forvals
