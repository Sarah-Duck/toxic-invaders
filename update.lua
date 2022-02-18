--scrolling and respawn stuff
respawntimer -= ft
--similar math elements grouped to lower tokens
flashtime = ceil(t()*10%2) --for flashing elements (ship, score)
circletimex = sin(t())*3 -- for elements that move in a circle (respawn timer)
circletimey = cos(t())*3
screenshakex = sin(shake+t())*shake
screenshakey = sin(shake+gt/2.1)*shake

if gameover then
    scrollspeed = mid(-1/10,scrollspeed-1/3000,ft)
    currentscore = 0 --depleats score
    if respawntimer < 0 then
        gameover = false
        foreach(players, function(obj) obj:respawn() end)
        setwave(mid(checkpoint,currentwave-1,#wave)) --goes back one wave
        sfx(29, -2)
    end
elseif gamerunning then
    updatewaves() -- update the wave function
    scrollspeed = mid(0,scrollspeed+1/2000,ft)
end
gt += scrollspeed + 1/600

if currentwave == 18 then --ending screen
    if btn(4) and btn(5) and not isoutro then --press both buttons to reset cart
        acidcounter = 2
        isoutro = true
        music(-1, 2000) --fades music
    end
else --main menu
    if not gamerunning and t() > 1 then
        if btn(4) then
            addplayer(18, 60, 16, 18)
            startgame()
        elseif btn(5) then
            addplayer(18, 45, 16, 18)
            addplayer(18, 75, 32, 34)
            startgame()
        end
    end
end

if gamerunning or t() < 1.95 then -- weird if because of freezing bubbles in the menu
    updateobjs() --update all objects
    if currentscore > 9999 then currentscore = 9999 elseif currentscore < 0 then currentscore = 0 end --attempts to avoid hitting the OOM error or being negative
end

--screenshake math
shake = shake + 0.11 * (0 - shake);
if shake < 1 or not doshake then
    shake = 0
end

--adds zeros to score to look cooler
function scorewithzeros(string,length)
    if #string == length then return string end
    return "0"..scorewithzeros(string, length-1)
end