local rotation = "left"
local rows = 1 --> 1
local rowLimit = 5 --> 5
local length = 33 --> 33

function checkFuel()
    local fuelLevel = turtle.getFuelLevel()

    if fuelLevel < 10 then
        for i = 1,16 do
            turtle.select(i)
            local item = turtle.getItemDetail()
            if item and item.name == "minecraft:coal" then
                if turtle.refuel(1) then
                    return true
                end
            end
        end
    end
end

function detect()
    local success, block = turtle.inspect()

    if success then
        print(block.name)
        return true, block
    end
    return false, block
end

function moveNext()
    if rotation == "left" then
        turtle.turnLeft()
        turtle.forward()
        turtle.dig()
        turtle.forward()
        turtle.turnLeft()

        rotation = "right"
    elseif rotation == "right" then
        turtle.turnRight()
        turtle.forward()
        turtle.dig()
        turtle.forward()
        turtle.turnRight()

        rotation = "left"
    end
end

function farm()
    while rows <= rowLimit do
        for i = 1, length do
            local success, data = detect()
            turtle.dig()
            turtle.forward()
        end
        rows = rows + 1
        moveNext()
    end
end

function finish()
    for i = 1, 35 do
        turtle.forward()
    end
    turtle.turnLeft()
    for i = 1, 10 do
        turtle.forward()
    end
    os.sleep(1)
    turtle.turnLeft()
    os.sleep(1)
    turtle.forward()
    os.sleep(3)
    for slot = 1, 16 do
        turtle.select(slot)
        local item = turtle.getItemDetail()

        if item and item.name == "minecraft:sugar_cane" then
            turtle.dropUp()
        end
    end
    main()
end

function main()
    checkFuel()
    farm()
    finish()
end

main()
