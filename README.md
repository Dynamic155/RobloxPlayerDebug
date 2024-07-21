<div align="left">
    <h1 align="left"><strong>R O &nbsp; D E B U G</h1>
    </strong>
    <p>A customizable and easy-to-use debug system for monitoring player statistics such as FPS and speed in Roblox
        games.</p>
</div>
<div align="left">
    <h1 align="left"><strong>I N F O</h1>
    </strong>
    <p>This module provides a framework for tracking and displaying real-time debug information in Roblox games,
        including:</p>
    <ul>
        <li>Real-time FPS display</li>
        <li>Current speed display</li>
        <li>Top speed tracking</li>
        <li>Easy integration with existing projects</li>
    </ul>
</div>
<div align="left">
    <h1 align="left"><strong>U S A G E</h1>
    </strong>
    <p>To use this debug system in your project, follow these steps:</p>
    <ol>
        <li>Download the module script and place it in <code>ReplicatedStorage</code>. For consistency, name it
            <code>debug</code>.</li>
        <li>Include the following script in a LocalScript to initialize and run the debug system:</li>
    </ol>
</div>

```lua
local replicatedStorage = game:GetService("ReplicatedStorage")
local playerDebugModule = require(replicatedStorage:WaitForChild("debug"))

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

assert(character:FindFirstChild("HumanoidRootPart"), "Character does not have a HumanoidRootPart")

local playerDebug = playerDebugModule.new(character.HumanoidRootPart)

game:GetService("RunService").Heartbeat:Connect(function(dt)
    playerDebug:update(dt)
end)

game:GetService("RunService").RenderStepped:Connect(function()
    print(playerDebug:stats()) -- Will print a table
    print(playerDebug:stats().fps) -- Prints FPS
    print(playerDebug:stats().speed) -- Prints Player Speed
    print(playerDebug:stats().top) -- Prints Player's Top Speed
end)
```

<div align="left">
    <h1 align="left"><strong>M O D U L E &nbsp; S C R I P T</h1>
    </strong>
    <p>Place this script in a ModuleScript in <code>ReplicatedStorage</code>. The main functionalities include:</p>
    <ul>
        <li><code>new(player)</code>: Initializes a new debug object for the specified player.</li>
        <li><code>update(dt)</code>: Updates the frame count, time, FPS, and top speed.</li>
        <li><code>stats()</code>: Returns a table containing the current FPS, speed, and top speed.</li>
    </ul>
    <p>The module script creates an object with methods to track and print the player's FPS and speed statistics:</p>
</div>

```lua
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

function playerDebug:stats()
    local dict = {
        fps = self.fps,
        speed = math.floor(self.player.Velocity.Magnitude * 100) / 100 .. " (ups)",
        top = math.floor(self.topSpeed * 100) / 100 .. " (ups)"
    }

    return dict
end

return playerDebug
```
<div align="left">
    <h1 align="left"><strong>C O N T R I B U T I N G</h1>
    </strong>
    <p>Feel free to contribute to this project by opening issues or submitting pull requests. Any improvements or bug
        fixes are welcome!</p>
</div>
<div align="left">
    <h1 align="left"><strong>L I C E N S E</h1>
    </strong>
    <p>This project is licensed under the GNU General Public License v3.0. See the <a href="LICENSE">LICENSE</a> file for details.</p>
</div>
