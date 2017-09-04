local tlm = {}

local width  = 128
local height = 128

local size = 16 

function tile(x,y,w,h,quad)
 	self.tile = {}

	tile.pos = require("tool/vec2"):new(x,y)
	tile.size = require("tools/vec2"):new(w,h)
	tile.quad = quad
	return tile
end

function tlm:load()
	renderer:addRenderer(self)
	gameLoop:addLoop(self)

	self.tiles = {}
	for i =1,height do
		self.tiles[i] = {}
	end
end	

function tlm:loadmap(mapname)
	local map = require("assets/maps/ " mapname)

	for i=1

	end
end

function tlm:draw()
	for i=1,#self.tiles do
		for j =1,#self.tiles[i] do
			local t=1,#self.tiles[i][j] 
			love.graphics.rectangle("fill",size*t.x-size,size*t.y-size,t.w,t.h)
		end
	end
end

function tlm:add(t)
	self.tiles[t.y][t.x] = t
end


return tlm