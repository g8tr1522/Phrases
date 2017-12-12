
--------------------------------------------------------------------------------
-- utils.delay2pl (delay, delays_UB, nopl)
--
----Returns a corresponding pattern line value, from a single delay value.
--
----Arguments:
--  - delay (number) : a single delay value.
--  - delays_UB (number) : the upper-bound of the delays phrase.
--  - nopl (integer) : number of pattern lines.
--
--


return function (delay, delays_UB, nopl)
	return (delay - 1) /delays_UB *nopl
end


