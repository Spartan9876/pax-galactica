local collision = require 'dokidoki.collision'

-- umm, looks like brute force n^2 checking is fast enough
local bodies = {}

function add_body(body)
  bodies[#bodies+1] = body
end

game.actors.new_generic('collision', function ()
  function collision_check()
    for i = 1, #bodies do
      local b1 = bodies[i]
      for j = i+1, #bodies do
        local b2 = bodies[j]
        if b1.type ~= b2.type and b1.player ~= b2.player
           and collision.collide(b1, b2) then
          if b1.type == 'bullet' then
            b1, b2 = b2, b1
          end
          local ship = b1.actor
          local bullet = b2.actor
          game.log.record_hit(ship, bullet)
          game.particles.bullet_hit(ship, bullet)
          ship.ship.damage(bullet.collision.damage)
          bullet.dead = true

        end
        if b1.type == b2.type and b1.type == 'ship' and b1.player ~= b2.player and collision.collide(b1, b2) then 
          local ship1 = b1.actor
          local ship2 = b2.actor
          local damage1 = ship2.ship.hit_points
          local damage2 = ship1.ship.hit_points
		  
		  if b1.actor == 'factory' and b2.actor == 'factory' then
			ship1.ship.damage()
			ship2.ship.damage()
		  else
			ship1.ship.damage(damage1 * (ship1.ship.accel * 2))
			ship2.ship.damage(damage2 * (ship1.ship.accel * 2))
		  end

        end
      end
    end

    bodies = {}
  end
end)
