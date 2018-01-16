-- setters 

set = {}



set.object = nil


set.delays = function(self, tn_or_pl)
	self = self.set_object -- transform self from `obj.delays.set to obj`
	
	if not tn_or_pl or tn_or_pl=="both" then
		return self.delays_private
	elseif tn_or_pl=='tn' then
		return self.delays_private.tn
	elseif tn_or_pl=='pl' then
		return self.delays_private.pl
	end
end


set.notes = function(self)
	self = self.set_object -- transform self from `obj.notes.set to obj`
	
	return self.notes_private
end


set.notesK = function(self)
	local keyname = self.keyname
	self = self.set_object -- transform self from `obj.notes[key].set to obj`
	
	return self.notes_private[keyname]
end




return set
