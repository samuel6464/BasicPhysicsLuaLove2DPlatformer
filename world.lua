local Entity = require "entity"

local World = {
	entities = {},
	systems = {}
}

function World:register(system)
	table.insert(self.systems,system)
	
end

function World:load(system,Ent)
	for i = #self.entities, 1, -1 do
		local entity = self.entities[i]
		system.load(entity)
	end
end



function World:create()
	local entity = Entity.new()
	table.insert(self.entities, entity)
	return entity
end

function World:addEntity(ent)
	table.insert(self.entities, ent)
end

function World:update(dt)
	
	for i = #self.entities, 1, -1 do
		
		local entity = self.entities[i]
		if entity.remove then
			for i, system in ipairs(self.systems)do
				if system:match(entity) then
					system:destroy(entity)				
				end
			end	
			table.remove(self.entities,i)
		else
		    for i,system in ipairs(self.systems) do
		    	if system.loaded == false then		  
				   	system.load(entity)		   
			    else			  
			    	system:update(dt,entity)			   
				end
		    end
		    entity.loaded = true		  
		end
    end
end

function World:draw()
	for i = 1,#self.entities do
		local entity = self.entities[i]
		for i,system in ipairs(self.systems) do
			system:draw(entity)
			if system:match(entity) then	
				system:draw(entity)			
			end
		end
	end
end

return World 