respawntimer -= ft
--similar math elements grouped to lower tokens
flashtime = t()\0.1%2 == 1 --for flashing elements (ship, score)
circletimex = sin(t())*3 -- for elements that move in a circle (respawn timer)
circletimey = cos(t())*3
screenshakex = sin(shake+t())*shake
screenshakey = sin(shake+gt/2.1)*shake

--stuff for scrolling background and respawning
if gameover then
    scrollspeed = lerp(scrollspeed, -1/22, 0.01) -- scroll backwards
    currentscore = 0 --depleats score
    if respawntimer < 0 then
        gameover = false
        foreach(players, function(obj) obj:respawn() end)
        setwave(mid(checkpoint,currentwave-1,#wave)) --goes back one wave
        sfx(22, -2) --stops respawn rewind beat
    end
elseif gamerunning then
    updatewaves() -- update the wave function
    local targetspeed = ft
    if currentsong >= 8 then
        targetspeed /= 2 --half scroll speed when boss
    elseif currentwave == 20 then
        targetspeed /= 8
    end
    scrollspeed = lerp(scrollspeed, targetspeed, 0.03)
end
gt += scrollspeed + 1/600

--stuff for starting or ending the game
if currentwave == 20 then --ending screen
    if btn(4) and btn(5) and not isoutro then --press both buttons to reset cart
        acidcounter = 2
        isoutro = true
        playsong(-1, 2000) --fades music
    end
elseif not gamerunning and t() > 1 then --main menu
    if btn(4) then
        addplayer1() --reduces tokens, found in objects.lua
        startgame()
    elseif btn(5) then
        coopmode = true
        addplayer1() --reduces tokens, found in objects.lua
        addplayer(18, 75, 32, 33, 34, 4)
        startgame()
    end
end

--updating objects
if gamerunning or t() < 1.95 then -- weird if because of freezing bubbles in the menu
    updateobjs() --update all objects
    currentscore = mid(0,currentscore,9999) --attempts to avoid hitting the OOM error or being negative
end

--screenshake math
shake = lerp(shake, 0, 0.11)
if shake < 1 or not doshake then
    shake = 0
end

--adds zeros to score to look cooler
function scorewithzeros(string,length)
    if #string == length then return string end
    return "0"..scorewithzeros(string, length-1)
end

-- screenshake accessibility setting
if doshake then screenshaketext = "(▒) screenshake" end --adds 9 tokens to visually show the toggle
menuitem(1,screenshaketext,
    function()
        doshake = not doshake
        screenshaketext = "(█) screenshake"
    end)