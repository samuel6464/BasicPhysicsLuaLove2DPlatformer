local PH = {}

function PH:test()
	print "callTest"
end

function PH:rectCollision(pos1x,pos1y,size1,pos2x,pos2y,size2,dt)
	
	if pos1x+ size1> pos2x and
		pos1x < pos2x + size2 and
		pos1y + size1 > pos2y and
		pos1y < pos2y+size2 then return true end

	if pos1y +size1/2 < pos2y + size2/2 then
		if pos1y +size1/2< pos2y and pos1y+size1 < pos2y +size2/2 then return true end 
	end

		if pos1x + size1 /2 < pos2x +size2/2 then
			if pos1x+dt +size1/2 > pos2x and
					player.pos.y +size1 > pos2y then
							 return true
			end
		end
	if pos1x+1 < pos2x +size2 and
						 pos1y + size1  > pos2y then return true end
				
		
		
			::cont:: 
	return false
end

function PH:playerCollision(player,pos2x,pos2y,size2,dt)

	
	--pre-check needed for collision

	local pos1x = player.pos.x + (player.vel.x *dt *player.dir.x)
	local pos1y = player.pos.y +player.vel.y/16 +dt--
	local size1 = player.BC.w 

	if pos1x+ size1> pos2x and
		pos1x < pos2x + size2 and
		pos1y + size1  > pos2y and
		pos1y < pos2y+size2 then 
	return true end 
end 
	
function PH:playerReplace(player,pos2x,pos2y,size2,dt)
	--print "in replace"
	local pos1x = player.pos.x
	local pos1y = player.pos.y
	local size1 = player.BC.w

	local boxX = player.pos.x + (player.vel.x*dt/2 *player.dir.x)
	local boxY = player.pos.y+player.vel.y/8+dt




	--x--
	if pos1x + size1 /2 < pos2x +size2/2 then
		if boxX +size1 > pos2x and
			pos1y +size1 > pos2y then
			--print "right"
			player.vel.x = 0 
			player.dir.x = 0
			player.pos.x = player.pos.x - (player.vel.x *dt/2 *player.dir.x)
		end
	else
		
			if boxX < pos2x +size2 and
				pos1y + size1  > pos2y  then
				player.vel.x = 0 
				player.dir.x = 0
				player.pos.x = player.pos.x - (player.vel.x *dt/2 *player.dir.x)
			end
		
	end
	
	--y--

	--clips/Snap unuse...
	--if  player.pos.y + size1 > pos2y then
	--	player.pos.y = pos2y - size1
	--end --goto cont


	if pos1y +size1/2 < pos2y + size2/2 then
		if boxY +size1< pos2y 
			and pos1y+size1 < pos2y + size2/2 then 
			--print "upif" 
	    	player.pos.y = player.pos.y - (player.vel.y *dt/8 *player.dir.y)
	    	player.vel.y = -player.vel.y
	   end
	   
     else
     	if boxY +size1/2>= pos2y +size2/2
			and 
			pos1y+size1 > pos2y + size2/2  then 
			--print 'upelse'
	   	 	player.vel.y = -player.vel.y
	   	    player.vel.y =-player.vel.y
	 		end
	   end
	   ::cont:: 
	return false
end

function PH:mapRigidity(map)
	mapR = {}
	-- peut être plus rapide avec une hashmap contenant en clef le num et en valeur rigidité...
	for i=1,#map do
		mapR[i]={}
		for j=1,#map[1] do
			mapR[i][j]=0
			if map[i][j] == 0 then mapR[i][j]=1 end
			if map[i][j] == 1 then mapR[i][j]=1 end
			if map[i][j] == 2 then mapR[i][j]=1 end
			if map[i][j] == 3 then mapR[i][j]=1 end
			if map[i][j] == 4 then mapR[i][j]=1 end
			if map[i][j] == 5 then mapR[i][j]=1 end
			if map[i][j] == 6 then mapR[i][j]=1 end
			if map[i][j] == 7 then mapR[i][j]=1 end

			if map[i][j] == 8 then mapR[i][j]=1 end
			if map[i][j] == 9 then mapR[i][j]=1 end
			if map[i][j] == 10 then mapR[i][j]=1 end
			if map[i][j] == 11 then mapR[i][j]=0 end
			if map[i][j] == 12 then mapR[i][j]=0 end
			if map[i][j] == 13 then mapR[i][j]=0 end
			if map[i][j] == 14 then mapR[i][j]=0 end
			if map[i][j] == 15 then mapR[i][j]=0 end

			if map[i][j] == 16 then mapR[i][j]=0 end
			if map[i][j] == 17 then mapR[i][j]=0 end
			if map[i][j] == 18 then mapR[i][j]=1 end
			if map[i][j] == 19 then mapR[i][j]=1 end
			if map[i][j] == 20 then mapR[i][j]=0 end
			if map[i][j] == 21 then mapR[i][j]=0 end
			if map[i][j] == 22 then mapR[i][j]=1 end
			if map[i][j] == 23 then mapR[i][j]=1 end

			if map[i][j] == 24 then mapR[i][j]=1 end
			if map[i][j] == 25 then mapR[i][j]=1 end
			if map[i][j] == 26 then mapR[i][j]=0 end
			if map[i][j] == 27 then mapR[i][j]=0 end
			if map[i][j] == 28 then mapR[i][j]=0 end
			if map[i][j] == 29 then mapR[i][j]=0 end
			if map[i][j] == 30 then mapR[i][j]=0 end
			if map[i][j] == 31 then mapR[i][j]=0 end

			if map[i][j] == 32 then mapR[i][j]=1 end
			if map[i][j] == 33 then mapR[i][j]=1 end
			if map[i][j] == 34 then mapR[i][j]=1 end
			if map[i][j] == 35 then mapR[i][j]=1 end
			if map[i][j] == 36 then mapR[i][j]=0 end
			if map[i][j] == 37 then mapR[i][j]=0 end
			if map[i][j] == 38 then mapR[i][j]=0 end
			if map[i][j] == 39 then mapR[i][j]=0 end

			if map[i][j] == 40 then mapR[i][j]=1 end
			if map[i][j] == 41 then mapR[i][j]=1 end
			if map[i][j] == 42 then mapR[i][j]=1 end
			if map[i][j] == 43 then mapR[i][j]=1 end
			if map[i][j] == 44 then mapR[i][j]=1 end
			if map[i][j] == 45 then mapR[i][j]=1 end
			if map[i][j] == 46 then mapR[i][j]=1 end
			if map[i][j] == 47 then mapR[i][j]=1 end

			if map[i][j] == 48 then mapR[i][j]=1 end
			if map[i][j] == 49 then mapR[i][j]=1 end
			if map[i][j] == 50 then mapR[i][j]=1 end
			if map[i][j] == 51 then mapR[i][j]=1 end
			if map[i][j] == 52 then mapR[i][j]=1 end
			if map[i][j] == 53 then mapR[i][j]=1 end
			if map[i][j] == 54 then mapR[i][j]=1 end
			if map[i][j] == 55 then mapR[i][j]=1 end

			if map[i][j] == 56 then mapR[i][j]=1 end
			if map[i][j] == 57 then mapR[i][j]=1 end
			if map[i][j] == 58 then mapR[i][j]=1 end
			if map[i][j] == 59 then mapR[i][j]=1 end
			if map[i][j] == 60 then mapR[i][j]=1 end
			if map[i][j] == 61 then mapR[i][j]=1 end
			if map[i][j] == 62 then mapR[i][j]=1 end
			if map[i][j] == 63 then mapR[i][j]=1 end
		end
	end
	return mapR	
end

return PH