Mover = {}
Mover.__index = Mover


function Mover.ApplyAcceleration(entity, dt)
  if entity.throttle > 0 then
    xAccel = entity.throttle * entity.acceleration * dt * math.sin(entity.rotation)
    yAccel = entity.throttle * entity.acceleration * dt * -math.cos(entity.rotation)

    entity.vx = entity.vx + xAccel
    entity.vy = entity.vy + yAccel

    entity.engine = true
    entity.throttle = 0
  else
    entity.engine = false
  end
end
function Mover.ApplyVelocity(entity, dt)

  if entity.topSpeed then 
    if entity.vx > entity.topSpeed then
      entity.vx = entity.topSpeed
    elseif entity.vx < -entity.topSpeed  then
      entity.vx = -entity.topSpeed
    end

    if entity.vy > entity.topSpeed then
      entity.vy = entity.topSpeed
    elseif entity.vy < -entity.topSpeed then
      entity.vy = -entity.topSpeed
    end
  end


  entity.x = entity.x + entity.vx * dt
  entity.y = entity.y + entity.vy * dt
end

function Mover.ApplyRotation(entity,dt)
  entity.rotation = entity.rotation + entity.rotationSpeed * entity.angularInput * dt
  entity.angularInput = 0

  if entity.rotation < 0 then
    entity.rotation = entity.rotation + 2 * math.pi

  elseif entity.rotation > math.pi*2 then
    entity.rotation = entity.rotation - 2 * math.pi
  end
end

function Mover.StageWrap(entity)
  if entity.y > 960 then
    entity.y = entity.y - 960
  end

  if entity.y < 0 then
    entity.y = entity.y + 960
  end

  if entity.x > 1920 then
    entity.x = entity.x - 1920
  end

  if entity.x < 0 then
    entity.x = entity.x + 1920
  end
end


function Mover.MoveTowards(entity,x,y,dt)
  local angle = math.atan2(x,-y)

  if angle < 0 then
    angle = angle + 2 * math.pi

  elseif angle > math.pi then
    angle = angle - 2 * math.pi
  end

  moveAngle = angle - entity.rotation


  if (moveAngle < 0 and moveAngle > -math.pi) or moveAngle > math.pi then
    entity.angularInput = -1
  elseif moveAngle > 0 or moveAngle < -math.pi then
      entity.angularInput = 1
  else
      entity.angularInput = 0
  end

  if math.abs(moveAngle) > math.pi and (2*math.pi - math.abs(moveAngle)) < entity.rotationSpeed * dt then
    entity.angularInput = entity.angularInput * (2*math.pi - math.abs(moveAngle))/(entity.rotationSpeed* dt)
  elseif math.abs(moveAngle) < entity.rotationSpeed * dt then
    entity.angularInput = entity.angularInput * math.abs(moveAngle)/(entity.rotationSpeed* dt)
  end
  if math.abs(moveAngle) < math.pi/8 then
    local xPow = math.pow(x, 2)
    local yPow = math.pow(y, 2)
    local dist = math.sqrt(xPow + yPow)
      entity.throttle = dist
  end
end

return Mover