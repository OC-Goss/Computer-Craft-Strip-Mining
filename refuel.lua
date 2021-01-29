args = {...}
if not args[1] then
    turtle.refuel()
else
    turtle.refuel(args[1])
end

print("Current Fuel Level: "..turtle.getFuelLevel())

