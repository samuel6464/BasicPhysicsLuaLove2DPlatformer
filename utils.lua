function table.new(orig)
	local orig_type =  type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key , orig_value in next,orig,nil do
				copy[table.new(orig_key)] = table.new(orig_value)
			end
	else
		copy = orig
	end
			return copy
end

--physic helper unuse

function rectCollision(pos1x,pos1y,size1,pos2x,pos2y,size2)
	if pos1x+ size1> pos2x and
		pos1x < pos1x + size2 and
		pos1y + size2 > pos2y and
		pos1y < pos2y+size2 then

		return true
	end 
	return false
end