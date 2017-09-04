return{
	new = function()
		local entity = {
			components = {},
			tags = {},
			remove = false,
			loaded =false
	}

	

	function entity:destroy()
		self.remove = true
	end

	function entity:add(component)
		--print "component added"
		assert(component.__id)
		self.components[component.__id] = component
		--print "component added"
	end

	function entity:get(id)
		return self.components[id]
	end

	return entity
end
}