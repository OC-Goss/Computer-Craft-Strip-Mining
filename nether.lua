local args = {...}
if not args[1] then
    args[1] = 5
end

function torch()
    for i=1,16 do
        if turtle.getItemCount(i)>0 and turtle.getItemDetail(i).name == "minecraft:torch" then
            turtle.select(i)
            -- turn around to place torch behind self
            turtle.turnLeft()
            turtle.turnLeft()
            turtle.place()
            turtle.turnRight()
            turtle.turnRight()
            return true
        end
    end
    return false
end
function refuel()
    if turtle.getFuelLevel() < 200 then
        -- Going backwards to use newer materials first
        for i=16,1,-1 do
            select(i)
            if turtle.refuel(10) then return true end
        end
    end
    return false
end
function bridge()
    if not turtle.detectDown() then
       for i=1,16 do
           if turtle.getItemCount(i)>0 and turtle.getItemDetail(i).name == "minecraft:netherrack" then
               turtle.select(i)
               turtle.placeDown()
               return true
           end
       end
   end
   return false
end

for i=1,args[1]+1 do
    if refuel() then print("Turtle Refueled") end
    bridge() -- run bridge routine    
    turtle.digUp()
    if i%8==0 then torch() end
    while not turtle.forward() do
        turtle.dig()
        turtle.attack()
    end
    if i%25==0 then print("Mined "..i.." Blocks") end
end
print("Strip Mining Complete")
