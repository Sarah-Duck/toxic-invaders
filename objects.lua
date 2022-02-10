obj = {}
gt = 0 -- game time
scrollspeed = 0
respawntimer = 0
gameover = false
gamerunning = false

function startgame()
    wave[currentwave].start()
    music(0, 0, 3)
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