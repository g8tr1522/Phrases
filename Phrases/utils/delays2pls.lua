
--------------------------------------------------------------------------------
-- utils.delays2pls (tn_delays, delays_UB, nopl)
--
----Returns a table of corresponding pattern line values, from a single delays phrase.
--
----Arguments:
--  - tn_delays (table of numbers) : delays phrase in traditional notation (ie, a table of delay values)
--  - delays_UB (number) : the upper-bound of the delays phrase.
--  - nopl (integer) : number of pattern lines.
--
--

delays2pls = function (tn_delays, delays_UB, nopl)
	local pl_delays = {}
	
	for i,v in ipairs(tn_delays) do
		pl_delays[i] = (v-1)/(delays_UB - 1) *nopl
	end
	
	return pl_delays
end

return delays2pls


