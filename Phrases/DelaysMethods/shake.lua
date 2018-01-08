--DelaysMethods.shake{ min_delay, Vsel, shuffle }
--Shift (or shake) a table of delays by at least `min_delay`

--[=[ mini documentation

- arguments :
		Note that arguments are provided in a table.
		- min_delay (number) (default = 0.25) : 
				The minimum delay amount to jump by.
		- Vsel (table, number, or string) (default = "all"):
				If a table, then the elements in Vsel correspond to indices in the delays table 
					to perform the algorithm on.
				If a number, then perform the algorithm on that many elements (randomly selected).
				If a string, then provide the string "all" to shake all elements.
		- shuffle (boolean) (default = true) :
				If true, then shuffle whatever Vsel was.
				
- explanation:
		If we want the fourth note to be shifted by at least an eigth note, 
			then we call foo like this:
			obj:shake_delay{0.125, {4}}
			
- example:
		Lets say object.delays.tn has 5 notes :
			{1, 2, 3.25, 3.75, 4}.
		We call shake just like above: 
			obj:shake_delay{0.125, {4}}
		The traditional delays in the new version of dels_tt table will then be:
			{1, 2, 3.25, X, 4}
			where X could be any of these randomly chosen values:
			X : [3.375, 3.5, 3.625, 3.75, 3.875]
			
- About boundaries of possible delays:
		Delays are 'stuck between' the notes next to them.
		This is because an Ins object is 'monophonic' in a sense. 
		In the example, X could not have been (e.g.) 4.0 or 4.125 because 
				note 5 has a delay of 4.
		This is why the function is called 'shake' - imagine shaking 
				a tube with large rocks in it - the rocks could not slip 
				past each other no matter how hard you shook the tube.
				Thus, the notes can not be shaken past each other.
		
- future improvements: 
		Allow a 2nd oparg which specifies whether 
			oparg1 (the minimum delay) is in traditional time, or in pattern lines.
		Will multiple calls to math.random() generate different results, even if the seed is set before calling foo?
			If so, then maybe 'pause' the seed at the beginning of the call, and 'resume' it at the end.
			Or provide additional arguments to set seeds to certain `chance` calls.
		Allow notes to shake past each other. Use clipboard functions to accomplish this.
		
--]=]---[=[--

unpack = unpack or table.unpack -- Renoise API uses unpack, not table.unpack
local idx          = lam.make.idx
local idx_shuffled = lam.make.idx_shuffled
local range   = lam.make.range
local shuffle = lam.basic.shuffle


shake = function (self, argt)
	local temp = {}	--`temp` is now the table this function operates on
	
--fix between object method call and detatched function call
	if self.get_object then
		self = self.get_object	-- change self from `o.dm` to `o`
		temp = self.delays.tn		-- set temporary table
	else
		temp = argt.table or self	-- if we do a detatched function call
	end
	
--handle arguments table
	--assign unnamed args to proper key names
	argt.min_delay = argt.min_delay or argt[1] or 0.25
	argt.Vsel      = argt.Vsel or argt[2] or "all"
	argt.shuffle	 = argt.shuffle or argt.random or argt[3] or true
	
	--Vsel 
	if type(argt.Vsel)=="number" then
		local number = argt.Vsel
		argt.Vsel = idx_shuffled(#temp)
		if number <= #temp then
			for i=1,(#temp-number) do
				argt.Vsel[#argt.Vsel] = nil
			end
		end	--future: if number is larger than the number of delays, then do something
	elseif type(argt.Vsel)=="table" then	--check for table of indices
		if type(argt.Vsel[1])~="number" then
			error("=== Error in DelaysMethods.shake"
					.."  = Argument Vsel should be a table of numbers."
					.."  = These numbers will correspond to the indices to operate over.", 2)
		end
	elseif argt.Vsel=="all" then
			argt.Vsel = idx( #temp )
		--end
	else
		error("=== Error in DelaysMethods.shake"
				.."  = Argument Vsel should be either ..."
				.."\t\t- a table of indices"
				.."\t\t- a number"
				.."\t\t- a string", 2)
	end 
	
	--shuffle Vsel
	if argt.shuffle==true then
		argt.Vset = shuffle(argt.Vsel)
	end
	
	
--main part here
	local dmin = 0
	local dmax = 0
	local possibly = {}
	
	for _,v in ipairs(argt.Vsel) do
		if (v>0) and (v <= #temp) then
			
			if v==1 then
				dmin = 1 - argt.min_delay		-- see assignment to `possibly` 
				dmax = temp[2] or self.delays.top
			elseif v==#temp then
				dmin = temp[#temp-1] or 1
				dmax = self.delays.top
			else
				dmin = temp[v-1]
				dmax = temp[v+1]
			end
			
			possibly = range(dmin+argt.min_delay, dmax-argt.min_delay, argt.min_delay, temp[v])
			temp[v] = possibly[ math.random(#possibly) ]
		end
	end
	
	self.set:delays(temp)
	return temp
end


return shake
