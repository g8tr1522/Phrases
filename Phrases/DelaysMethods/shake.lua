--DelaysMethods.shake
--Shift (or shake) the delay of note_N by at least (the third arg)

--[=[ mini documentation
- arguments (only one optional arg):
		note_N (integer or table): 
			We will shift the Nth note/delay value by at least oparg1.
			If note_N is a table with a single value {n}, then we will only shift note n.
			If note_N is a table with several values {n1, n2, n3, ...}, 
				then we will shift all of those notes, 
				where their bounds are obtained from the initial version of dels_tt.
			If note_N is an integer M, 
				then we will randomly pick M different delays, and shift those notes.
			If note_N = -1, then shift the delays of all notes.
		oparg1 (float) (default = 0.25): 
			The minimum amount of delay to shift by. 
			Must be in traditional time.
			AKA min_delay in implementation.
- explanation:
		If we want the fourth note to be shifted by at least an eigth note, 
			then we call foo like this:
			obj:shake_delay({4}, 0.125)
- example:
		Lets say our dels_tt table has 5 notes, 
			and the traditional delays ("dels_traditional") are
			{1,2, 3.25,3.75,4}.
		We call foo just like above: 
			obj:shake_delay({4}, 0.125)
		The traditional delays in the new version of dels_tt table will then be:
			{1, 2, 3.25, X, 4}
			where X could be any of these randomly chosen values:
			X : [3.375, 3.5, 3.625, 3.75, 3.875]
- notes:
		- About boundaries of possible delays:
		Delays are 'stuck between' the notes next to them.
		This is because mutate functions are only intended for monophonic melodies. 
		In the example, X could not have been (e.g.) 4.0 or 4.125 because note 5 has a delay of 4.
		This is why the function is called 'shake_delay'
- Future improvements: 
		Allow a 2nd oparg which specifies whether 
			oparg1 (the minimum delay) is in traditional time, or in pattern lines.
		Will multiple calls to math.random() generate different results, even if the seed is set before calling foo?
			If so, then maybe 'pause' the seed at the beginning of the call, and 'resume' it at the end.
		
--]=]---[=[--

unpack = unpack or table.unpack -- Renoise API uses unpack, not table.unpack


shake = function (self, note_N, ... )
	self = self.get_object	-- change self from `o.dm` to `o`
	
--handle arguments
	--handle optional argument
	local min_delay = nil
	if #{...}==0 then
		min_delay = 0.25
	else
		min_delay = ...
	end
	
	--create a table if note_N was an integer
	if type(note_N) == "number" then
		local rndm_Ns = {}
		for ii = 1,self.N do
			rndm_Ns[ii] = ii	--this is the table {1,2,3,4, ... , self.N}
		end
		
		if 	   note_N == -1 then
			note_N = rndm_Ns	--this if part is unnecessary and needs to be removed
		elseif note_N == 0  then
			return 	--don't change any delays
		elseif note_N >  0  then
			local rand_index = nil 
			local ii = self.N
			
			while ii > note_N do
				rand_index = math.random(1, #rndm_Ns)
				table.remove(rndm_Ns, rand_index)
				ii = ii-1
			end
		end
		
		note_N = rndm_Ns
	elseif type(note_N) == "table" then
		--here, just warn the user if he provides an index outside the range of dels_tt
		local maxidx = math.max(unpack(note_N))
		local minidx = math.min(unpack(note_N))
		if (maxidx > self.N) or (minidx < 1) then
			error("Error in shake_delay : argument note_N : table must be indices for dels_tt. ie, indices are out of range",2)
		end
	end
	
	
--main part here
	local indices = note_N	--we're transferring the input arg to a new var here. 
			 note_N = nil		--The loop below will refer to note_N, but note_N will just be the currently selected value in indices
	local new_dels_tt = self.dels_tt	--this will temporarily hold the new delays. (We call set_delays at the end of foo)
	
	for k,v in pairs(indices) do
		note_N = v
		
		local dmin, dmax = nil
			
		--decide min and max values of new possible delays
		if 		note_N == 1      then
			--if first note
			dmin = 1
			dmax = -min_delay + self.dels_tt[2] 
		elseif 	note_N == self.N then
			--if last note
			dmax = -min_delay + self.dels_tt_max
			dmin =  min_delay + self.dels_tt[self.N-1] 	--next to last note delay plus min_delay
		else
			dmin =  min_delay + self.dels_tt[note_N - 1]
			dmax = -min_delay + self.dels_tt[note_N + 1]
		end
		
		--now create a table of possible new delays
		local possibly = {}
		local ii = 0	--table index for following loop
		for val = dmin,dmax,min_delay do
			ii  = ii+1
			possibly[ii] = val
		end
		
		--replace old delay (for note note_N) with new one
		local new_delay 	= possibly[math.random(1,ii)] 
		new_dels_tt[note_N] = new_delay
	end
	
	--self.dels_pl = nil
	print("    in shake_delay, getmetatable( self ) = "..tostring(getmetatable(self)) )
	self.set_delays(self, new_dels_tt)
	
	
end

return shake
