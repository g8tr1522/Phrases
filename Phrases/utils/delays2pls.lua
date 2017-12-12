
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
	--any print functions here are for debugging
	-- print("--- calling delays2pls")
	-- print("  - tn_delays is ",table.unpack(tn_delays) )
	-- print("  - delays_UB is ",delays_UB)
	-- print("  - nopl      is ",nopl)
	
	for i,v in ipairs(tn_delays) do
		tn_delays[i] = (v-1)/(delays_UB - 1) *nopl
	end
	
	-- print("  - tn_delays is ",table.unpack(tn_delays) )
	-- print()
	return tn_delays
end

return delays2pls


