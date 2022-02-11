--scrolling and respawn stuff
respawntimer -= 1/60
if gameover then
    scrollspeed = mid(-1/10,scrollspeed-1/3000,1/60)
    if respawntimer < 0 then
        gameover = false
        foreach(players, function(obj) obj:respawn() end)
        setwave(mid(1,currentwave-2,#wave))
        sfx(29, -2)
        -- sfx(24)
    end
elseif gamerunning then
    updatewaves() -- update the wave function
    scrollspeed = mid(0,scrollspeed+1/2000,1/60)
end
gt += scrollspeed + 1/600

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

if gamerunning or t() < 1.95 then -- weird if because of freezing bubbles in the menu
    updateobjs() --update all objects
end

--screenshake math
shake = shake + 0.11 * (0 - shake);
if shake < 1 then
    shake = 0
end

if not doshake then
    shake = 0
end
--add another player if they fire
-- if btn(4, 1) and playercount == 0 then
--     addplayer(32, 34)
-- end