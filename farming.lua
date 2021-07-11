function waitForSignal()
    turtle.select(2)
    term.clear()
    term.setCursorPos(1, 1)
    print("                      __  ")
    print("           .,-;-;-,. /'_\\ ")
    print("         _/_/_/_|_\\_\\) /  ")
    print("        '-<_><_><_><_>=/\\ ")
    print("          `/_/====/_/-'\\_\\")
    print('           ""     ""    ""')
    print("Good day, please press enter when I am ready to go.")
    print("Place any food(fuel) in slot 2.")
    local fuel = turtle.getFuelLevel()
    print("I currently have " .. fuel .. " energy in me.")
    start = read()
    if start == "reset" then
        checkFuel()
        checkFuel()
        turtle.turnLeft()
        turtle.turnLeft()
        for i = 1, 15 do
            turtle.forward()
        end
        turtle.turnRight()
        for i = 1, 15 do
            turtle.forward()
        end
        turtle.turnRight()
    end
    turtle.refuel()
    turtle.select(1)
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
    print("During my farming I have traveled " .. blocksTraveled .. " blocks")
end
function printSleep(time)
    term.clear()
    term.setCursorPos(1, 1)
    print("                      __     z    z")
    print("           .,-;-;-,. /'_\\ z   z")
    print("         _/_/_/_|_\\_\\) /  ")
    print("        '-<_><_><_><_>=/\\ ")
    print("          `/_/====/_/-'\\_\\")
    print('           ""     ""    ""')
    print("Don't mind me, just taking a snooze.")
    print("Sleeping for another " .. time .. " minutes")
end

function findPotatoInInventory()
    for i = 1, 15 do
        turtle.select(i)
        if turtle.getItemDetail() then
            if turtle.getItemDetail()["name"] == "minecraft:potato" then
                turtle.transferTo(1)
            end
        end
    end
    turtle.select(1)
end

function farmingStrip()
    printDashboard()
    for i = 1, 15 do
        turtle.suckDown()
        if not turtle.inspectDown() then
            turtle.placeDown()
            if not turtle.inspectDown() then
                turtle.digDown()
                turtle.placeDown()
                if not turtle.inspectDown() then
                    findPotatoInInventory()
                    turtle.placeDown()
                    if not turtle.inspectDown() then
                        turtle.select(16)
                        turtle.placeUp()
                        turtle.select(1)
                    end
                end
            end
        else
            local succes, data = turtle.inspectDown()
            if data["metadata"] == 7 then
                turtle.digDown()
                turtle.suckDown()
                turtle.placeDown()
            end
        end
        turtle.suckDown()
        if i < 15 then
            turtle.forward()
            blocksTraveled = blocksTraveled + 1
        end
    end
    findPotatoInInventory()

end

function emptyExtraPotatoes()
    if turtle.detectUp() then
        turtle.select(1)
        if turtle.getItemDetail()["name"] == "minecraft:poisonous_potato" then
            turtle.dropDown()
            findPotatoInInventory()
        end
        for i = 2, 15 do
            turtle.select(i)
            if turtle.getItemDetail() then
                if turtle.getItemDetail()["name"] == "minecraft:poisonous_potato" then
                    turtle.dropDown()
                end
            end
            turtle.drop()
        end
        turtle.select(1)
    end
end
function checkFuel()
    if turtle.getFuelLevel() < 900 then
        turtle.select(14)
        turtle.suckUp()
        turtle.refuel()
        turtle.select(1)
    end
end

function sleepTurtle()
    printSleep("10")
    os.sleep(60)
    printSleep("9")
    os.sleep(60)
    printSleep("8")
    os.sleep(60)
    printSleep("7")
    os.sleep(60)
    printSleep("6")
    os.sleep(60)
    printSleep("5")
    os.sleep(60)
    printSleep("4")
    os.sleep(60)
    printSleep("3")
    os.sleep(60)
    printSleep("2")
    os.sleep(60)
    printSleep("1")
    os.sleep(60)
end

blocksTraveled = 0
waitForSignal()
while true do
    findPotatoInInventory()
    for i = 1, 7 do
        farmingStrip()
        turtle.turnRight()
        turtle.forward()
        turtle.turnRight()
        farmingStrip()
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()
    end
    farmingStrip()
    emptyExtraPotatoes()
    checkFuel()
    checkFuel()
    sleepTurtle()
    turtle.turnLeft()
    turtle.turnLeft()
end
