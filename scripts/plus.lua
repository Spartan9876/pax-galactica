local v2 = require 'dokidoki.v2'

local SPEED = 0.2
local LIFETIME = 2
local FADE_TIME = 2

local random_direction = v2(math.random() < 0.5 and 1 or -1, 0)
local random_speed = math.random() + 0.5
local opacity = 10

local since_alive = 0

function update()
  since_alive = since_alive + 1/60
  
  self.transform.facing = random_direction
  
  self.transform.pos = self.transform.pos + random_direction * SPEED * random_speed
  
  if since_alive < FADE_TIME then
    self.sprite = since_alive / FADE_TIME * opacity
  else
    self.sprite = ((since_alive - LIFETIME + FADE_TIME) / FADE_TIME) * opacity
  end
  if since_alive > LIFETIME then self.dead = true end
end
