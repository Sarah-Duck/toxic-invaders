obj = {}
gt = 0 -- game time
ft = 1/60 --frametime
scrollspeed = 0
menushipscroll = 0
acidcounter = 0
tracknumber = 0
tracktext = ""
cartdata("toxicinvaderssoundtrack_by1029chris")


function playmusic()
    if tracknumber == 0 then
        tracktext = " mENU"
        music(-1,0,3)
       elseif tracknumber == 1 then
        tracktext = "fORWARD"
        music(2,0,3)
       elseif tracknumber == 2 then
        tracktext = " bOSSY"
        music(8, 0, 3)
       elseif tracknumber == 3 then
        tracktext = " pORTAL"
        music(-1,0,3)
       end
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

playmusic()