--scrolling and respawn stuff
respawntimer -= 1/60
if gameover then
    scrollspeed = mid(-1/60,scrollspeed-1/6000,1/60)
    if respawntimer < 0 then
        gameover = false
        foreach(players, function(obj) obj:respawn() end)
        setwave(mid(1,currentwave-2,#wave))
    end
elseif gamerunning then
    updatewaves()
    updateobjs()
    scrollspeed = mid(0,scrollspeed+1/2000,1/60)
end
gt += scrollspeed

if not gamerunning then
    if btn(4) then
        addplayer(18, 60, 16, 18)
        startgame()
    elseif btn(5) then
        addplayer(18, 45, 16, 18)
        addplayer(18, 75, 32, 34)
        startgame()
    end
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