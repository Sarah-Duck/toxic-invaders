--pallete replacement
pal(15,140,1)
pal(14,3,1) --5 tokens
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
    if gameover then --gameover timer, it does a cute spinny! 😵
        printdropshadow(ceil(respawntimer),63+sin(t())*3,55+cos(t())*3,6,5)
    elseif players[1].health <=0 then
        printdropshadow(ceil(players[1].inv),players[1].x+sin(t())*3,players[1].y+cos(t())*3,12,15)
    elseif #players > 1 and players[2].health <=0 then
        printdropshadow(ceil(players[2].inv),players[2].x+sin(t())*3,players[2].y+cos(t())*3,9,2)
    end
end
if not gamerunning or menuscroll < 1 then

    menuscroll += scrollspeed

    if not gamerunning then menushipscroll += 1/60 end

    for i = 1, 3, 1 do
        spr(14+i*16, (-menushipscroll*(i*20)+(sin(i/3)*128)+8)%(128+8)-1*8-menuscroll*240, i*36+sin(menushipscroll*i/3)*i*2-20-menuscroll*50,1,1)
    end
    
    if t() < 1 then
        drawlogo(24-menuscroll*120,19.5+sin(0.25+t()*0.5)*6.5)
    else
        drawlogo(24-menuscroll*120,26)
    end

    --main screen items
    mainmenutext(24-menuscroll*150,53)
    titlehighscores(52-menuscroll*110,82)
    credits(10-menuscroll*140,108)

    --intro acid effect
    if t() < 2 then
        for i = 1, 128, 1 do
            line(i-1,128,i-1,sin((i+0.22-t()*20)/24.357)*2+t()*80-10,11) --cool wavy transition effect!!!!
            line(i-1,128,i-1,sin((i+t()*60)/44.357)*5+t()*80-5,3)
        end
        addcircle(rnd(128), t()*80, 0,rnd(1),rnd(12)+2,1.5,14,0)
    end
end