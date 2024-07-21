-- Put this in a ModuleScript, and put that in ReplicatedStorage :3 | If you want it to be the same as mine, you can name it "debug".

local playerDebug = {}
playerDebug.__index = playerDebug

function playerDebug.new(player)
	local self = setmetatable({}, playerDebug)
	self.refreshRate = 4
	self.frameCount = 0
	self.time = 0
	self.fps = 0
	self.topSpeed = 0
	self.player = player
	return self
end

function playerDebug:update(dt)
	self.frameCount = self.frameCount + 1
	self.time = self.time + dt
	if self.time > 1.0 / self.refreshRate then
		self.fps = math.floor(self.frameCount / self.time)
		self.frameCount = 0
		self.time = self.time - 1.0 / self.refreshRate
	end

	local speed = self.player.Velocity.Magnitude
	if speed > self.topSpeed then
		self.topSpeed = speed
	end
end

function playerDebug:onRenderStepped()
	print("FPS: " .. self.fps)
	print("Speed: " .. math.floor(self.player.Velocity.Magnitude * 100) / 100 .. " (ups)")
	print("Top: " .. math.floor(self.topSpeed * 100) / 100 .. " (ups)")
end

return playerDebug
