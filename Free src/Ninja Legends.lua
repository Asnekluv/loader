local ktask = task
setreadonly(ktask,false)
-- just lazy to fix bug

do
    if getgenv().Noclip then
        getgenv().Noclip = false
        print("reset Noclip")
    elseif getgenv().BodyVelocity then
        getgenv().BodyVelocity = false
        print("reset BodyVelocity")
    else
        print("finished",tick())
    end
end

local cloneref = cloneref or function(obj) return obj end

-- services
local Players   = cloneref(game:GetService("Players"))
local CoreGui   = cloneref(game:GetService("CoreGui"))
local StarterGui = cloneref(game:GetService("StarterGui"))
local Workspace = cloneref(game:GetService("Workspace"))
local Lighting = cloneref(game:GetService("Lighting"))
local RunService    = cloneref(game:GetService("RunService"))
local HttpService   = cloneref(game:GetService("HttpService"))
local TweenService  = cloneref(game:GetService("TweenService"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local VirtualUser = cloneref(game:GetService("VirtualUser"))

--  variables
local lp, speaker = (cloneref(game.Players.LocalPlayer)) , cloneref(game.Players.LocalPlayer)
local NotificationLoad = loadstring(game:HttpGet(('https://raw.githubusercontent.com/treeofplant/Notif/main/library.lua'),true))() -- << other noti
local origsettings = {abt = Lighting.Ambient, oabt = Lighting.OutdoorAmbient, brt = Lighting.Brightness, time = Lighting.ClockTime, fe = Lighting.FogEnd, fs = Lighting.FogStart, gs = Lighting.GlobalShadows}
local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
local sethidden = sethiddenproperty or set_hidden_property or set_hidden_prop
local gethidden = gethiddenproperty or get_hidden_property or get_hidden_prop

-- ui
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- settings themes ui
local Themes = {"Dark","Darker","Light","Aqua","Amethyst","Rose"}
local DoRandom16 = math.random(1 * 6) -- math.random(1~6) << Lua not Luau~
local RandomThemes = Themes[DoRandom16]
print("Here Is your Themes. ",RandomThemes)

-- test exploits
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
    return error("Can't find a place to store the GUI.")
end, function()
end)

repeat wait() until game:IsLoaded()

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
-- Luraph
if not LPH_OBFUSCATED then
	LPH_JIT_MAX = (function(...) return ... end)
	LPH_NO_VIRTUALIZE = (function(...) return ... end)
	LPH_NO_UPVALUES = (function(...) return ... end)
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
function equiptool()
    for i,v in pairs(Players.LocalPlayer:FindFirstChildOfClass("Backpack"):GetChildren()) do
        if v.ClassName == "Tool" then
            if v:FindFirstChild("attackKatanaScript") then
                v.Parent = lp.Character
            end
        end
    end
end
function Click()
    game:GetService'VirtualUser':CaptureController()
    game:GetService'VirtualUser':Button1Up(Vector2.new(1280, 672))
    game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
end
function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end
function randomString()
    local length = math.random(5,12)
    local array = {}
    for i = 1, length do
        array[i] = string.char(math.random(32, 67))
    end
    return table.concat(array)
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
local Island2Unlock = {}
for i,v in pairs(Workspace:FindFirstChild("islandUnlockParts"):GetChildren()) do
    table.insert(Island2Unlock, v.Name)
end
CrystalFolder = {}
for i,v in pairs(workspace.mapCrystalsFolder:GetChildren()) do
    table.insert(CrystalFolder, v.Name)
end

-- Create Windows
local Window = Fluent:CreateWindow({ Title = "Ninja Legends | Wednesday, June 5 2024",SubTitle = "By Stacia",TabWidth = 160,Size = UDim2.fromOffset(580, 400),Acrylic = true,Theme = RandomThemes,MinimizeKey = Enum.KeyCode.RightShift}) 
local Options = Fluent.Options

-- Tabs
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "component" }),
    Boss = Window:AddTab({ Title = "Boss", Icon = "swords" }),
    Players = Window:AddTab({ Title = "Players", Icon = "bar-chart-horizontal-big" }),
    Teleport = Window:AddTab({ Title = "Teleports", Icon = "terminal" }),
}
-- Toggle Main Tabs~
local swing = Tabs.Main:AddToggle("", {Title = "auto swing", Default = false})
swing:OnChanged(function(v)
    getgenv().Stacia_swing = v
end)
local autosell = Tabs.Main:AddToggle("lao", {Title = "auto Sell", Default = false})
autosell:OnChanged(function(v)
    getgenv().Stacia_Selled = v
end)
local maxsell = Tabs.Main:AddToggle("lao", {Title = "auto Sell(max)", Default = false})
maxsell:OnChanged(function(v)
    getgenv().Stacia_MaxSell = v
end)
local buyswords = Tabs.Main:AddToggle("lao", {Title = "auto buy Swords", Description = "Delay 0.1 Seconds", Default = false})
buyswords:OnChanged(function(v)
    getgenv().Stacia_SelledbuySwords = v
    while getgenv().Stacia_SelledbuySwords do ktask.wait(.1)
        pcall(function()
            game:GetService("Players").LocalPlayer:WaitForChild("ninjaEvent"):FireServer("buyAllSwords","Blazing Vortex Island")
        end)
    end
end)
local buybelts = Tabs.Main:AddToggle("lao", {Title = "auto buy belts", Description = "Delay 0.1 Seconds", Default = false})
buybelts:OnChanged(function(v)
    getgenv().Stacia_buybelts = v
    while getgenv().Stacia_buybelts do ktask.wait(.1)
        pcall(function()
            game:GetService("Players").LocalPlayer:WaitForChild("ninjaEvent"):FireServer("buyAllBelts","Blazing Vortex Island")
        end)
    end
end)
local buyskills = Tabs.Main:AddToggle("lao", {Title = "auto buy buyskills", Description = "Delay 0.1 Seconds", Default = false})
buyskills:OnChanged(function(v)
    getgenv().Stacia_buybelts = v
    while getgenv().Stacia_buybelts do ktask.wait(.1)
        pcall(function()
            game:GetService("Players").LocalPlayer:WaitForChild("ninjaEvent"):FireServer("buyAllSkills","Blazing Vortex Island")
        end)
    end
end)
local autoWheel = Tabs.Main:AddToggle("lao", {Title = "auto Wheel(24h Cooldown)", Default = false})
autoWheel:OnChanged(function(v)
    getgenv().Stacia_autoWheel = v
    while getgenv().Stacia_autoWheel do ktask.wait()
        pcall(function()
            local args = {
                [1] = "openFortuneWheel",
                [2] = workspace:WaitForChild("Fortune Wheel")
            }
            game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("openFortuneWheelRemote"):InvokeServer(unpack(args))
        end)
    end
end)

-- Toggle Bosses Tabs~
local Dropdown = Tabs.Boss:AddDropdown("Dropdown", {
    Title = "Select Boss",
    Values = {"AncientMagmaBoss","EternalBoss","RobotBoss"},
    Multi = false,
    Default = 1,
})
Dropdown:SetValue(nil)
Dropdown:OnChanged(function(v)
    getgenv().AttachBoss = v
end)
local KillBoss = Tabs.Boss:AddToggle("MyToggle", {Title = "Auto Kill Boss By Selected", Default = false })
KillBoss:OnChanged(function(v)
    getgenv().TweenToBoss = v
    while getgenv().TweenToBoss do ktask.wait()
        pcall(function()
            repeat
                ktask.wait()
                getgenv().Noclip = true
                getgenv().BodyVelocity = true
                if getgenv().AttachBoss == "AncientMagmaBoss" then
                    for _,v in pairs(Workspace.bossFolder:GetChildren()) do
                        if v.Name == "AncientMagmaBoss" and v:FindFirstChild("HumanoidRootPart") then
                            v.HumanoidRootPart.Size = Vector3.new(150,150,150)
                            toAroundTarget(v.HumanoidRootPart.CFrame)
                            Click()
                        end
                    end
                elseif getgenv().AttachBoss == "EternalBoss" then
                    for _,v in pairs(Workspace.bossFolder:GetChildren()) do
                        if v.Name == "EternalBoss" and v:FindFirstChild("HumanoidRootPart") then
                            v.HumanoidRootPart.Size = Vector3.new(150,150,150)
                            toAroundTarget(v.HumanoidRootPart.CFrame)
                            Click()
                        end
                    end
                elseif getgenv().AttachBoss == "RobotBoss" then
                    for _,v in pairs(Workspace.bossFolder:GetChildren()) do
                        if v.Name == "RobotBoss" and v:FindFirstChild("HumanoidRootPart") then
                            v.HumanoidRootPart.Size = Vector3.new(150,150,150)
                            toAroundTarget(v.HumanoidRootPart.CFrame)
                            Click()
                        end
                    end
                end
            until not getgenv().TweenToBoss or not v:FindFirstChild("HumanoidRootPart") or v:FindFirstChild("Humanoid").Health == 0 
            if not getgenv().TweenToBoss then
                getgenv().BodyVelocity = false
                getgenv().Noclip = false
            end
        end)
    end
end)
local InstantBoss = Tabs.Boss:AddToggle("MyToggle", {Title = "Instant Kill Boss", Description = "Select Boss to Kill First", Default = false })
InstantBoss:OnChanged(function(v)
    getgenv().InstantBoss = v
end)
local InstantAllBoss = Tabs.Boss:AddToggle("MyToggle", {Title = "Kill All Boss", Default = false })
InstantAllBoss:OnChanged(function(v)
    getgenv().InstantAllBoss = v
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
            if getgenv().TeleportPly then
                getgenv().Noclip = true
                getgenv().BodyVelocity = true
                repeat
                    ktask.wait()
                    toTarget(Players:FindFirstChild(getgenv().SelectPly).Character.HumanoidRootPart.CFrame * CFrame.new(0,0,5))
                until not getgenv().TeleportPly
                getgenv().Noclip = false
                getgenv().BodyVelocity = false
            end
        end)
    end
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

local infJump
infJumpDebounce = false

local ltFLgShj9CiCKJFCYPJ = Tabs.Players:AddSection("Visual / Client")
local iinfjp = Tabs.Players:AddToggle("", {Title = "inf jump", Description = "From Infinite Yield <3", Default = false})
iinfjp:OnChanged(function(v)
    getgenv().faGStOFQ6W = v
    if getgenv().faGStOFQ6W then
        if infJump then infJump:Disconnect() end
        infJumpDebounce = false
        infJump = UserInputService.JumpRequest:Connect(function()
            if not infJumpDebounce then
                infJumpDebounce = true
                speaker.Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                ktask.wait()
                infJumpDebounce = false
            end
        end)
    else
        if infJump then infJump:Disconnect() end
        infJumpDebounce = false
    end
end)
local nofog = Tabs.Players:AddToggle("", {Title = "RemoveFog", Default = false})
nofog:OnChanged(function(v)
    getgenv().nofog = v
end)
local FullBrightness = Tabs.Players:AddToggle("", {Title = "FullBrightness", Default = false})
FullBrightness:OnChanged(function(v)
    getgenv().FullBrightness = v
end)
local Noclipv = Tabs.Players:AddToggle("", {Title = "Noclip", Description = "you can walk into the wall or objects (if you on Mobile AutoJump will be disabled)", Default = false})
Noclipv:OnChanged(function(v)
    getgenv().Noclip = v
end)
local Platformv = Tabs.Players:AddToggle("", {Title = "Platform", Description = "Enable Function Will bring part to your beneath you causing you to float (And Automatic Enable Noclip)", Default = false})
Platformv:OnChanged(function(v)
    getgenv().Platform = v
    while getgenv().Platform do ktask.wait()
        pcall(function()
            if not getgenv().Platform then
                getgenv().Noclip = false
                if Workspace:FindFirstChild(Pl1tform) then
                    Workspace[Pl1tform]:Destroy()
                end
            end
            if getgenv().Platform then
                getgenv().Noclip = true
                if not Workspace:FindFirstChild(Pl1tform) then
                    local WTCdJCKR2u5xkF = Instance.new("Part")
                    WTCdJCKR2u5xkF.Name = Pl1tform
                    WTCdJCKR2u5xkF.Parent = game.Workspace
                    WTCdJCKR2u5xkF.Anchored = true
                    WTCdJCKR2u5xkF.Transparency = 1
                    WTCdJCKR2u5xkF.Size = Vector3.new(100, 1.6, 100)
                end
            end
        end)
    end
end)
Tabs.Players:AddButton({
    Title = "Boot fps",
    Description = "Very important button",
    Callback = function()
        Window:Dialog({
            Title = "",
            Content = "Bootfps by remove some textures",
            Buttons = {
                {
                    Title = "Confirm (แน่ใจ?)",
                    Callback = function()
                        FPSBooster()
                    end
                },
                {
                    Title = "Cancel (ยกเลก)",
                    Callback = function()
                        print("Cancelled the dialog.")
                    end
                }
            }
        })
    end
})
Tabs.Players:AddButton({
    Title = "Restore Lighting",
    Description = "",
    Callback = function()
        pcall(function()
            Lighting.Ambient = origsettings.abt
            Lighting.OutdoorAmbient = origsettings.oabt
            Lighting.Brightness = origsettings.brt
            Lighting.ClockTime = origsettings.time
            Lighting.FogEnd = origsettings.fe
            Lighting.FogStart = origsettings.fs
            Lighting.GlobalShadows = origsettings.gs
        end)
    end
})

-- Toggle Teleport Tabs~
local Select2Teloport = Tabs.Teleport:AddDropdown("Island", {
    Title = "Select to Teloport",
    Values = Island2Unlock,
    Multi = false,
    Default = 1,
})
Select2Teloport:SetValue(nil)
Select2Teloport:OnChanged(function(v)
    getgenv().SelectedIsland = v
end)
Tabs.Teleport:AddButton({
    Title = "Click To Teleport",
    Description = "Teleporting to Selected Island",
    Callback = function()
        for i,v in pairs(Workspace.islandUnlockParts:GetChildren()) do
            if v.Name == getgenv().SelectedIsland and v:IsA("MeshPart") then
                getRoot(lp.Character).CFrame = v.CFrame
            end
        end
    end
})
local UnlockIsland = Tabs.Teleport:AddToggle("lao", {Title = "Unlock All island", Description = "Method FireTouchinterest", Default = false})
UnlockIsland:OnChanged(function(v)
    getgenv().Stacia_UnlockIsland = v
    while getgenv().Stacia_UnlockIsland do ktask.wait()
        pcall(function()
            local random2 = math.random(1 * 30)
            local globalEnv = Island2Unlock[random2]
            for i,v in pairs(Workspace.islandUnlockParts[globalEnv]:GetDescendants()) do
                if v.Name == "TouchInterest" and v.Parent then
                    firetouchinterest(lp.Character.Head, v.Parent, 0)
                    firetouchinterest(lp.Character.Head, v.Parent, 1)
                end
            end
        end)
    end
end)

local OpenEggs = Tabs.Teleport:AddSection("Auto open Egg & Teleport to Crystal")
local Teleport2egg = Tabs.Teleport:AddDropdown("Eggss", {
    Title = "Select To Teleport",
    Values = CrystalFolder,
    Multi = false,
    Default = 1,
})
Teleport2egg:SetValue(nil)
Teleport2egg:OnChanged(function(v)
    getgenv().tp2egg = v
end)
Tabs.Teleport:AddButton({
    Title = "Teleport to Crystals / Eggs",
    Description = "Auto Updates",
    Callback = function()
        lp.Character:FindFirstChildOfClass("HumanoidRootPart").CFrame = workspace.mapCrystalsFolder[getgenv().tp2egg]:GetModelCFrame()
    end
})

local Eggs = Tabs.Teleport:AddDropdown("Eggs", {
    Title = "Select Egg",
    Values = CrystalFolder,
    Multi = false,
    Default = 1,
})
Eggs:SetValue(nil)
Eggs:OnChanged(function(v)
    getgenv().SeEfJLCVjeRCxKh = v
end)
local openegged = Tabs.Teleport:AddToggle("MyToggle", {Title = "Open Eggs / Crystal", Description = "Please Select First / Auto Updates",Default = false })
openegged:OnChanged(function(v)
    getgenv().CKJFCYPJIBE = v
    while getgenv().CKJFCYPJIBE do ktask.wait()
        pcall(function()
            local args = {
                [1] = "openCrystal",
                [2] = getgenv().SeEfJLCVjeRCxKh
            }
            game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("openCrystalRemote"):InvokeServer(unpack(args))
        end)
    end
end)

-- spawn funciton main writing by Stacia <3
spawn(function()
    while ktask.wait() do
        pcall(function()
            if getgenv().Stacia_swing or getgenv().Stacia_swing == true or getgenv().TweenToBoss then
                ktask.spawn(function()
                    equiptool()
                    lp:WaitForChild("ninjaEvent"):FireServer("swingKatana")
                end)
            end
        end)
    end
end)
spawn(function()
    while ktask.wait() do
        if getgenv().Stacia_Selled then
            pcall(function()
                for i,v in pairs(game:GetService("Workspace").sellAreaCircles:GetChildren()[20].circleInner:GetDescendants()) do
                    if v.Name == "TouchInterest" and v.Parent then
                        firetouchinterest(game.Players.LocalPlayer.Character.Head, v.Parent, 0)
                        firetouchinterest(game.Players.LocalPlayer.Character.Head, v.Parent, 1)
                    else
                        Fluent:Notify({
                            Title = "Notification",
                            Content = "Incompatible Exploit",
                            SubContent = "Your exploit does not support this fucntion (missing firetouchinterest)",
                            Duration = 8
                        })
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while ktask.wait() do
        if getgenv().Stacia_MaxSell then
            pcall(function()
                if game.Players.LocalPlayer.PlayerGui.gameGui.maxNinjitsuMenu.Visible == true then
                    for i,v in pairs(game:GetService("Workspace").sellAreaCircles:GetChildren()[20].circleInner:GetDescendants()) do
                        if v.Name == "TouchInterest" and v.Parent then
                            firetouchinterest(game.Players.LocalPlayer.Character.Head, v.Parent, 0)
                            firetouchinterest(game.Players.LocalPlayer.Character.Head, v.Parent, 1)
                        else
                            Fluent:Notify({
                                Title = "Notification",
                                Content = "Incompatible Exploit",
                                SubContent = "Your exploit does not support this fucntion (missing firetouchinterest)", -- Optional
                                Duration = 8
                            })
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while ktask.wait() do
        if getgenv().Platform or getgenv().Platform == true then
            pcall(function()
                if Workspace:FindFirstChild(Pl1tform) then
                    Workspace[Pl1tform].CFrame = CFrame.new(lp.Character.HumanoidRootPart.CFrame.X,lp.Character.HumanoidRootPart.CFrame.Y - 3.8 ,lp.Character.HumanoidRootPart.CFrame.Z)
                end
            end)
        end 
    end
end)
spawn(function()
    while ktask.wait() do
        if getgenv().nofog then
            pcall(function()
                Lighting.FogEnd = 100000
                for i,v in pairs(Lighting:GetDescendants()) do
                    if v:IsA("Atmosphere") then
                        v:Destroy()
                    end
                end
            end)
        end 
    end
end)
spawn(function()
    while ktask.wait() do
        if getgenv().FullBrightness then
            pcall(function()
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
                Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            end)
        end 
    end
end)
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
		local TeleportType = math.random(1,5)
		ktask.wait(0.7)
	end
end)

-- RunService
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
RunService.RenderStepped:Connect(function()
    if getgenv().InstantBoss then
        pcall(function()
            if getgenv().AttachBoss == "AncientMagmaBoss" then
                for _,v in pairs(Workspace.bossFolder:GetChildren()) do
                    if v.Name == "AncientMagmaBoss" and v:FindFirstChild("HumanoidRootPart") then
                        v.Humanoid:ChangeState(15)
                        v.Humanoid.Health = die
                        sethidden(lp, "SimulationRadius", math.huge)
                    end
                end
            elseif getgenv().AttachBoss == "EternalBoss" then
                for _,v in pairs(Workspace.bossFolder:GetChildren()) do
                    if v.Name == "EternalBoss" and v:FindFirstChild("HumanoidRootPart") then
                        v.Humanoid:ChangeState(15)
                        v.Humanoid.Health = die
                        v.Humanoid.Health = 0
                        sethidden(lp, "SimulationRadius", math.huge)
                    end
                end
            elseif getgenv().AttachBoss == "RobotBoss" then
                for _,v in pairs(Workspace.bossFolder:GetChildren()) do
                    if v.Name == "RobotBoss" and v:FindFirstChild("HumanoidRootPart") then
                        v.Humanoid:ChangeState(15)
                        v.Humanoid.Health = die
                        v.Humanoid.Health = 0
                        sethidden(lp, "SimulationRadius", math.huge)
                    end
                end
            end
        end)
    end
end)
RunService.RenderStepped:Connect(function()
    if getgenv().InstantAllBoss then
        pcall(function()
            for _,v in pairs(Workspace.bossFolder:GetChildren()) do
                if v.Name == "AncientMagmaBoss" or v.Name == "EternalBoss" or v.Name == "RobotBoss" and v:FindFirstChild("HumanoidRootPart") then
                    v.Humanoid:ChangeState(15)
                    v.Humanoid.Health = die
                    v.Humanoid.Health = 0
                    sethidden(lp, "SimulationRadius", math.huge)
                end
            end
        end)
    end
end)
spawn(function()
    RunService.Heartbeat:Connect(function()
        pcall(function()
            for i,v in pairs(Players.LocalPlayer.PlayerGui:FindFirstChild("statEffectsGui"):GetChildren()) do
                if v.Name == "statEffectsScript" then
                    v.Enabled = false
                    ktask.wait()
                end
            end
        end)
    end)
end)

xpcall(function()
    print("\nConfig<>\n","AntiAFK",shared.Configs.Global_Setting.AntiAFK,"NoclipCamera",shared.Configs.Global_Setting.NoclipCamera,"RandomName",shared.Configs.Global_Setting.RandomName)
end, function()
    print("No Config")
end)

-- for config~
spawn(function()
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
