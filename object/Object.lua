Object = {}
Object.__index = Object

function Object.new()
  local o = {}
  setmetatable(o, Object)
  return o
end

function Object:update(dt)
   print("not implemented update")
end

function Object:OnPlayerHit(player)
	 print("not implemented OnPlayerHit")
end

function Object:OnWallHit(tile,dt)
end

function Object:OnBulletHit(bullet)
end

function Object:OnAoEHit(bullet)
end

function Object:Remove()
end

function Object:shouldRemove()
  return false
end

function Object:draw()
   print("not implemented draw")
end


return Object