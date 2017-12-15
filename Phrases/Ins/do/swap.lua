
--------------------------------------------------------------------------------
-- Ins.order:swap
--
----
--
--


function (self, A, B)
	self = self.get_object	-- change self from `o.do` to `o`

--If A and B are tables...
	if (type(A)=="table") and (type(B)=="table") then
		if #A~=#B then
			error("=== Error in Ins.do:swap(A,B) \n"
					.."  = A and B must be the same sized array."
					,2)
		else
			for i,_ in ipairs(A) do
				self.do:swap( A[i], B[i] )
			end
		end
	end
	
--now perform swap where A and B are numbers
	
	
end


return 