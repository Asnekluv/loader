--[[
getgenv().Configs = {
    dustytrip = {
        ["Lite"] = false, -- ! true / false
        ["Asuneki"] = false, -- ! true / false << pc or emu ver.
        ["keybindDisply"] = false -- ! true / false << pc or emu ver.
    }
}
--]]

httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request;
p = (game.gameId)
gui = game.StarterGui;
local function L_1_func()
	local L_3_ = httprequest({
		Url = "https://httpbin.org/user-agent",
		Method = "GET"
	})
	assert(type(L_3_) == "table", "Response must be a table")
	assert(L_3_.StatusCode == 200, "Did not return a 200 status code")
	local L_4_ = game:GetService("HttpService"):JSONDecode(L_3_.Body)
	assert(type(L_4_) == "table" and type(L_4_["user-agent"]) == "string", "Did not return a table with a user-agent key")
	return (L_4_["user-agent"])
end;
function Time()
	local L_5_ = math.floor((tick() % 86400) / 3600)
	local L_6_ = math.floor((tick() % 3600) / 60)
	local L_7_ = math.floor(tick() % 60)
	local L_8_ = L_5_ > 11 and 'PM' or 'AM'
	L_5_ = (L_5_ % 12 == 0 and 12 or L_5_ % 12)
	L_5_ = L_5_ < 10 and '0' .. L_5_ or L_5_;
	L_6_ = L_6_ < 10 and '0' .. L_6_ or L_6_;
	L_7_ = L_7_ < 10 and '0' .. L_7_ or L_7_;
	return L_5_ .. ':' .. L_6_ .. ':' .. L_7_ .. ' ' .. L_8_
end;
if not game:IsLoaded() then
	game.Loaded:Wait()
end;
print(Time())
local L_2_ = httprequest({
	Url = "https://raw.githubusercontent.com/Asuneki/LuauMain/main/" .. p .. ".lua",
	Method = "Get"
})
if L_2_.StatusCode == 200 then
	gui:SetCore("SendNotification", {
		Icon = "rbxassetid://17118793438";
		Title = "User",
		Text = "Has Executed by" .. L_1_func()
	})
	loadstring(L_2_.Body)()
elseif L_2_.StatusCode == 404 then
	game.Players.LocalPlayer:Kick("Script is Discontinued")
else
	game:shutdown()
end;
print(Time())
