-- This program requires you have some type of chunk loader in slot 16 and some item storage that is movable in slot 15

-- BLocks to blacklist
table = {}
table["projectred-exploration:ore"] = true
table["nuclearcraft:ore"] = true
table["projectred-core:resource_item"] = true
table["galacticraftcore:basic_block_core"] = true
table["thermalfoundation:ore"] = true
table["ebwizardry:magic_crystal"] = true
table["tp:wub_gem"] = true
table["ic2:resource"] = true
table["galacticraftcore:basic_item"] = true
table["tp:ender_dust"] = true
table["extrautils2:ingredients"] = true
table["chisel:basalt2"] = true
table["bigreactors:oreyellorite"] = true

-- Actual code

function placeLoader()
    while turtle.digUp() do
        turtle.digUp()
    end
    turtle.select(16)
    turtle.placeUp()
    turtle.select(1)
end

function checkRight()
    turtle.turnRight()
    turtle.dig()
    if not turtle.dig() then
        if not turtle.inspect() then
            turtle.forward()
            blocksTraveled = blocksTraveled + 1
            turtle.digUp()
            turtle.digDown()
            turtle.turnRight()
            for i = 1, 3 do
                turtle.dig()
                turtle.turnLeft()
            end
            turtle.forward()
            blocksTraveled = blocksTraveled + 1
        else
            for i = 1, 2 do
                turtle.turnLeft()
            end
        end
    else
        for i = 1, 2 do
            turtle.turnLeft()
        end
    end
    checkLeft()
end

function checkLeft()
    turtle.dig()
    if not turtle.dig() then
        if not turtle.inspect() then
            turtle.forward()
            blocksTraveled = blocksTraveled + 1
            turtle.digUp()
            turtle.digDown()
            turtle.turnLeft()
            for i = 1, 3 do
                turtle.dig()
                turtle.turnRight()
            end
            turtle.forward()
            blocksTraveled = blocksTraveled + 1
            turtle.turnLeft()
        else
            turtle.turnRight()
        end
    else
        turtle.turnRight()
    end
end

function retrieveLoader()
    turtle.turnLeft()
    turtle.turnLeft()
    for i = 1, 16 do
        turtle.forward()
        blocksTraveled = blocksTraveled + 1
    end
    local succes, data = turtle.inspectUp()
    if data["name"] == "chickenchunks:chunk_loader" then
        turtle.select(16)
        turtle.digUp()
        turtle.select(1)
        turtle.turnRight()
        turtle.turnRight()
        for i = 1, 16 do
            turtle.forward()
            blocksTraveled = blocksTraveled + 1
    end
end

function unloadInventory()
    while turtle.dig() do
        turtle.dig()
    end
    turtle.select(15)
    turtle.place()
    for i = 1, 14 do
        turtle.select(i)
        if turtle.getItemDetail() then
            if table[turtle.getItemDetail()["name"]] then
                turtle.dropDown()
            else
                if turtle.getItemDetail()["name"] == "minecraft:coal" then
                    if turtle.getFuelLevel() < 10000 then
                        turtle.refuel()
                    else
                        turtle.drop()
                    end
                else
                    turtle.drop()
                end
            end
        end
    end
    turtle.select(15)
    turtle.dig()
    turtle.select(1)
end

function digForward()
    for i = 1, 16 do
        while turtle.dig() do
            turtle.dig()
        end
        turtle.forward()
        blocksTraveled = blocksTraveled + 1
        turtle.digUp()
        turtle.digDown()
        checkRight()
    end
end

function printDashboard()
    term.clear()
    term.setCursorPos(1, 1)
    print("                      __  ")
    print("           .,-;-;-,. /'_\\ ")
    print("         _/_/_/_|_\\_\\) /  ")
    print("        '-<_><_><_><_>=/\\ ")
    print("          `/_/====/_/-'\\_\\")
    print('           ""     ""    ""')
    print("Don't mind me, just doing turtle stuff.")
    local fuel = turtle.getFuelLevel()
    print("I also have enough energy to travel " .. fuel .. " blocks.")
    print("During my adventure I have traveled " .. blocksTraveled .. " blocks")
end

function waitForSignal()
    turtle.select(1)
    term.clear()
    term.setCursorPos(1, 1)
    print("                      __  ")
    print("           .,-;-;-,. /'_\\ ")
    print("         _/_/_/_|_\\_\\) /  ")
    print("        '-<_><_><_><_>=/\\ ")
    print("          `/_/====/_/-'\\_\\")
    print('           ""     ""    ""')
    print("Good day, please press enter when I am ready to go.")
    print("Place any food(fuel) in slot 1.")
    local fuel = turtle.getFuelLevel()
    print("I currently have " .. fuel .. " energy in me.")
    read()
    turtle.refuel()
end

distance = 0
blocksTraveled = 0
term.setCursorBlink(false)
waitForSignal()
placeLoader()
turtleName = os.getComputerLabel()
wifi = peripheral.wrap("left")
wifi.open(3332)
while true do
    printDashboard()
    digForward()
    placeLoader()
    retrieveLoader()
    distance = distance + 1
    unloadInventory()
end
