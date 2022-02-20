obj = {}
gt = 0 -- game time
ft = 1/60 --frametime
scrollspeed = 0
menushipscroll = 0
acidcounter = 0
hideui = false
autoplay = false
autoplaytimer = 90
tracknumber = 0
currentsong = -1
fadeouttimer = 1
tracktitleposition = -200
newtracktitleposition = 0
-- cartdata("toxicinvaderssoundtrack_by1029chris")

function playsong(song, fade)
    fade = fade or 0
    if song ~= currentsong then
        music(song, fade)
        currentsong = song
    end
end

function fadeoutsong()
    fadeouttimer = 1
    playsong(-1,1000) --fades out currentsong
end

function selectmusic()
    if tracknumber == -1 then
        tracknumber = 0
    elseif tracknumber == 0 then
        playsong(-1,0)
    elseif tracknumber == 1 then
        playsong(0)
    elseif tracknumber == 2 then
        playsong(8)
    elseif tracknumber == 3 then
        playsong(17)
    elseif tracknumber == 4 then
        playsong(-1,0)
    end
end

function updatetracktitlepos()
    if tracknumber == 0 then
        newtracktitleposition = -16
    elseif tracknumber == 1 then
        newtracktitleposition = 145
    elseif tracknumber == 2 then
        newtracktitleposition = 313
    elseif tracknumber == 3 then
        newtracktitleposition = 493
    elseif tracknumber == 4 then
        newtracktitleposition = 685
    end
end

function updateobjs()
    foreach(obj, function(obj) obj:update() end)
end

function drawobjs()
    foreach(obj, function(obj) obj:draw() end)
end

function lerp(start, destination, amount)
    return start + amount * (destination - start);
end