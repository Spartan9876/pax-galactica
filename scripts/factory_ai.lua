local random1 = math.random(0,1)
local random2 = math.random(0,1)
local random3 = math.random(0,1)
function update()
	if random1 ==1 or random2 ==1 or random3 ==1 then
		self.ship.thrust()
		self.ship.turn(1)
	else 
		self.ship.thrust()
		self.ship.turn(0)
	end
end
