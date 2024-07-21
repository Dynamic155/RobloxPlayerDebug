-- This script will just call the functions in the module. <3

local replicatedStorage = game:GetService("ReplicatedStorage")
local playerDebugModule = require(replicatedStorage:WaitForChild("debug"))

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

assert(character:FindFirstChild("HumanoidRootPart"), "Character does not have a HumanoidRootPart")

local playerDebug = playerDebugModule.new(character.HumanoidRootPart)

game:GetService("RunService").Heartbeat:Connect(function(dt)
  playerDebug:update(dt)

  local statsTable = playerDebug:stats()

  frame.fps.Text = "FPS: " ..statsTable.fps
  frame.speed.Text = "SPEED: " ..statsTable.speed
  frame.topSpeed.Text = "TOP: " ..statsTable.top
end)
