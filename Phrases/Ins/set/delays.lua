
--------------------------------------------------------------------------------
-- ins.set:delays(tn_delays_array)
--
----set `o.delays.tn` to `tn_delays_array`
--	also sets `o.delays.pl`
--

--require('Phrases.Ins.check_amt_of_vals_in_phrases')
require(_folder_Ins..'check_amt_of_vals_in_phrases')
local delays2pls = require(_folder_utils..'delays2pls')


delays = function (self, tn_delays_array)
	self = self.get_object	-- change self from `o.set` to `o`
	
	self.delays.tn = tn_delays_array
	
	if self.delays.top and self.nopl then
		self.delays.pl = delays2pls(tn_delays_array, self.delays.top, self.nopl)
	else
		if self.delays.top then
			error("=== Both object.delays.top AND object.nopl "
				.."\n      must be set to use Ins.set:delays!"
				,2)
			print("\n= Only object.delays.top (="..tostring(self.delays.top)..") is set.")
		elseif self.nopl then
			error("=== Both object.delays.top AND object.nopl "
				.."\n      must be set to use Ins.set:delays!"
				,2)
			print("\n= Only object.nopl (="..tostring(self.nopl)..") is set.")
		elseif not self.delays.top or not self.nopl then
			error("=== Both object.delays.top AND object.nopl "
				.."\n      must be set to use Ins.set:delays!"
				,2)
		end
	end
	
	self:check_amt_of_vals_in_phrases()
end


return delays
