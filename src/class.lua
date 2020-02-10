local function Class(base, init)
  local c = {}
    
  local function copy(t1, t2)
    for k, v in pairs(t2) do
      if type(v) == "table" then
        t1[k] = {}
        copy(t1[k], v)
      else
        t1[k] = v
      end
    end
  end
  
  if init and type(init) == "table" then
    c = init
  elseif init and type(init) == "function" then
    init(c)
  end
  
  copy(c, base or {})
  local mt = {
    __call = Class
  }
  c = setmetatable(c, mt)
  --c.__index = c
  
  return c
end

return Class