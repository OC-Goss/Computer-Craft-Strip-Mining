local args = {...}
if not args[1] then
    args[1] = 5
end

function torch()
    for i=1,16 do
        if turtle.getItemCount(i)>0 and turtle.getItemDetail(i).name == "minecraft:torch" then
            turtle.select(i)
            turtle.placeDown()
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
function isInvFull()
    local full = true
    for i=1,16 do
    -- if every slot has items, the var full will be true
        full = full and turtle.getItemCount(i)>0
    end
    return full
end
-- returns the index of a barrel
function getBarrel()
    for i=1,16 do
       if turtle.getItemCount(i)>0 and string.find(turtle.getItemDetail(i).name, "barrel") then
           return i
        end         
    end
    return nil
end

-- returns false on failure, true in all other cases
function deposit(dis)
    if isInvFull() then
        local barrel = getBarrel()
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
        print("Items deposited at "..dis.." blocks.")
    end
    return true
end
for i=1,args[1]+1 do
    if refuel() then print("Turtle Refueled") end
    turtle.digDown()
    turtle.digUp()
    if i%8==0 then torch() end
    if i%5==0 then deposit(i) end -- hopefully this check is often enough
    while not turtle.forward() do
        turtle.dig()
        turtle.attack()
    end
    if i%25==0 then print("Mined "..i.." Blocks") end
end
print("Strip Mining Complete")
