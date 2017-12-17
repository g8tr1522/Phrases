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


shake = function (self, argt)
--fix between object method call and detatched function call
	if self.get_object then
		self = self.get_object	-- change self from `o.dm` to `o`
		temp = self.delays.tn		-- set temporary table
	else
		temp = argt.table or self	-- if we do a detatched function call
	end
	--`temp` is now the table this function operates on
	
--handle arguments table
	--minimum delay jump
	if argt.min_delay = nil then
		argt.min_delay = 0.25
	end
	
	--Vsel 
	local Vsel_was_number = false
	
	if type(argt.Vsel)="number" then
		--Vsel_was_number = true
		--argt.Vsel = {argt.Vsel}
		local number = argt.Vsel
		argt.Vsel = Phrases.tabler.idx_shuffled(#temp)
		if number <= #temp then
			for i=1,(#temp-number) do
				argt.Vsel[#argt.Vsel] = nil
			end
		end	--future: if number is larger than the number of delays, then do something
	elseif type(argt.Vsel)="table" then	--check for table of indices
		if type(argt.Vsel[1])~="number" then
			error("=== Error in DelaysMethods.shake"
					.."  = Argument Vsel should be a table of numbers."
					.."  = These numbers will correspond to the indices to operate over.", 2)
		end
	elseif type(argt.Vsel)="string" then
		if argt.Vsel="all" then
			argt.Vsel = Phrases.tabler.idx( #temp )
		end
	else
		error("=== Error in DelaysMethods.shake"
				.."  = Argument Vsel should be either ..."
				.."\t\t- a table of indices"
				.."\t\t- a number"
				.."\t\t- a string", 2)
	end 
	
	--shuffle Vsel
	if argt.random==true or argt.shuffle==true then
		if Vsel_was_number then
		else
			local foo = require('Chance.chance.helpers.shuffle')
			argt.Vsel = foo(argt.Vsel)
		end
	end
	
	
--main part here
	for _,v in ipairs(argt.Vsel) do
		
	
	
end


return shake
