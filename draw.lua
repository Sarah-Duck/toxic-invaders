--pallete replacement
pal({1,2,131,141,5,6,7,136,9,137,139,12,133,3,140,130}, 1) --don't ask me why, but this table of colors starts at 1, and 0 is the final color
-- pal(15,140,1)
-- pal(14,3,1)
-- pal(13,133,1)
-- pal(11,139,1)
-- pal(10,137,1)
-- pal(8,136,1)
-- pal(4,141,1)
-- pal(3,131,1)
-- pal(0,130,1)



drawbg()
drawobjs()
camera() --so the score doesn't shake
if gamerunning then
    if gameover then --gameover timer, it does a cute spinny! 😵
        printdropshadow(ceil(respawntimer),63+circletimex,55+circletimey,6,5)
        runningscore(currentscore,true)
    else
        runningscore(currentscore,false)
        scoretextcolors = {{12,15},{2,9}} --shows incorrect shadow colour for 2P counter (shows as 0)
        for i = 1, #players, 1 do
            player = players[i]
            if player.health < 1 then
                printdropshadow(ceil(player.inv),player.x+circletimex,player.y+circletimey,scoretextcolors[i][i],scoretextcolors[i][i+1])
            end
        end
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
if currentwave == 20 then
    finalscorescreen(0,0)

    --outro acid transition
    if isoutro then
        acidcounter-=ft
        sfx(0,3,3)
        acidtransition()
    end
    if acidcounter < -0.2 then run() end --resets cart
end