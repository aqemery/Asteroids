ShipType = {
  standard = {
    name = "Standard",
    description = "Balanced speed, range, and damage",
    topSpeed = 4,
    acceleration = 360,
    rotationSpeed = 4,
    fireRate = 15,
    health = 150,
    weaponDamage = 10,
    frameOffset = 0,
    previousType = "carrier",
    nextType = "gunship"
  },
  gunship = {
    name = "Gunship",
    description = "Can fire a long range attack in any direction, at the cost of speed and defence",
    topSpeed = 2,
    acceleration = 180,
    rotationSpeed = 4,
    cannonRotation = 0,
    fireRate = 1.5,
    health = 130,
    weaponDamage = 40,
    frameOffset = 2,
    previousType = "standard",
    nextType = "assalt"
  },
  assalt = {
    name = "Assault",
    description = "High speed and damage at the cost of attack range",
    topSpeed = 5,
    acceleration = 240,
    rotationSpeed = 4,
    fireRate = 1,
    health = 170,
    weaponDamage = 10,
    frameOffset = 4,
    previousType = "gunship",
    nextType = "ray"
  },
  ray = {
    name = "Rayman",
    description = "Medium attack range with instant damage",
    topSpeed = 3,
    acceleration = 240,
    rotationSpeed = 1,
    fireRate = 60,
    health = 150,
    weaponDamage = 1.5,
    frameOffset = 6,
    previousType = "assalt",
    nextType = "zap"
  },
  zap = {
    name = "Zapper",
    description = "High short range damage at the cost of defence",
    topSpeed = 3,
    acceleration = 180,
    rotationSpeed = 4,
    fireRate = 1,
    health = 160,
    weaponDamage = 1.5,
    frameOffset = 8,
    previousType = "ray",
    nextType = "charge"
  },
  charge = {
    name = "Charger",
    description = "Can charge attack extra damage and range",
    topSpeed = 4,
    acceleration = 240,
    rotationSpeed = 4,
    fireRate = 10,
    health = 160,
    weaponDamage = 20,
    frameOffset = 10,
    previousType = "zap",
    nextType = "missle"
  },
  -- flack = {
  --   name = "Flack",
  --   description = "Can fire a medium range attack in any direction that will block incoming damage",
  --   topSpeed = 2,
  --   acceleration = 3,
  --   rotationSpeed = 4,
  --   fireRate = 3,
  --   health = 120,
  --   weaponDamage = 10,
  --   frameOffset = 2,
  --   previousType = "charge",
  --   nextType = "missle"
  -- },
  missle = {
    name = "Missle",
    description = "Fires missles that home in on enemies",
    topSpeed = 3,
    acceleration = 180,
    rotationSpeed = 4,
    fireRate = 2,
    health = 150,
    weaponDamage = 40,
    frameOffset = 12,
    previousType = "charge",
    nextType = "carrier"
  },
  carrier = {
    name = "Carrier",
    description = "Launches drone that attack enemies",
    topSpeed = 2,
    acceleration = 120,
    rotationSpeed = 4,
    fireRate = 2,
    health = 150,
    weaponDamage = 40,
    frameOffset = 14,
    previousType = "missle",
    nextType = "standard"
  }
}