local factoryC = {}

local Component = require "component"
function factoryC:new_body(x,y)
	local body = Component.new "body"
	body.x = x
	body.y = y
	return body
end

function factoryC:new_rectangle_component()
	return Component.new("rect")
end

function factoryC:new_being(x,y,w,h,img,quad,id)
	local being = Component.new "being"
	being.x = x
	being.y= y
	being.w = w
	being.h = h
	being.img = img
	being.quad = quad
	being.id = id
	return being
end 

function factoryC:new_player(beingC,map)

    player=Component.new "player"
	player.BC = beingC

	player.size = require("tools/vec2"):new(player.BC.w,player.BC.h)
 
	player.pos = require("tools/vec2"):new(player.BC.x,player.BC.y)
	
	player.vel= require("tools/vec2"):new(0,0)
	player.dir = require("tools/vec2"):new(0,0)
	player.spd = require("tools/vec2"):new(0,0)

	player.remove = false

	player.onGround = false
	player.gravity = 200


	function player:move(dt,mapRigid)
		local key = love.keyboard.isDown
		local mapR = mapRigid
		player.vel.y = player.vel.y +player.gravity*dt
		player.dir.y = 1


		--velo
		if key("left")then
			player.dir.x =-1
			player.vel.x =50			
		end

		if key("right")then
			player.dir.x =1
			player.vel.x =50		
		end

		if key("up")then
			if player.vel.y <30 and  player.vel.y > -30 then       
				player.vel.y = -player.gravity * .14
				--player.onGround = false
			end
		end

		--collision 
		local x = math.floor (player.pos.x / 30) - 1
		local y = math.floor(player.pos.y /30) - 1
		local w =4
		local h =4

		if x< 1 then x=1 end	
		if y<1 then y=1 end

		for i=y,y+h do
			for j = x,x+w do
				local tilex= 30*(j-1)
				local tiley=30*(i-1)

		
				--!--box precheck
				
				local col = require("tools/physicsHelper")
				
				coll =col:playerCollision(player,tilex,tiley,30,dt)
			    

				if coll and mapR[i][j] == 1 then
				
					player.vel.y =0
					player.dir.y =0
					col:playerReplace(player,tilex,tiley,30,dt)
				end
				::cont::
			end
			::noX::
		end
	
		
		player.pos.x = player.pos.x + (player.vel.x *dt) *self.dir.x
		player.pos.y = player.pos.y + (player.vel.y *dt) *self.dir.y
	 
	   
	    player.vel.x = player.vel.x * (1-4*dt)
	    player.vel.y = player.vel.y * (1-4*dt)

		self.dir.x =0
	end
	return player
end



function factoryC:new_tile_manager(width,height,map)
	local tlm = Component.new("tlm")
	tlm.map = map 
	tlm.tiles = {}

	for i=1,height do
		tlm.tiles[i]={}
	end
	 return tlm
end

function factoryC:new_camera(name)

	camera = Component.new("camera")
	local lg = love.graphics
	camera.name = name
	camera.pos = require("tools/vec2"):new(0,0)
	camera.size = require("tools/vec2"):new(0,0)
	camera.scale = require("tools/vec2"):new(1,1)
	camera.rot =0
	camera.scale.x = 1
	camera.scale.y = 1

	function camera:set()

		lg.push()
		lg.translate(camera.pos.x,camera.pos.y)
		lg.scale(1/self.scale.x,1/camera.scale.y)

	end

	function camera:gotopoint(posi)
		scaleX=camera.scale.x
		scaleY = camera.scale.y
		camera.pos.x = (-posi.x +WIDTH /2) /scaleX  + WIDTH*(1-1/scaleX)/2
		camera.pos.y = (-posi.y +HEIGHT/2)  / scaleY + HEIGHT*(1-1/scaleY)/2

	end

	function camera:unset()

			lg.pop()
	end

	return camera
end

return factoryC