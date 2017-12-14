
--------------------------------------------------------------------------------
-- ins.set:delays(tn_delays_array)
--
----set `o.delays.tn` to `tn_delays_array`
--	also sets `o.delays.pl`
--

require('Phrases.Ins.check_amt_of_vals_in_phrases')


delays = function (self, tn_delays_array)
	self = self.get_object	-- change self from `o.set` to `o`
	
	--Future: add error if delays.top or self.nopl isn't set yet
	--Future: Having a ton of issues with using delays2pls here. 
	--	rn, I'm just putting the delays2pl functionality directly in here
	
	self.delays.tn = tn_delays_array
	
	-- print(utils)
	-- delays2pls = require('delays2pls')
	-- self.delays.pl = utils.delays2pls(t, self.delays.top, self.nopl)
	
	for i,v in ipairs(tn_delays_array) do
		self.delays.pl[i] = (v - 1) /(self.delays.top-1) *self.nopl
	end
	
	self:check_amt_of_vals_in_phrases()
end


return delays
