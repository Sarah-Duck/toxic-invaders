obj = {}
gt = 0 -- game time
ft = 1/60 --frametime
scrollspeed = 0
respawntimer = 0
gameover = false
gamerunning = false

function startgame()
    music(0, 0, 3)
    wave[currentwave].start()
    gamerunning = true
end

function updateobjs()
    foreach(players, function(obj) obj:update() end)
    foreach(enemies, function(obj) obj:update() end)
    foreach(obj, function(obj) obj:update() end)
end

function drawobjs()
    foreach(obj, function(obj) obj:draw() end)
    foreach(enemies, function(obj) obj:draw() end)
    foreach(players, function(obj) obj:draw() end)
end