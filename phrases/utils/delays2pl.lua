
--------------------------------------------------------------------------------
-- utils.delays2pl (phrase, delays_UB, nopl)
--
----Returns a table of corresponding pattern line values, from a single delays phrase.
--
----Arguments:
--  - phrase (table of numbers) : a single delays phrase.
--  - delays_UB (number) : the upper-bound of the delays
--  - nopl (integer) : number of pattern lines.
--
--


return function (phrase, delays_UB, nopl)
-- converts a single delay phrase to pattern lines
	for i = 1,#phrase do
		phrase[i] = (phrase[i] - 1) /delays_UB *nopl
	end
	
	return phrase
end


