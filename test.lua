socket = require"socket"
Class = require"class"
-- dependent libs

Command = require"cmd"

Command.New("test", function()
        return "wow"
    end)

Client = require"client"
Server = require"server"

local s = Server():Init(nil, 3131)
local c = Client():Init(nil, 3131)
c:Send("/test")

s:Update()
c:Update()

c:Close()
s:Close()
