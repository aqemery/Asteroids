local part1 = love.graphics.newImage('images/part.png')

Beam = {}
Beam.__index = Beam

function Beam.new(player,damage)
  local s = {}
  setmetatable(s, Beam)
  s.x = x
  s.y = y
  s.player = player
  s.rotation = rotation or 0
  s.lifetime = 0
  s.damage = damage
  s.startPointX = 0
  s.startPointY = 0
  s.endPointX = 0
  s.endPointY = 0

  s.partSys = love.graphics.newParticleSystem(part1, 1000)
  return s
end

function Beam:update(x,y,rotation,dt)
  self.rotation = rotation
  self.x = x
  self.y = y

  local collide = true
  local xBeam = self.x + 12 * math.sin(self.rotation)
  local yBeam = self.y + 12 * -math.cos(self.rotation)
    self.startPointX = xBeam
    self.startPointY = yBeam


  -- beamBatch:add(beam1,xBeam, yBeam, self.rotation, 1,1 , 0,0)

  local beamSegmants = 1
  while collide and beamSegmants < 100 do

    OffsetX = xBeam + (beamSegmants * 3 * math.sin(self.rotation))
    OffsetY = yBeam + (beamSegmants * 3 * -math.cos(self.rotation))

    local playerHit = false
    local players = Game.getPlayers()

    for p, otherPlayer in pairs(players) do
      if otherPlayer ~= self.player and otherPlayer.components.life.alive then
        local otherMove = otherPlayer.components.move

        xPow = math.pow(xBeam - otherMove.x, 2)
        yPow = math.pow(yBeam - otherMove.y, 2)

        dist = math.sqrt(xPow + yPow)
        if dist < 10 then
          otherPlayer.components.life:takeDamage(self.player, self.damage)

          playerHit = true
        end
      end
    end

    tile = TiledMap_GetMapTile(math.floor(xBeam/16),math.floor(yBeam/16),1)
    if tile > 0  or playerHit then
      collide = false
    else
        beamSegmants = beamSegmants + 1
        -- beamBatch:add(beam1, OffsetX, OffsetY, self.rotation, 1,1 ,0,0)
        xBeam = xBeam + 3 * math.sin(self.rotation)
        yBeam = yBeam + 3 * -math.cos(self.rotation)
    end
    self.endPointX = xBeam
    self.endPointY = yBeam
  end



  -- -- self.x = self.x + self.vx
  -- -- self.y = self.y + self.vy

  -- if self.y > (TiledMap_GetMapH() * 16) then
  --   self.y = self.y - TiledMap_GetMapH() * 16
  -- end

  -- if self.y < 0 then
  --   self.y = self.y + TiledMap_GetMapH() * 16
  -- end


  -- if self.x > 1920 then
  --   self.x = self.x - 1920
  -- end

  -- if self.x < 0 then
  --   self.x = self.x + 1920
  -- end


  -- tilesetBatch:add(self.x, self.y, self.rotation, 1,1 , 3,3)


  xPow = math.pow(self.startPointX - self.endPointX, 2)
  yPow = math.pow(self.startPointY - self.endPointY, 2)

  dist = math.sqrt(xPow + yPow)



  speed = 2000

  self.partSys:setParticleLifetime(dist/speed, dist/speed/2) -- Particles live at least 2s and at most 5s.
  self.partSys:setEmissionRate(5000)
  self.partSys:setSizeVariation(1)

  self.partSys:setPosition(self.startPointX,self.startPointY)
  self.partSys:setSpeed(speed)
  self.partSys:setDirection(self.rotation -math.pi/2)

  -- self.partSys:setEmissionRate(5*dist)
  self.partSys:setRelativeRotation(true)
  -- self.partSys:setOffset( -dist/2, 0)

  -- self.partSys:setAreaSpread("uniform", dist/2,0)

  -- self.partSys:setLinearAcceleration(20, 100, 0, -100) -- Random movement in all directions.
  self.partSys:setColors(255, 255, 255, 255, 255, 255, 255, 0) -- Fade to transparency.
  self.partSys:update(dt)
end

function Beam:draw()
  love.graphics.draw(self.partSys)

  love.graphics.line(self.startPointX, self.startPointY, self.endPointX,self.endPointY)
  -- beamBatch:flush()
  -- love.graphics.draw(beamBatch)
  -- beamBatch:clear()
end

return Beam