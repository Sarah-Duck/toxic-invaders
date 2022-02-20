obj = {}
gt = 0 -- game time, but not actually, this is only used by the background for scrolling.
ft = 1/60 --frametime
scrollspeed = 0
respawntimer = 0
gameover = false
gamerunning = false
menuscroll = 0 --main screens
menushipscroll = 0
acidcounter = 0
isoutro = false --for outro transition
cartdata("toxicinvaders_bychrisandribbon")
highscore0 = dget(0) --scores (0 is solo - 1 is coop)
highscore1 = dget(1)
currentscore = 0 --used for both gamemodes, but passed into highscore at end of game
currentsong = -1


function startgame()
    setwave(currentwave)
    gamerunning = true
end

function updateobjs()
    foreach(players, function(obj) obj:update() end)
    foreach(enemies, function(obj) obj:update() end)
    foreach(obj, function(obj) obj:update() end)
    despawnallbullets = false
end

function drawobjs()
    foreach(obj, function(obj) obj:draw() end)
    foreach(enemies, function(obj) obj:draw() end)
    clip() --for the final boss
    foreach(players, function(obj) obj:draw() end)
end

function lerp(start, destination, amount)
    return start + amount * (destination - start);
end

function playsong(song, fade)
    fade = fade or 0
    if song ~= currentsong then
        music(song, fade, 3)
        currentsong = song
    end
end