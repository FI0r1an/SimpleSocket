local cmd = Class()

cmd.Command = {}

function cmd.New(name, func)
    cmd.Command[name] = func
end

function cmd.Do(msg)
    assert(msg:sub(1, 1) == "/", "Got a bad command: " .. msg)
    
    local ele = {}
    msg:sub(2, -1):gsub("[^ $]+", function (w)
        table.insert(ele, w)
    end)
    local name = table.remove(ele, 1)
    
    local c = cmd.Command[name]
    
    assert(c ~= nil, "\"" .. name .. "\" Doesnt exist")
    
    return c(ele)
end

return cmd