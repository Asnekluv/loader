local ktask = task
setreadonly(ktask,false)

local cloneref = cloneref or function(...)
    return ...
end

-- services
local Players = cloneref(game:GetService("Players"))
local CoreGui = cloneref(game:GetService("CoreGui"))
local StarterGui = cloneref(game:GetService("StarterGui"))
local Workspace, workspace = (cloneref(game:GetService("Workspace"))) , cloneref(game:GetService("Workspace"))
local Lighting = cloneref(game:GetService("Lighting"))
local RunService = cloneref(game:GetService("RunService"))
local HttpService = cloneref(game:GetService("HttpService"))
local UserInputService , UIS = (cloneref(game:GetService("UserInputService"))) , cloneref(game:GetService("UserInputService"))
local TweenService = cloneref(game:GetService("TweenService"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local VirtualUser = cloneref(game:GetService("VirtualUser"))

--  variables
local lp, speaker = (cloneref(game.Players.LocalPlayer)) , cloneref(game.Players.LocalPlayer)
local NotificationLoad = loadstring(game:HttpGet(('https://raw.githubusercontent.com/treeofplant/Notif/main/library.lua'),true))() -- << other noti
local origsettings = {abt = Lighting.Ambient, oabt = Lighting.OutdoorAmbient, brt = Lighting.Brightness, time = Lighting.ClockTime, fe = Lighting.FogEnd, fs = Lighting.FogStart, gs = Lighting.GlobalShadows}
local Notif2 = loadstring(game:HttpGet("https://asuneki.netlify.app/assets/lua/6FtjxFBNBD/Notif.lua"))();
local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
local sethidden = sethiddenproperty or set_hidden_property or set_hidden_prop
local gethidden = gethiddenproperty or get_hidden_property or get_hidden_prop

local protected_objs = {}
local preventObjs = {}

local oldnamecall

-- namecalls to hook
local namecallmethods = {
    "FindFirstChildOfClass",
    "FindFirstChildWhichIsA",
    "findFirstChildOfClass",
    "findFirstChildWhichIsA"
}

-- more namecalls to hook
local namecallmethods2 = {
    "children",
    "GetChildren",
    "getChildren",
    "GetDescendants",
    "getDescendants",
    "GetJoints",
    "getJoints",
    "GetConnectedParts",
    "getConnectedParts"
}

-- functions to hook
local findmethods = {
    [game.FindFirstChildOfClass] = true,
    [game.findFirstChildWhichIsA] = true
}

-- more functions to hook
local arraymethods = {
    game.GetChildren,
    game.GetDescendants,
    Instance.new("Part").GetJoints,
    Instance.new("Part").GetConnectedParts
}

-- fly (Infinite Yield)
local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
local SPEED = 0
local flyspd = 1
local FLYING

-- ui
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- settings themes ui
local Themes = {"Dark","Darker","Light","Aqua","Amethyst","Rose"}
local DoRandom16 = math.random(1 * 6) -- math.random(1~6) << Lua not Luau~
local RandomThemes = Themes[DoRandom16]
print("Here Is your Themes. ",RandomThemes)

-- test
local P
p = xpcall(function()
    local x, c = pcall(function()
        return CoreGui
    end)
    if x and c then
        return c
    end
    x, c = pcall(function()
        return (game:IsLoaded() or (game.Loaded:Wait() or 1)) and Players.LocalPlayer:WaitForChild("PlayerGui")
    end)
    if x and c then
        return c
    end
    x, c = pcall(function()
        return StarterGui
    end)
    if x and c then
        return c
    end
    return error("Seriously bad exploit. Can't find a place to store the GUI.")
end, function()
end)

repeat wait() until game:IsLoaded()

-- Luraph
if not LPH_OBFUSCATED then
	LPH_JIT_MAX = (function(...) return ... end)
	LPH_NO_VIRTUALIZE = (function(...) return ... end)
	LPH_NO_UPVALUES = (function(...) return ... end)
end
-- functions
local function InMyNetWork(object)
	if isnetworkowner then
		return isnetworkowner(object)
	else
		if (object.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 200 then 
			return true
		end
		return false
	end
end
function ToPlayers(...)
    local T = {
        ...
    }
    local TP = T[1]
    local P
    if type(TP) == "vector" then
        P = CFrame.new(TP)
    elseif type(TP) == "userdata" then
        P = TP
    elseif type(TP) == "number" then
        P = CFrame.new(unpack(T))
    end
    if Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 then
        if tween then
            tween:Cancel()
        end
        repeat
            ktask.wait()
        until Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 0
        wait(0.2)
    end
    local Tween = {}
    local Distance = (P.Position - Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude
	if Distance < 300 then
		Speed = 300
	elseif Distance < 500 then
		Speed = 385
	elseif Distance < 1000 then
		Speed = 355
	elseif Distance >= 1000 then
		Speed = 335
	end
    local Info = TweenInfo.new((P.Position - Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude / Speed, Enum.EasingStyle.Linear)
    local L_253_, L_254_ = xpcall(function()
        tween = TweenService:Create(Players.LocalPlayer.Character["HumanoidRootPart"], Info, {
            CFrame = P
        })
        tween:Play()
    end, function()
        print("Tween Error Can't Find HumanoidRootPart (Maybe)")
    end)
    function Tween:Stop()
        tween:Cancel()
    end
    function Tween:Wait()   
        tween.Completed:Wait()
    end
    return Tween
end
toTarget = LPH_JIT_MAX(function(...)
	local RealtargetPos = {...}
	local targetPos = RealtargetPos[1]
	local RealTarget
	if type(targetPos) == "vector" then
		RealTarget = CFrame.new(targetPos)
	elseif type(targetPos) == "userdata" then
		RealTarget = targetPos
	elseif type(targetPos) == "number" then
		RealTarget = CFrame.new(unpack(RealtargetPos))
	end

	local CheckInOut2 = (RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude

	local VectorTeleport
	local ReMagnitude
	local WarpTween = false

	local tweenfunc = {}
	local Distance = (RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude
	if Distance < 300 then
		Speed = 300
	elseif Distance < 500 then
		Speed = 385
	elseif Distance < 1000 then
		Speed = 355
	elseif Distance >= 1000 then
		Speed = 335
	end

	local tween_s = game:service"TweenService"
	local TimeToGo = (RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude/Speed
	local info = TweenInfo.new(TimeToGo, Enum.EasingStyle.Linear)
	local tweenw, err = pcall(function()
		tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = RealTarget})
		tween:Play()
	end)

	function tweenfunc:Stop()
		return tween:Cancel()
	end

	function tweenfunc:Wait()
		return tween.Completed:Wait()
	end

	function tweenfunc:Time()
		return TimeToGo
	end

	return tweenfunc
end)
function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end
function GetBase()
    return Players.LocalPlayer.stats["Battle Region"].Value
 end
function toAroundTarget(CF)
	if TeleportType == 1 then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CF * CFrame.new(0, 30, 1)
	elseif TeleportType == 2 then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CF * CFrame.new(0, 1, 30)
	elseif TeleportType == 3 then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CF * CFrame.new(1, 1, -30)
	elseif TeleportType == 4 then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CF * CFrame.new(30, 1, 0)
	elseif TeleportType == 5 then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CF * CFrame.new(-30, 1, 0)
	else
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CF * CFrame.new(0, 30, 1)
	end
end
function FPSBooster()
    local _function = true
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    local t = w.Terrain
    sethidden(l, "Technology", 2)
    sethidden(t, "Decoration", false)
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 0
    l.GlobalShadows = false
    l.FogEnd = 9e9
    l.Brightness = 0
    settings().Rendering.QualityLevel = "Level01"
    for i, v in pairs(g:GetDescendants()) do
        if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") and _function then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
            v.Enabled = false
        elseif v:IsA("MeshPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
            v.TextureID = 10385902758728957
        end
    end
    for i, v in pairs(l:GetChildren()) do
        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
            v.Enabled = false
        end
    end
end
function equiprincess()
    for i,v in pairs(lp:FindFirstChildOfClass("Backpack"):GetChildren()) do
        if v.Name == "Princess" then
            v.Parent = lp.Character
        end
    end
end
-- random string
function randomString()
    local length = math.random(5,12)
    local array = {}
    for i = 1, length do
        array[i] = string.char(math.random(32, 67))
    end
    return table.concat(array)
end
local function randomStr()
    local str = ""
    for _ = 1, math.random(8,15) do
        str = str..string.char(math.random(97,122))
    end
    return str
end
-- function to safely add the Fly instances 
local function safeAdd(char)
    local root = char:WaitForChild("HumanoidRootPart", 10)
    local signals = {}

    -- disabling .DescendantAdded and ChildAdded connections and adding them to the table to re-enable later
    for i,v in pairs(getconnections(game.DescendantAdded)) do
        if v.Enabled then
            v:Disable()
            signals[#signals+1] = v
        end
    end

    for i,v in pairs(getconnections(workspace.DescendantAdded)) do
        if v.Enabled then
            v:Disable()
            signals[#signals+1] = v
        end
    end 

    for i,v in pairs(getconnections(workspace.ChildAdded)) do
        if v.Enabled then
            v:Disable()
            signals[#signals+1] = v
        end
    end 

    table.insert(preventObjs, workspace)
    table.insert(preventObjs, game)
    table.insert(preventObjs, root)

    local BG = Instance.new("BodyGyro")
    local BV = Instance.new("BodyVelocity")
    local weld = Instance.new("Weld")
    local part = Instance.new("Part")

    -- inserting all the Fly instances to the protected objs table
    table.insert(protected_objs, BG)
    table.insert(protected_objs, BV)
    table.insert(protected_objs, weld)
    table.insert(protected_objs, part)

    -- random name to instances so the game can't index or :FindFirstChild them
    weld.Name = randomStr()
    part.Name = randomStr()
    BG.Name = randomStr()
    BV.Name = randomStr()

    weld.Parent = part
    weld.Part0 = root
    weld.Part1 = part

    BG.Parent = part
    BV.Parent = part

    part.Parent = Workspace

    -- enabling all the connections after parenting the object
    for i,v in pairs(signals) do
        v:Enable()
    end

    return BG, BV
end
local function FLY()
    FLYING = true
    local T = lp.Character.HumanoidRootPart
    local BG, BV = safeAdd(lp.Character)

    BG.P = 9e4

    BG.maxTorque = Vector3.new(9e9,9e9,9e9)
    BG.CFrame = T.CFrame

    BV.Velocity = Vector3.new(0,0,0)
    BV.maxForce = Vector3.new(9e9,9e9,9e9)

    repeat wait()
        if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
            SPEED = 50
        elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
            SPEED = 0
        end
        if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
            BV.Velocity = ((Workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((Workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - Workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
            lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
        elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
            BV.Velocity = ((Workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - Workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
        else
            BV.Velocity = Vector3.new(0,0,0)
        end
        BG.CFrame = Workspace.CurrentCamera.CoordinateFrame
    until not FLYING or not lp.Character:FindFirstChildOfClass("Humanoid") or lp.Character.Humanoid.Health <= 0
    CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    SPEED = 0
    BV.Parent:Destroy()
    protected_objs = {}
    preventObjs = {}
end

-- random things
Bo3yV5loc1ty = randomString()
p1rtN1m4 = randomString()
Pl1tform = randomString()
Pl1yern1me = randomString()

-- Tables
local TablePlayer = {}
for i,v in next, Players:GetPlayers() do
    table.insert(TablePlayer, v.Name)
end

--[[ RunService or Connect

RunService.Stepped:Connect(function() end)
RunService.Heartbeat:Connect(function() end)
RunService.RenderStepped:Connect(function() end)

RunService.Heartbeat:wait()
RunService.Stepped:Wait()

]]

local JoinBattle = 0

-- Create Windows
local Window = Fluent:CreateWindow({ Title = "kill monster to save the princes",SubTitle = "By Stacia",TabWidth = 160,Size = UDim2.fromOffset(580, 400),Acrylic = true,Theme = RandomThemes,MinimizeKey = Enum.KeyCode.RightShift}) 
local Options = Fluent.Options

-- Tabs
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "component" }),
    Players = Window:AddTab({ Title = "Players", Icon = "bar-chart-horizontal-big" }),
}
-- Toggle Main Tabs~
local Main2 = Tabs.Main:AddToggle("", {Title = "Auto Farm", Description = "fully undetected and auto join battle and equip princess", Default = false})
Main2:OnChanged(function(v)
    getgenv().Tween2mobs = v
    while getgenv().Tween2mobs do ktask.wait()
        pcall(function()
            if JoinBattle == 0 then
                game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Battle"):WaitForChild("JoinPrepare"):FireServer()
                JoinBattle = JoinBattle + 1
            elseif JoinBattle ~= 0 then
                repeat ktask.wait()
                    if not getgenv().Tween2mobs then
                        getgenv().BodyVelocity = false
                        getgenv().Noclip = false
                    end
                    if getgenv().Tween2mobs then
                        equiprincess()
                        for i,v in pairs(Workspace.Waves:FindFirstChild(GetBase()).Enemy:GetChildren()) do
                            if v:IsA("Model") and v:FindFirstChildOfClass("Humanoid") and v:FindFirstChildOfClass("Humanoid").Health > 0 then
                                getgenv().BodyVelocity = true
                                getgenv().Noclip = true
                                game.Players.LocalPlayer.Character.PrimaryPart.CFrame = CFrame.new(v.PrimaryPart.Position + Vector3.new(0, 7, 0), v.PrimaryPart.Position)
                                --[[
                                if lp:DistanceFromCharacter(v.PrimaryPart.Position) < 10 then
                                    game:GetService("ReplicatedStorage").Remote.Weapon.TakeDamage:FireServer()
                                end
                                ]]--
                            end
                        end
                    end
                until not getgenv().Tween2mobs or lp.Character:FindFirstChild("Humanoid").Health <= 0
                JoinBattle = 0
                Players.LocalPlayer.Character:FindFirstChild("Humanoid"):ChangeState(15)
            end
        end)
    end
end)

-- Toggle Players Tabs~
local SelectPlr = Tabs.Players:AddDropdown("SelectedPlyer", {
	Title = "Player(s)",
	Values = TablePlayer,
	Multi = false,
	Default = 1,
})
SelectPlr:SetValue("nil")
SelectPlr:OnChanged(function(v)
	getgenv().SelectPly = v
end)
local Teleport2Lp = Tabs.Players:AddToggle("ToggleTeleport", {
    Title = "Tween To Players",
    Default = false
})
Teleport2Lp:OnChanged(function(v)
    getgenv().TeleportPly = v
    while getgenv().TeleportPly do wait()
        pcall(function()
            if getgenv().RenPosition then
                getgenv().BodyVelocity = true
                toAroundTarget(Players:FindFirstChild(getgenv().SelectPly).Character.HumanoidRootPart.CFrame)
            end
            if not getgenv().RenPosition then
                if getgenv().TeleportPly and not getgenv().RenPosition then
                    getgenv().Noclip = true
                    getgenv().BodyVelocity = true
                    repeat
                        ktask.wait()
                        toTarget(Players:FindFirstChild(getgenv().SelectPly).Character.HumanoidRootPart.CFrame * CFrame.new(0,0,5))
                    until not getgenv().TeleportPly
                    getgenv().Noclip = false
                    getgenv().BodyVelocity = false
                end
            else
                getgenv().Noclip = false
                getgenv().BodyVelocity = false
            end
        end)
    end
end)
local RenPosition = Tabs.Players:AddToggle("rp", {Title = "Random Position", Default = false })
RenPosition:OnChanged(function(Value)
    getgenv().RenPosition = Value
end)
Options.ToggleTeleport:SetValue(false)
local SpectatePly = Tabs.Players:AddToggle("ToggleQuanSat", {
    Title = "Spectate Player",
    Default = false
})
SpectatePly:OnChanged(function(v)
    getgenv().SpectateSelect = v
    pcall(function()
        repeat
            wait()
            Workspace.Camera.CameraSubject = Players:FindFirstChild(getgenv().SelectPly).Character:FindFirstChildOfClass("Humanoid")
        until getgenv().SpectateSelect == false
        Workspace.Camera.CameraSubject = Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    end)
end)
local Keybind = Tabs.Players:AddKeybind("Keybind", {
    Title = "Fly",
    Mode = "Toggle",
    Default = "N",
    Callback = function(Value)
        pcall(function()
            if not FLYING then
                FLY()
            else
                FLYING = false
            end
        end)
    end,
})
local Flight = Tabs.Players:AddSlider("Slider", {
    Title = "Fly Speed",
    Description = "Universal Fly by z4gs",
    Default = 2,
    Min = 3,
    Max = 30,
    Rounding = 1,
    Callback = function(Value)
        flyspd = Value
    end
})
Flight:OnChanged(function(Value)
    flyspd = Value
end)
Flight:SetValue(3)
--[[
local xs1N7CBfw = Tabs.Players:AddSection("Modified / Hitbox / Player(s)")
local HitboxsSider = Tabs.Players:AddSlider("Hitboxs", {
    Title = "Set A Hitboxs",
    Default = 3,
    Min = 3,
    Max = 80,
    Rounding = 10,
    Callback = function(v)
        getgenv().Hitboxhere = v
    end
})
HitboxsSider:OnChanged(function(v)
    getgenv().Hitboxhere = v
end)
local ModedSize = Tabs.Players:AddToggle("MyToggle", {Title = "Set Hitbox", Default = false })
ModedSize:OnChanged(function(v)
    getgenv().Started = v
end)
]]

-- metamethods hooking
oldnamecall = hookmetamethod(game, "__namecall", function(obj, ...)
    local method = getnamecallmethod()

    if not checkcaller() then
        if table.find(preventObjs, obj) and table.find(namecallmethods2, method) then
            local content = oldnamecall(obj, ...)

            for i,v in pairs(protected_objs) do
                local index = table.find(content, v)
                if index then
                    content[index] = nil
                end
            end

            gcinfo()

            return content
        elseif table.find(namecallmethods, getnamecallmethod()) and table.find(preventObjs, obj) and table.find(protected_objs, oldnamecall(obj, ...)) then
            -- return nil if the object returned from the function is a protected object
            return nil
        end
    end

    return oldnamecall(obj, ...)
end)

-- functions hooking
for i,v in pairs(arraymethods) do
    local old

    old = hookfunction(v, function(obj, ...)
        if not checkcaller() and table.find(preventObjs, obj) then
            -- get the table with the instances
            local content = old(obj, ...)
    
            for i,v in pairs(protected_objs) do
                local index = table.find(content, v)
                if index then
                    -- remove the protected object from the table
                    content[index] = nil
                end
            end
    
            -- update the table's index
            gcinfo()
    
            -- return the edited table
            return content
        end

        return old(obj, ...)
    end)
end

-- functions hooking
for i,v in pairs(arraymethods) do
    local old

    old = hookfunction(v, function(obj, ...)
        if not checkcaller() and table.find(preventObjs, obj) then
            -- get the table with the instances
            local content = old(obj, ...)
    
            for i,v in pairs(protected_objs) do
                local index = table.find(content, v)
                if index then
                    -- remove the protected object from the table
                    content[index] = nil
                end
            end
    
            -- update the table's index
            gcinfo()
    
            -- return the edited table
            return content
        end

        return old(obj, ...)
    end)
end

for i,v in pairs(findmethods) do
    local old

    old = hookfunction(i, function(obj, ...)
        if table.find(preventObjs, obj) and table.find(protected_objs, old(obj, ...)) then
            -- return nil if the object returned from the function is a protected object
            return nil
        end

        return old(obj, ...)
    end)
end

-- main fly function
UIS.InputBegan:Connect(function(input, proccess)
    if proccess then return end
    if input.keyCode == Enum.KeyCode.W then
        CONTROL.F = flyspd
    elseif input.keyCode == Enum.KeyCode.S then
        CONTROL.B = - flyspd
    elseif input.keyCode == Enum.KeyCode.A then
        CONTROL.L = - flyspd
    elseif input.keyCode == Enum.KeyCode.D then 
        CONTROL.R = flyspd 
    end
end)
UIS.InputEnded:Connect(function(input, proccess)
    if proccess then return end
    if input.keyCode == Enum.KeyCode.W then
        CONTROL.F = 0
    elseif input.keyCode == Enum.KeyCode.S  then
        CONTROL.B = 0
    elseif input.keyCode == Enum.KeyCode.A then
        CONTROL.L = 0
    elseif input.keyCode == Enum.KeyCode.D then
        CONTROL.R = 0
    elseif input.keyCode == Enum.KeyCode.E then
        CONTROL.Q = 0
    elseif input.keyCode == Enum.KeyCode.Q then
        CONTROL.E = 0
    end
end)

-- spawn funciton main writing by Syl1y <3
spawn(function()
    while ktask.wait() do
        pcall(function()
            if getgenv().BodyVelocity == true then
                repeat
                    ktask.wait()
                    if not lp.Character.HumanoidRootPart:FindFirstChild(Bo3yV5loc1ty) then
                        if getgenv().BodyVelocity == true then
                            local N7NafHvvfgcPF58 = Instance.new("BodyVelocity")
                            N7NafHvvfgcPF58.Name = Bo3yV5loc1ty
                            N7NafHvvfgcPF58.Parent = lp.Character.HumanoidRootPart
                            N7NafHvvfgcPF58.MaxForce = Vector3.new(9e9,9e9,9e9)
                            N7NafHvvfgcPF58.Velocity = Vector3.new(0,0,0)
                        end
                    end
                until getgenv().BodyVelocity == false or lp.Character:FindFirstChildOfClass("Humanoid").Health == 0
            else
                if lp.Character.HumanoidRootPart:FindFirstChild(Bo3yV5loc1ty) then
                    lp.Character.HumanoidRootPart:FindFirstChild(Bo3yV5loc1ty):Destroy()
                end
            end
        end)
    end
end)
spawn(function()
    while ktask.wait() do
        if getgenv().Noclip or getgenv().Noclip == true then
            pcall(function()
                for _,v in pairs(lp.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end)
        end 
    end
end)

-- other not main
spawn(function()
	while ktask.wait() do
		TeleportType = math.random(1,5)
		ktask.wait(0.3)
	end
end)

-- RunService
RunService.RenderStepped:Connect(function() 
    pcall(function()
        if getgenv().Tween2mobs then
            ReplicatedStorage:WaitForChild("Remote"):WaitForChild("Weapon"):WaitForChild("TakeDamage"):FireServer()
        end
    end)
end)
RunService.RenderStepped:Connect(function()
    pcall(function()
        if getgenv().Tween2mobs then
            for i, v in pairs(game:GetService("Workspace").Waves:GetDescendants()) do
                if v.Name == "Cheat" then
                    v:Destroy()
                    print("Gotcha AntiCheat!?!?")
                end
            end
        end
    end)
end)
--[[    
RunService.RenderStepped:Connect(function()
        if getgenv().Started then
            for i,v in next, Players:GetPlayers() do
                if v.Name ~= Players.LocalPlayer.Name then
                    pcall(function()
                        if getgenv().Started then
                            v.Character.HumanoidRootPart.Size = Vector3.new(getgenv().Hitboxhere,getgenv().Hitboxhere,getgenv().Hitboxhere)
                            v.Character.HumanoidRootPart.Transparency = 0.9
                            v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
                            v.Character.HumanoidRootPart.Material = "Smooth Plastic"
                            v.Character.HumanoidRootPart.CanCollide = false
                            getgenv().Noclip = true
                        else
                            getgenv().Noclip = false
                        end
                    end)
                end
            end
        end
    end)
--]]

xpcall(function()
    print("\nConfig<>\n","AntiAFK",shared.Configs.Global_Setting.AntiAFK,"NoclipCamera",shared.Configs.Global_Setting.NoclipCamera,"RandomName",shared.Configs.Global_Setting.RandomName)
end, function()
    print("No Config")
end)

-- for config~
spawn(function()
    pcall(function()
        if shared.Configs.Global_Setting.AntiAFK then
            local GC = getconnections or get_signal_cons
            if GC then
                for i,v in pairs(GC(Players.LocalPlayer.Idled)) do
                    if v["Disable"] then
                        v["Disable"](v)
                    elseif v["Disconnect"] then
                        v["Disconnect"](v)
                    end
                end
            else
                Players.LocalPlayer.Idled:Connect(function()
                    VirtualUser:CaptureController()
                    VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                    wait(1)
                    VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                    warn("Debug : AntiAFK")
                end)
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        if shared.Configs.Global_Setting.NoclipCamera then
            local sc = (debug and debug.setconstant) or setconstant
            local gc = (debug and debug.getconstants) or getconstants
            local pop = lp.PlayerScripts.PlayerModule.CameraModule.ZoomController.Popper
            for _, v in pairs(getgc()) do
                if type(v) == 'function' and getfenv(v).script == pop then
                    for i, v1 in pairs(gc(v)) do
                        if tonumber(v1) == .25 then
                            sc(v, i, 0)
                        elseif tonumber(v1) == 0 then
                            sc(v, i, .25)
                        end
                    end
                end
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        if shared.Configs.Global_Setting.RandomName then
            getgenv().L2name = Pl1yern1me
            for Index, Value in next, game:GetDescendants() do
                if Value.ClassName == "TextLabel" then
                    local has = string.find(Value.Text, lp.Name)
                    if has then
                        local str = Value.Text:gsub(lp.Name, getgenv().L2name)
                        Value.Text = str
                    end
                    Value:GetPropertyChangedSignal("Text"):Connect(
                        function()
                            local str = Value.Text:gsub(lp.Name, getgenv().L2name)
                            Value.Text = str
                        end
                    )
                end
            end
            game.DescendantAdded:Connect(
                function(Value)
                    if Value.ClassName == "TextLabel" then
                        local has = string.find(Value.Text, lp.Name)
                        Value:GetPropertyChangedSignal("Text"):Connect(
                            function()
                                local str = Value.Text:gsub(lp.Name, getgenv().L2name)
                                Value.Text = str
                            end
                        )
                        if has then
                            local str = Value.Text:gsub(lp.Name, getgenv().L2name)
                            Value.Text = str
                        end
                    end
                end
            )
        end
    end)
end)

do
    print("reset config")
    shared.Configs = {
        ["Global_Setting"] = {
            ["AntiAFK"] = false,
            ["NoclipCamera"] = false,
            ["RandomName"] = false
        }
    }
    print("done",tick())
end

-- ! key bind ui
NotificationLoad:NewNotification({
    ["Mode"] = "Info", -- Choose one (Success/Info/Error)
    ["Title"] = "Key Bind", -- Title of notification
    ["Description"] = "ur MinimizeKey is RightShift", -- Description of notification
    ["Timeout"] = 10, -- How long the notification will last (Change to false if you want no timer)
    ["Audio"] = true -- Plays audio if enabled on each notification
})

-- ene of line
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'TextboxIdentifier'})
InterfaceManager:SetFolder("SynteisLib/Configs")
SaveManager:SetFolder("SynteisLib/Configs")
local Settings = Window:AddTab({
    Title = "Settings",
    Icon = "settings"
})
InterfaceManager:BuildInterfaceSection(Settings)
SaveManager:BuildConfigSection(Settings)
Window:SelectTab(1)
SaveManager:LoadAutoloadConfig()
