url = "https://asuneki.netlify.app/assets/Lua/"
p = game.gameId
httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
function Time()
	local HOUR = math.floor((tick() % 86400) / 3600)
	local MINUTE = math.floor((tick() % 3600) / 60)
	local SECOND = math.floor(tick() % 60)
	local AP = HOUR > 11 and 'PM' or 'AM'
	HOUR = (HOUR % 12 == 0 and 12 or HOUR % 12)
	HOUR = HOUR < 10 and '0' .. HOUR or HOUR
	MINUTE = MINUTE < 10 and '0' .. MINUTE or MINUTE
	SECOND = SECOND < 10 and '0' .. SECOND or SECOND
	return HOUR .. ':' .. MINUTE .. ':' .. SECOND .. ' ' .. AP
end
local function Web()
    local response = httprequest({
        Url = "https://asuneki.netlify.app",
        Method = "GET",
    })
    assert(type(response) == "table", "Response must be a table")
    assert(response.StatusCode == 200, "Did not return a 200 status code")
    return(print(response.StatusCode))
end
Web()
getgenv().x = {
    [5650396773] = url .. "tipsy" .. ".lua" -- 🔴 Discontinued / no more update <3🔴 \\ a dusty trip https://www.roblox.com/games/16389395869/a-dusty-trip
}
local p = x[p]
if x[p] then
    print(p .. Time())
    loadstring(game:HttpGet(p))()
else
    repeat
        wait(1)
        gui = game.StarterGui
        gui:SetCore("SendNotification", {
        Icon = "rbxassetid://17118793438";
        Title = "broken link", 
        Text = "or forgot to upload file to server🔪🔪 ..."
        }
    )
    until game.Players.LocalPlayer.character:FindFirstChild("Humanoid").Health == 0
end
