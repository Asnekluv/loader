httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request;
p = (game.gameId)
gui = game.StarterGui

local function Executor()
    local response = httprequest({
        Url = "https://httpbin.org/user-agent",
        Method = "GET",
    })
    assert(type(response) == "table", "Response must be a table")
    assert(response.StatusCode == 200, "Did not return a 200 status code")
    local data = game:GetService("HttpService"):JSONDecode(response.Body)
    assert(type(data) == "table" and type(data["user-agent"]) == "string", "Did not return a table with a user-agent key")
    return(data["user-agent"])
end

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

if not game:IsLoaded() then game.Loaded:Wait() end

print("Start Loader At" .. Time())

local Loader = httprequest({
    Url = "https://raw.githubusercontent.com/Asuneki/LuauMain/main/".. p ..".lua",
    Method = "Get"
})

if Loader.StatusCode == 200 then
    gui:SetCore("SendNotification", {
        Icon = "rbxassetid://17118793438";
        Title = "User", 
        Text = " Has Executed by" .. Executor()
    }
)
	print(p)
loadstring(Loader.Body)()
elseif Loader.StatusCode == 404 then
    game.Players.LocalPlayer:Kick("Script is Discontinued")
else
    game:shutdown()
end

print("End Line At" .. Time())
