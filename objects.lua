obj = {}
gt = 0 -- game time
ft = 1/60 --frametime
scrollspeed = 0
respawntimer = 0
gameover = false
gamerunning = false
menuscroll = 0 --main screens
menushipscroll = 0
acidcounter = 0
scorescreen = false
isoutro = false --for outro transition
highscore0 = 0420 --scores (0 is solo - 1 is coop)
highscore1 = 0690
currentscore = 0 --used for both gamemodes, but passed into highscore at end of game
babymode = false --makes game a lot easier


function startgame()
    music(0, 0, 3)
    wave[currentwave].start()
    gamerunning = true
    print(gt,10,10)
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