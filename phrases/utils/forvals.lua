
--------------------------------------------------------------------------------
-- utils.forvals (PG, Psel, Vsel, func)
--
----Works similarly to utils.onvals.
--	Only difference is that instead of modifying the group directly,
--		we just return a newly created group.
--
----Be careful! if Psel is not a contiguous sequence, 
--			then doing things like `table.unpack(rg)` may produce unexpected results!
--
----For Author: lines that are different from onvals are marked with "--!"
--

forvals = nil
idx = require('phrases.tabler.ae1toend')

forvals = function (PG, Psel, Vsel, func)
	if PG.PG then
		PG = PG.PG	--this allows passing of object.notes instead of object.notes.PG
	end
	
	local rg = {}	--return group					--!
	
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
