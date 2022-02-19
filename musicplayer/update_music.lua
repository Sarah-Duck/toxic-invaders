--similar math elements grouped to lower tokens
flashtime = (ceil(t()*10%2) == 1) --for flashing elements (ship, score)
circletimex = sin(t())*3 -- for elements that move in a circle (respawn timer)
circletimey = cos(t())*3

gt += scrollspeed + 1/600

updateobjs() --update all objects

if btnp(0) then tracknumber-=1 playmusic() elseif btnp(1) then tracknumber+=1 playmusic() end
if btnp(4) and btnp(5) then music(-1,3000,3) end

if tracknumber < 0 then tracknumber = 0 elseif tracknumber > 3 then tracknumber = 3 end