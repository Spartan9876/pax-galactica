local turnrate = 0
local flip
function update()
  self.ship.thrust()
  if math.random(0,15)==3 then
  turnrate = turnrate + math.random(-1,1)
  end
	 local on_screen = game.targeting.on_screen(self.transform.pos)
  --if (on_screen > (1024, 768) or on_screen < (0, 0) or on_screen > (1024, 0) or on_screen > (0, 768) ) then
		 --self.ship.turn(4)
	--else
	self.ship.turn(turnrate)
	 
  --end
end
