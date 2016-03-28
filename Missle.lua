local image = love.graphics.newImage('images/missleShot.png')

Missle = {}
Missle.__index = Missle

local tilesetBatch = love.graphics.newSpriteBatch(image)

function Missle.new(player,x,y,speed,rotation,damage,bulletLife)
  local s = {}
  setmetatable(s, Missle)
  s.player = player
  s.x = x
  s.y = y
  s.bulletLife = bulletLife or 1
  s.rotation = rotation or 0
  s.vx = speed * math.sin(s.rotation)
  s.vy = speed * -math.cos(s.rotation)
  s.lifetime = 0
  s.damage = damage
  s.rotationSpeed = 20
  s.throttle = 0
  s.topSpeed = 200
  s.acceleration = 3
  s.throttle = 0
  s.angularInput = 0
  return s
end

function Missle:update(dt)
  self.lifetime = self.lifetime + dt
  Mover.ApplyAcceleration(self, dt)
  Mover.ApplyVelocity(self, dt)

  players = Game.getPlayers()
  local playerDist = 0

  for p, player in pairs(players) do
    if player ~= self.player then
      xPow = math.pow(player.x - self.x, 2)
      yPow = math.pow(player.y - self.y, 2)

      dist = math.sqrt(xPow + yPow)

      if moveToPoint then
        if playerDist > dist then
          moveToPoint = {x = player.x, y = player.y}
        end
      else
        moveToPoint = {x = player.x, y = player.y}
        playerDist = dist
      end

    --         if dist < 20 then
    --           player.health = player.health - self.damage

    --           if player.health < 0 then
    --             player.health = 0
    --           end
    --           table.remove(self.player.bullets, b)
    --         end
    -- end
  end

  if moveToPoint then
    Mover.MoveTowards(self,moveToPoint.x-self.x,moveToPoint.y-self.y,dt)
  end

  Mover.ApplyRotation(self,dt)
  Mover.StageWrap(self)
  tilesetBatch:add(self.x, self.y, self.rotation, 1,1 , 3,3)
end


function Missle.draw()
  tilesetBatch:flush()
  love.graphics.draw(tilesetBatch)
  tilesetBatch:clear()
end

return Missle