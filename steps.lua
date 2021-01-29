args = {...}
for i=1, args[1]+1 do
    turtle.digUp()
    turtle.digDown()
    turtle.down()
    if not turtle.detect() then
        -- switch to cobble
        for i=1,16 do
            if turtle.getItemCount(i)>0 and turtle.getItemDetail(i).name == "minecraft:cobblestone" then
                turtle.placeDown()
                break
            end
        end
    end
    while not turtle.forward() do turtle.dig() turtle.attack() end
end
