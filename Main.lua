print("This Game Id is : "..game.gameId)

-- variables
local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

-- fucntion
local function Web()
    local response = httprequest({
        Url = "https://asuneki.netlify.app",
        Method = "GET",
    })
    assert(type(response) == "table", "Response must be a table")
    assert(response.StatusCode == 200, "Did not return a 200 status code")
    return(print("Server is on"))
end

repeat wait() until game:IsLoaded()

Web()
local a = httprequest({
    Url = "https://asuneki.netlify.app/assets/Lua/"..game.gameId..".lua",
    Method = "GET"
})
if a.StatusCode == 200 then
    loadstring(a.Body)()
else
    game.Players.LocalPlayer:Kick("\n Not Have This Game")
end
