-- strip mining program rewritten using my mining lib
local mining = require "mining"
local args = {...}
if not args[1] then
    args[1] = 10
end 

-- start first strip
for i=1,args[1]+1 do
    mining.refuel()
    mining.bridge("minecraft:cobblestone") -- run bridge routine    
    if i%5==0 then mining.deposit(i) end
    if i%8==0 then mining.torchBehind() end
    mining.forward()
    if i%25==0 then print("Mined "..i.." Blocks") end
end
-- turn around and mine over
turtle.turnRight()
for i=1,4 do mining.forward() mining.bridge("minecraft:cobblestone") end
turtle.turnRight()

-- head back
for i=1, args[1]+1 do
     mining.refuel()
    mining.bridge("minecraft:cobblestone") -- run bridge routine    
    if i%5==0 then mining.deposit(i) end
    if i%8==0 then mining.torchBehind() end
    mining.forward()
    if i%25==0 then print("Mined "..i.." Blocks") end
end

print("Strip Mining Complete")
