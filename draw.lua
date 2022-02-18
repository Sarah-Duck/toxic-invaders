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
        printdropshadow(ceil(respawntimer),63+circletimex,55+circletimey,6,5)
        runningscore(currentscore,true) --flashes score
    elseif players[1].health <=0 then
        printdropshadow(ceil(players[1].inv),players[1].x+circletimex,players[1].y+circletimey,12,15)
        runningscore(currentscore,true) --flashes score
    elseif #players > 1 and players[2].health <=0 then
        printdropshadow(ceil(players[2].inv),players[2].x+circletimex,players[2].y+circletimey,9,2)
        runningscore(currentscore,true) --flashes score
    else
        runningscore(currentscore,false) --current game score
    end
end
if not gamerunning or menuscroll < 1 then

    menuscroll += scrollspeed

    if not gamerunning then menushipscroll += ft end

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

    --intro acid transtition
    acidcounter+=ft
    acidtransition()
end

--final score screen and outro transition
if scorescreen then
    finalscorescreen(0,0)

    --outro acid transition
    if isoutro then
        acidcounter-=ft
        sfx(0,3,3)
        acidtransition()
    end
    if acidcounter < -0.2 then run() end --resets cart
end






-- --final boss portal parts
-- addportalthruster(70,6)
-- addportalthruster(70,107,true)
-- addfinalbossportal(80,10)
-- addportalthruster(95,6)
-- addportalthruster(95,107,true)