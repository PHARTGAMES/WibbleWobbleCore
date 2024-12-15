-- This Source Code Form is subject to the terms of the bCDDL, v. 1.1.
-- If a copy of the bCDDL was not distributed with this
-- file, You can obtain one at http://beamng.com/bCDDL-1.1.txt

local C = {}
C.__index = C


--local function rotateEuler(x, y, z, q)
--  q = q or quat()
--  q = quatFromEuler(0, 0, x) * q
--  q = quatFromEuler(0, z, 0) * q
--  q = quatFromEuler(y, 0, 0) * q
--  return q
--end

-- this one seems more correct, doesn't make pitch change when rolling
local function rotateEuler(x, y, z, q)
  q = q or quat()
  q = quatFromEuler(0, 0, x) * q
  q = quatFromEuler(y, 0, 0) * q
  q = quatFromEuler(0, z, 0) * q
  return q
end


--local move_sensitivity = 0.00005
--local rotate_sensitivity = 0.01

local move_sensitivity = 1.0 / 16383
local rotate_sensitivity = 1.0 / 91


function C:init()
  self.isGlobal = true
  self.runningOrder = 0.5
  self.isFilter = true
  self.hidden = true
  if TrackIR and TrackIR.recording() then
    -- already recording, assume its working
    self.working = true
    return
  end
  if not TrackIR or not TrackIR.init() then
    --log('D', 'core_camera.trackir', 'TrackIR could not init')
    return
  end
  log('D', 'core_camera.trackir', 'TrackIR available :D')
  TrackIR.start()
  self.working = true
end

function C:update(data)
  if not self.working then return end


  local t = {}
  if TrackIR and TrackIR.getData(t) then

    local trans = vec3(-t.nx, -t.nz, t.ny) * move_sensitivity

--	log('D', "core_camera.trackir", "TIR POS = " .. string.format('%f', t.nx))
--	log('D', "core_camera.trackir", "trans POS = " .. string.format('%f', trans.x))

    trans = data.res.rot * trans
    data.res.pos = data.res.pos + trans


    local q = rotateEuler(
      math.rad(t.yaw * rotate_sensitivity)
    , math.rad(t.pitch * rotate_sensitivity) + math.pi
    , math.rad(t.roll * -rotate_sensitivity))

    data.res.rot = q * data.res.rot
  end
  return true
end

-- DO NOT CHANGE CLASS IMPLEMENTATION BELOW

return function(...)
  local o = ... or {}
  setmetatable(o, C)
  o:init()
  return o
end
