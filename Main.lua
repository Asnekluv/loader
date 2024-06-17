-- variables
local First = tick()
local gameList = loadstring(game:HttpGet("https://asuneki.netlify.app/assets/lua/library.luau"))()

local loadertime = 0

repeat wait() until game:IsLoaded()

while true do
    if loadertime >= 1 then
        break
    end
    xpcall(function()
    loadertime = loadertime + 1
    for i,v in next, gameList do
        if i == game.GameId or i == game.PlaceId then
            loadstring(game:HttpGet(v))()
        end
    end
end, function(err)
    print("Error loading script:", err)
    return nil
    end)
end

print("Took ", tick() - First, " To Load <3")
