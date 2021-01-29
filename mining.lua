local mining = {}
-- places a torch below the robot
mining.torchDown = function()
    for i=1,16 do
        if turtle.getItemCount(i)>0 and turtle.getItemDetail(i).name == "minecraft:torch" then
            turtle.select(i)
            turtle.placeDown()
            return true
        end
    end
    return false
end

-- places a torch behind the robot
mining.torchBehind = function()
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

-- builds a bridge below if necessary using block
mining.bridge = function()
    if not turtle.detectDown() then
       for i=1,16 do
           if turtle.getItemCount(i)>0 and (turtle.getItemDetail(i).name == "minecraft:cobblestone" or turtle.getItemDetail(i).name == "minecraft:netherrack") then
               turtle.select(i)
               turtle.placeDown()
               return true
           end
       end
   end
   return false
end

-- refuel if necessary
mining.refuel = function()
    if turtle.getFuelLevel() < 250 then
        -- Going backwards to use newer materials first
        for i=16,1,-1 do
            select(i)
            if turtle.refuel(10) then print("Turtle Refueled. Current Fuel Level: ".. turtle.getFuelLevel()) return true end
        end
    end
    return false
end

-- check if inventory is full
mining.isInvFull = function()
    local full = true
    for i=1,16 do
    -- if every slot has items, the var full will be true
        full = full and turtle.getItemCount(i)>0
    end
    return full
end

-- get barrel slot, if exists
mining.getBarrel = function()
    for i=1,16 do
       if turtle.getItemCount(i)>0 and string.find(turtle.getItemDetail(i).name, "barrel") then
           return i
        end         
    end
    return nil
end

-- deposit into a barrel if inventory is full
mining.deposit = function(dis)
    if mining.isInvFull() then
        local barrel = mining.getBarrel()
        if not barrel then print("No Barrels Found to use!") return false end
       turtle.select(barrel)
       turtle.turnRight()
       turtle.dig()
       turtle.place()
       -- place all items in the barrel
       for i=1,16 do
            turtle.select(i)
            local name = turtle.getItemDetail().name
            if not (name == "minecraft:torch" or string.find(name,"barrel")) then
                turtle.drop()
            end        
        end
        turtle.turnLeft()
        if dis then
            print("Items deposited at "..dis.." blocks.")
        end
    end
    return true
end

mining.forward = function()
    while not turtle.forward() do
        turtle.dig()
        turtle.attack()
    end
    turtle.digUp()
end

return mining
