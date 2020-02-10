local server = Class()
server.Client = {}

function server:ConnectTo(adr, port)
    local c, e = socket.bind(adr or "localhost", port)
    
    assert(c ~= nil, (e or ""):upper())
    
    self.Socket = c
end

function server:SetTimeout(t)
   self:GetSocket():settimeout(t) 
end

function server:GetSockName()
    return self:GetSocket():getsockname()
end

function server:GetStats()
    return self:GetSocket():getstats()
end

function server:Close()
    if self.Socket then
       self.Socket:close()
    end
end

function server:GetSocket()
    return self.Socket
end

function server:Init(adr, port)
    self:ConnectTo(adr, port)
    
    return self
end

function server:Update()
    while true do
        local c = self:GetSocket():accept()
       
        if c then
            self.Client[#self.Client+1] = c
            print"connected"
        end
        
        for k, v in pairs(self.Client) do
            local rt, st, sta = socket.select({v}, nil, 1)
            
            if #rt > 0 then
                local rec, rec_st = v:receive()
                
                if rec_st ~= "closed" then
                    if rec then
                       assert( v:send(( Command.Do(rec) or "" ).. "\n") )
                    end
                else
                    v:close()
                    table.remove(self.Client, k)
                end
            end
        end
        
        break
    end
end

return server