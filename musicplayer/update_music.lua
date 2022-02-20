--similar math elements grouped to lower tokens
flashtime = (ceil(t()*10%2) == 1) --for flashing elements (ship, score)
circletimex = sin(t())*3 -- for elements that move in a circle (respawn timer)
circletimey = cos(t())*3

gt += scrollspeed + 1/600
fadeouttimer -= ft

updateobjs() --update all objects

if tracknumber < 0 then
    tracknumber = 4
elseif tracknumber > 4 then
    tracknumber = 0
end

if btnp(0) then
    tracknumber-=1
    updatetracktitlepos()
    fadeoutsong()
elseif btnp(1) then
    tracknumber+=1
    updatetracktitlepos()
    fadeoutsong()
end

if fadeouttimer <= 0 then
    fadeouttimer = 0
    selectmusic()
    updatetracktitlepos()
end

if autoplay then
    autoplaytimer -= ft
    if autoplaytimer <= 0 then
        autoplaytimer = 90
        tracknumber+=1
        fadeoutsong()
    end
    autoplaymenutext = "(♪) autoplay"
else 
    autoplaymenutext = "(◆) autoplay"
end
menuitem(2, autoplaymenutext, function() autoplay = not autoplay end)


if btnp(4) and btnp(5) then music(-1,3000) end

tracktitleposition = lerp(tracktitleposition,newtracktitleposition,.03)