local client = Class()

function client:ConnectTo(adr, port)
    local c, e = socket.connect(adr or "localhost", port)
    
    assert(c ~= nil, (e or ""):upper())
    
    self.Socket = c
end

function client:SetTimeout(t)
   self:GetSocket():settimeout(t) 
end

function client:GetPeerName()
    return self:GetSocket():getpeername()
end

function client:GetSockName()
    return self:GetSocket():getsockname()
end

function client:GetStats()
    return self:GetSocket():getstats()
end

function client:Send(msg)
   self:GetSocket():send(msg .. "\n") 
end

function client:Close()
    if self.Socket then
       self.Socket:close()
    end
end

function client:GetSocket()
    return self.Socket
end

function client:Init(adr, port)
    self:ConnectTo(adr, port)
    
    return self
end

function client:Update()
   local rt, st, sta = socket.select({self:GetSocket()}, nil, 1)
   
   if #rt > 0 then
        local rec, rec_st = self:GetSocket():receive()
        
        if rec_st ~= "closed" then
            if rec then
                print(rec)
            end
        end
    end
end

return client