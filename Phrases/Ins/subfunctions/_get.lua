-- getters 

get = {}



get.object = nil


get.delays = function(self, tn_or_pl)
	self = self.get_object -- transform self from `obj.delays to obj`
	
	if not tn_or_pl or tn_or_pl=="both" then
		return self.delays_private
	elseif tn_or_pl=='tn' then
		return self.delays_private.tn
	elseif tn_or_pl=='pl' then
		return self.delays_private.pl
	end
end


get.notes = function(self)
	self = self.get_object -- transform self from `obj.notes to obj`
	
	return self.notes_private
end


get.notesK = function(self)
	local keyname = self.keyname
	self = self.get_object -- transform self from `obj.notes[key] to obj`
	
	return self.notes_private[keyname]
end




return get
