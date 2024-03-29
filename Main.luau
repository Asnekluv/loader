local p = game.gameId
local a = request or http_request or http or syn and syn.request
local w = a({
    Url = "https://raw.githubusercontent.com/SyliyUwU/Game/main/"..p..".lua",
    method = "GET"
})
if w.StatusCode == 200 then
	warn("Print\n",a)
    loadstring(w.Body)()
else
    game:shutdown()
end
