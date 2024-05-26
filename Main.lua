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

local gamelist = {
    [5650396773] = "https://asuneki.netlify.app/assets/Lua/tipsy.lua",
    [5216419122] = "https://asuneki.netlify.app/assets/Lua/gef.lua",
    [1335695570] = "https://asuneki.netlify.app/assets/Lua/Ninja%20Legends.lua" -- open source > Discontinue
}
-- 5216419122 walk speed not work
local checkgame = gamelist[game.gameId]
if gamelist[game.gameId] then
    print(checkgame)
    loadstring(game:HttpGet(checkgame))()
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
