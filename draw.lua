--pallete replacement
pal(15,140,1)
pal(14,3,1)
pal(13,133,1)
pal(11,139,1)
pal(10,137,1)
pal(8,136,1)
pal(4,141,1)
pal(3,131,1)
pal(0,130,1)



drawbg()
drawobjs()

if gamerunning then
    if gameover then --gameover timer, it does a cute spinny!
        print(ceil(respawntimer), 62+sin(t())*3,61+cos(t())*3, 4)
        print(ceil(respawntimer), 62+sin(t())*3,60+cos(t())*3, 7)
    elseif players[1].health <=0 then
        print(ceil(players[1].inv), players[1].x+sin(t())*3, players[1].y+cos(t())*3+1, 4)
        print(ceil(players[1].inv), players[1].x+sin(t())*3, players[1].y+cos(t())*3, 12)
    elseif #players > 1 and players[2].health <=0 then
        print(ceil(players[2].inv), players[2].x+sin(t())*3, players[2].y+cos(t())*3+1, 4)
        print(ceil(players[2].inv), players[2].x+sin(t())*3, players[2].y+cos(t())*3, 9)
    end
end
if not gamerunning or gt < 1 then
    for i = 1, 3, 1 do
        spr(basicenemysprites[i%#basicenemysprites+1], (-t()*(i*20)+(sin(i/3+t()/100)*128)+1*8)%(128+1*8)-1*8-gt*180, i*36+sin(t()*i/3)*i*2-20,1,1)
    end
    if t() < 0.68 then
        drawlogo(24-gt*120,sin(0.25+t()*0.75)*26)
    else
        drawlogo(24-gt*120,26)
    end
    mainmenutext(24-gt*150,62)
    credits(10-gt*140,100)
end

-- print(#obj)