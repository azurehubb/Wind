local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:AddTheme({
    Name = "Tecca", -- theme name
    
    Accent = Color3.fromHex("#18181b"),
    Background = Color3.fromHex("#101010"), -- Accent
    Outline = Color3.fromHex("#FFFFFF"),
    Text = Color3.fromHex("#FFFFFF"),
    Placeholder = Color3.fromHex("#7a7a7a"),
    Button = Color3.fromHex("#52525b"),
    Icon = Color3.fromHex("#a1a1aa"),
})

local Window = WindUI:CreateWindow({
    Title = "tecca Hub",
    Icon = "door-open", -- lucide icon
    Author = "by .ftgs and .ftgs",
    Folder = "MySuperHub",
    
    -- ↓ This all is Optional. You can remove it.
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    
    -- ↓ Optional. You can remove it.
    --[[ You can set 'rbxassetid://' or video to Background.
        'rbxassetid://':
            Background = "rbxassetid://", -- rbxassetid
        Video:
            Background = "video:YOUR-RAW-LINK-TO-VIDEO.webm", -- video 
    --]]
    
    -- ↓ Optional. You can remove it.
    User = {
        Enabled = true,
        Anonymous = true,
        Callback = function()
            print("clicked")
        end,
    },
    
    local Keybind = Tab:Keybind({
    Title = "Keybind",
    Desc = "Keybind to open ui",
    Value = "G",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
})

WindUI:AddTheme({
    Name = "Tecca", -- theme name
    
    Accent = Color3.fromHex("#18181b"),
    Background = Color3.fromHex("#101010"), -- Accent
    Outline = Color3.fromHex("#FFFFFF"),
    Text = Color3.fromHex("#FFFFFF"),
    Placeholder = Color3.fromHex("#7a7a7a"),
    Button = Color3.fromHex("#52525b"),
    Icon = Color3.fromHex("#a1a1aa"),
})

local Tab = Window:Tab({
    Title = "example tab",
    Icon = "bird", -- optional
    Locked = false,
})

local settings = {
    Color = Color3.fromRGB(0, 255, 0), -- Changed text color to green
    Size = 15,
    Transparency = 1, -- 1 Visible - 0 Not Visible
    AutoScale = true
}

local space = game:GetService("Workspace")
local player = game:GetService("Players").LocalPlayer
local camera = space.CurrentCamera

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Blissful4992/ESPs/main/UniversalSkeleton.lua"))()

local Skeletons = {}

local function NewText(color, size, transparency)
    local text = Drawing.new("Text")
    text.Visible = false
    text.Text = ""
    text.Position = Vector2.new(0, 0)
    text.Color = color
    text.Size = size
    text.Center = true
    text.Transparency = transparency
    return text
end

local function CreateSkeleton(plr)
    local skeleton = Library:NewSkeleton(plr, true)
    skeleton.Size = 50 -- Super wide and large for maximum visibility
    skeleton.Static = true -- Ensures the skeleton stays still
    table.insert(Skeletons, skeleton)

    local nameTag = NewText(settings.Color, settings.Size, settings.Transparency)

    game:GetService("RunService").RenderStepped:Connect(function()
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local HumanoidRootPart_Pos, OnScreen = camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
            if OnScreen then
                local distance = math.floor((player.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude)
                nameTag.Text = string.format("%s [%d Studs]", plr.Name, distance)
                nameTag.Position = Vector2.new(HumanoidRootPart_Pos.X, HumanoidRootPart_Pos.Y - 50)
                nameTag.Visible = true
            else
                nameTag.Visible = false
            end
        else
            nameTag.Visible = false
        end
    end)
end

for _, plr in pairs(game.Players:GetPlayers()) do
    if plr.Name ~= player.Name then
        CreateSkeleton(plr)
    end
end

game.Players.PlayerAdded:Connect(function(plr)
    CreateSkeleton(plr)
end)

-- Lock skeletons in place and prevent movement
while true do
    for _, skeleton in pairs(Skeletons) do
        if skeleton.Part then
            skeleton.Part.Anchored = true -- Ensures the skeleton doesn't move
        end
    end
    wait(0.1)
end



local Player = game.Players.LocalPlayer
local Char = Player.Character
while not Char do wait()
	Char = Player.Character
end
local Humanoid = Char:WaitForChild("Humanoid")
local Root = Char:FindFirstChild("HumanoidRootPart")
while not Root do wait()
	Root = Char:FindFirstChild("HumanoidRootPart")
end
local Mouse = Player:GetMouse()
local Cam = game.Workspace.CurrentCamera

local dir = {w = 0, s = 0, a = 0, d = 0}
local spd = 2
Mouse.KeyDown:connect(function(key)
	if key:lower() == "w" then
		dir.w = 1
	elseif key:lower() == "s" then
		dir.s = 1
	elseif key:lower() == "a" then
		dir.a = 1
	elseif key:lower() == "d" then
		dir.d = 1
	elseif key:lower() == "q" then
		spd = spd + 1
	elseif key:lower() == "e" then
		spd = spd - 1
	end
end)
Mouse.KeyUp:connect(function(key)
	if key:lower() == "w" then
		dir.w = 0
	elseif key:lower() == "s" then
		dir.s = 0
	elseif key:lower() == "a" then
		dir.a = 0
	elseif key:lower() == "d" then
		dir.d = 0
	end
end)
Root.Anchored = true
Humanoid.PlatformStand = true
Humanoid.Changed:connect(function()
	Humanoid.PlatformStand = true
end)
repeat
	wait(1/44)
	Root.CFrame = CFrame.new(Root.Position, Cam.CoordinateFrame.p) 
		* CFrame.Angles(0,math.rad(180),0)
		* CFrame.new((dir.d-dir.a)*spd,0,(dir.s-dir.w)*spd)
until nil

--Sets field of view in degrees

local Cam = game.Workspace.CurrentCamera
Cam.FieldOfView = script:WaitForChild("FOVSetting").Value

wait(0.1)
script:destroy()

local InputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = game.Players.LocalPlayer
local Cam = game.Workspace.CurrentCamera
local Mouse = Player:GetMouse()
local Char = Player.Character
if not Char or not Char.Parent then
    Char = Player.CharacterAdded:wait()
end
local Root = Char:WaitForChild("HumanoidRootPart")
local Humanoid = Char:WaitForChild("Humanoid")

local Resistance = 0.6 --Percentage of velocity lost per second
local Acceleration = 75 --sps^2
local Flying = true --X toggle disabled
local Coupled = false --Always try to go in the direction we're looking
local LastTick = tick()

local Gyro = Root:FindFirstChild("FlyGyro")
local Vel = Root:FindFirstChild("FlyVel")

function FlyStart()
	Flying = true
	Humanoid.Sit = true
	LastTick = tick()
	
	if not Gyro then
		Gyro = Instance.new("BodyGyro")
		Gyro.Name = "FlyGyro"
		Gyro.maxTorque = Vector3.new(1000,1000,1000)
		Gyro.cframe = Root.CFrame
		Gyro.Parent = Root
	end
	if not Vel then
		Vel = Instance.new("BodyVelocity")
		Vel.Name = "FlyVel"
		Vel.velocity = Vector3.new(0,15,0) --Jump start
		Vel.maxForce = Vector3.new(9e9,9e9,9e9)
		Vel.Parent = Root
	end
end

function FlyEnd()
	Flying = false
	Humanoid.Sit = false
	
	if Gyro then Gyro:destroy() end
	if Vel then Vel:destroy() end
	Gyro = nil
	Vel = nil
end

local w = false
local s = false
local a = false
local d = false
local q = false
local e = false
local Brake = false

InputService.InputBegan:connect(function(Key,gameProcessedEvent)
	if not gameProcessedEvent then --Not chatting or something
		if Key.KeyCode == Enum.KeyCode.W then
			w = true
		elseif Key.KeyCode == Enum.KeyCode.S then
			s = true
		elseif Key.KeyCode == Enum.KeyCode.A then
			a = true
		elseif Key.KeyCode == Enum.KeyCode.D then
			d = true
		elseif Key.KeyCode == Enum.KeyCode.Q then
			q = true
		elseif Key.KeyCode == Enum.KeyCode.E then
			e = true
		elseif Key.KeyCode == Enum.KeyCode.Z then
			Coupled = not Coupled
		elseif Key.KeyCode == Enum.KeyCode.X then
			Brake = true
		elseif Key.KeyCode == Enum.KeyCode.Space then
			Brake = true
		end
	end
end)

InputService.InputEnded:connect(function(Key,gameProcessedEvent)
	if not gameProcessedEvent then --Not chatting or something
		if Key.KeyCode == Enum.KeyCode.W then
			w = false
		elseif Key.KeyCode == Enum.KeyCode.S then
			s = false
		elseif Key.KeyCode == Enum.KeyCode.A then
			a = false
		elseif Key.KeyCode == Enum.KeyCode.D then
			d = false
		elseif Key.KeyCode == Enum.KeyCode.Q then
			q = false
		elseif Key.KeyCode == Enum.KeyCode.E then
			e = false
		elseif Key.KeyCode == Enum.KeyCode.X then
			Brake = false
		elseif Key.KeyCode == Enum.KeyCode.Space then
			Brake = false
		end
	end
end)

RunService.RenderStepped:connect(function()
	if Flying then
		if Coupled then
			--Face where we're looking/going
			Gyro.cframe = Cam.CoordinateFrame
		else
			--Face the mouse I guess
			Gyro.cframe = CFrame.new(Root.Position,Mouse.Hit.p)
		end
	end
end)

FlyStart()

while wait() do
	if Flying then
		local TimeElapsed = tick() - LastTick
		
		--Lock controls to the horizontal plane
		--local Forward = (Cam.CFrame.lookVector - Vector3.new(0,Cam.CFrame.lookVector.y,0)).unit
		--local Right = (Cam.CFrame.rightVector - Vector3.new(0,Cam.CFrame.lookVector.y,0)).unit
		--local Up = Vector3.new(0,1,0)
		
		local Forward = Cam.CFrame.lookVector
		local Right = Cam.CFrame.rightVector
		local Up = Cam.CFrame.upVector
		
		if w and not s then
			Vel.velocity = Vel.velocity + (Forward * Acceleration * TimeElapsed)
		elseif s and not w then
			Vel.velocity = Vel.velocity - (Forward * Acceleration * TimeElapsed)
		end
		if d and not a then
			Vel.velocity = Vel.velocity + (Right * Acceleration * TimeElapsed)
		elseif a and not d then
			Vel.velocity = Vel.velocity - (Right * Acceleration * TimeElapsed)
		end
		if e and not q then
			Vel.velocity = Vel.velocity + (Up * Acceleration * TimeElapsed)
		elseif q and not e then
			Vel.velocity = Vel.velocity - (Up * Acceleration * TimeElapsed)
		end
		
		if Coupled then
			--Fly like a plane, go where we're pointing
			Vel.velocity = Root.CFrame.lookVector * Vel.velocity.magnitude
		else
			--More of a hovering style
			
		end
		
		--Slow down automatically (Air resistance) or with brake
		if Brake then
			Vel.velocity = Vel.velocity * (1 - (Resistance * TimeElapsed * 10))
		else
			Vel.velocity = Vel.velocity * (1 - (Resistance * TimeElapsed))
		end
		if Vel.velocity.magnitude < 0.1 then
			Vel.velocity = Vector3.new(0,0,0)
		end
		LastTick = tick()
	end
end