--This code was inspirate by the tutorials of RazorGameDev

--https://www.youtube.com/watch?v=HvHSm711CZY&t=3s
--https://www.youtube.com/watch?v=dZ_X0r-49cw&t=1487s (component system)

--I modify and had some idea for this basic physics for a 2D platformer
--Collision work well
--I had map to mapRigid function for easily check if the tile is solid
--My camera track player with scale change

local World = require("world")
local Component = require "component"
local System = require "system"

local factoryC = require "componentsFactory"
GAMETIME = 0

local img = love.graphics.newImage("assets/tiles/tiles1.png")

WIDTH = love.graphics.getWidth()
HEIGHT = love.graphics.getHeight()
CHECK =false
deltaTime = 0
local quads = {}
local map = require("assets/maps/map")
local mapRigid = require("tools/physicsHelper"):mapRigidity(require("assets/maps/map"))

for x = 0, 255 do
    local i,j = (x%8), math.floor(x/8)
    quads[x] = love.graphics.newQuad(i*32, j*32, 32, 32, img:getWidth(), img:getHeight())
 end


function new_renderer_system()
	local renderer = System.new({"body","rect","tlm","camera","being","player"}) 
	function renderer:load(entity)

			local entity = World:create()

			entity:add(factoryC:new_camera("test"))
			entity:add(factoryC:new_player(factoryC:new_being(10,160,12,12)))			
			entity:add(factoryC:new_tile_manager(#map,#map,map))
			World.entities[1] =entity
	end

	function renderer:update(dt,entity)

		local camera1 = entity:get("camera")
		local player = entity:get("player")
		
	
		GAMETIME = GAMETIME+dt
		deltaTime = dt
		player:move(dt,mapRigid)
		camera1:gotopoint(player.pos)

	end

-----nb :les map ont toutes la même lg
	function renderer:draw(entity)
	--print("salut")
		
		local entity = World.entities[1]
		local camera = entity:get("camera")
		--print(camera)
		local body = entity:get("body")
		
		local player = entity:get("player")
		
		camera:set()
		love.graphics.setColor(255, 255, 255)
		for i=1,#map do
			for j=1,#map[1] do
				love.graphics.draw(img,quads[map[i][j]],30*(j-1),30*(i-1))
				--love.graphics.draw(img,quads[mapRigid[i][j]],30*(j-1),30*(i-1))
			end
		end

		love.graphics.setColor(255, 255, 255)
		love.graphics.rectangle('fill',player.pos.x,player.pos.y,player.BC.h,player.BC.w)
		
		--for debugging position...

		--love.graphics.setColor(255, 0, 0)
		--love.graphics.rectangle('fill',player.pos.x + (player.vel.x*deltaTime/16 *player.dir.x),player.pos.y+player.vel.y/8+deltaTime,player.BC.h,player.BC.w)
		
		--love.graphics.setColor(0, 0, 255)
		--love.graphics.rectangle('fill',player.pos.x + (player.vel.x*deltaTime/2 *player.dir.x),player.pos.y+player.vel.y/4+deltaTime,player.BC.h,player.BC.w)
		

		--love.graphics.setColor(0, 255, 0)
		--love.graphics.rectangle('fill',player.pos.x + (player.vel.x*deltaTime *player.dir.x),player.pos.y+player.vel.y+deltaTime,player.BC.h,player.BC.w)
		
		--love.graphics.setColor(0, 0, 0)

		camera:unset()
	end
	return renderer
end

function love.load()
	syst =new_renderer_system()
	World:register(syst)
	Ent = World:create()
	World:load(syst,Ent)
	for i=1, #syst.requires do
		if World.entities[i]:get(syst.requires[i]) == nil then
			return false
		else
			player.vel.y = 0
			player.dir.y = 0	
			World:load(entity:get(syst.requires[i]))
		end
	end			
end

function love.update(dt)
	World:update(dt)
end

function love.draw()
	World:draw()
end