function printdropshadow(text,x,y,colorMain,colorShadow)
    print(text,x,y+1,colorShadow)
    print(text,x,y,colorMain)
end

function invaderslogotext(x,y)
    --default values
    -- x = 12
    -- y = 20

    --font
    local text = "I N V A D E R S"
    for i = 1, 12, 1 do
        print(text, x+i%3-1, y+i%4-1, 3)
    end
    print(text,x,y,14)
    clip(x, y, 63, 3)
    print(text,x,y,11)
    clip()

end

function drawlogo(x,y)
    --default values
    -- x = 24
    -- y = 26

    --this is a horrible way to draw the logo, but I'm doing it anyways. x3
    -- muahahahahahahaha!!!!!!
    sspr(88,88,16,8,x-3,y+2,32,16) --to shadow
    sspr(88,88,16,8,x-3,y,32,16) --to
    sspr(120,88,8,8,x+55,y+2,16,16) --ic shadow
    sspr(120,88,8,8,x+55,y,16,16) --ic
    --X
    sspr(104,88,8,8,x+26,y-9,16,16)
    sspr(104,88,8,8,x+42,y-9,16,16,true)
    sspr(112,88,8,8,x+26,y+7,16,16,true)
    sspr(112,88,8,8,x+42,y+7,16,16)
    --invaders
    invaderslogotext(x+11,y+20)
end

function mainmenutext(x,y)
    -- default values
    -- x = 24
    -- y = 62
    x -= 1
    local sintime = sin(t()*0.7)*2

    if not gamerunning then
        spr(17,x+2,y+6+sintime,1,1) --blue ship
        spr(33,x+2,y+17+sintime,1,1) --orange ship
    end
    printdropshadow("(\142) - lone wolf",x+15,y+7,6,5)
    printdropshadow("(\151) - companion",x+15,y+18,6,5)
end

function titlehighscores(x,y)
    -- default values
    -- 52
    -- 110
    
    printdropshadow(scorewithzeros(tostring(highscore0),4),x-10,y,12,15) --1P high score
    printdropshadow("-",x+10,y,6,5)
    printdropshadow(scorewithzeros(tostring(highscore1),4),x+18,y,9,2) --2P high score
end

function playerscore()
    if #players > 1 then
        printdropshadow(scorewithzeros(tostring(currentscore),4),2,121,9,4) --2P current score
    else
        printdropshadow(scorewithzeros(tostring(currentscore),4),2,2,12,15) --1P current score
    end
end

--shown on edge of screen (blue for solo - orange for coop)
function runningscore(currentscore,isflashing)
    if isflashing or gt < 2 then
        if flashtime == 1 then
            playerscore()
        end
    else
        playerscore()
    end
end

function credits(x,y)
    -- default vaues
    -- x = 10
    -- y = 100

    palt(2,true)
    palt(0,false)
    spr(186,x-4,y+6+sin(t())*2,1,1,(t()%2<1)) --duck
    spr(184,x+104,y+6+cos(t())*2,1,1,(t()%2<1)) --bot
    palt()
    printdropshadow("1029chris",x+10,y+5,9,2)
    printdropshadow("ribboncable",x+56,y+5,12,15)
    printdropshadow("CODE TUNES",x+8,y+12,11,3)
    printdropshadow("ART SOUNDS",x+58,y+12,11,3)
end

--Ending screen
function finalscorescreen(x,y)
    local playercolour0 = 12
    local playercolour1 = 15

    printdropshadow("fINAL sCORE", x+41,y+22,6,5)
    if #players > 1 then
        playercolour0 = 9
        playercolour1 = 2
    end

    -- if #players > 1 and currentscore > highscore1 or #players == 1 and currentscore > highscore0 then
        if flashtime == 1 then
            printdropshadow("! new high score !", x+27,y+32,11,3)
            if babymode then
                printdropshadow("! BABYMODE !", x+40,y+70,9,2)
            end
        -- end
    end
    
    poke(0x5f58, 0x0 | 0x9 | 0x4) --makes score BIG
    printdropshadow(scorewithzeros(tostring(currentscore),4),x+48+circletimex,y+50+circletimey,playercolour0,playercolour1) --2P high score
    poke(0x5f58, 0)

    printdropshadow("THANK YOU FOR PLAYING", x+19,y+80,11,3)
    printdropshadow("PRESS ❎ ⁙ 🅾️ TO RETRY", x+18,y+88,11,3)

    printdropshadow("MADE WITH ♥ IN VANCOUVER", x+14,y+110,9,2)
    printdropshadow("◆ 2022 ◆", x+42,y+118,11,3)
end

--intro/ending acid effect
function acidtransition()
    if acidcounter < 3 then
        for i = 1, 128, 1 do
            line(i-1,128,i-1,sin((i+0.22-acidcounter*20)/24.357)*2+acidcounter*80-5,11) --cool wavy transition effect!!!!
            line(i-1,128,i-1,sin((i+acidcounter*60)/44.357)*5+acidcounter*80,3)
        end
        addcircle(rnd(128), acidcounter*80+5, 0,rnd(1),rnd(12)+2,1.5,14)
    end
end

--sfx for the intro transition
sfx(0,3,3)

--this creates menu items that allow players to turn off screenshake, or always fire the ships gun.
doshake = true
menuitem(1, "(\129) screenshake", function() doshake = not doshake end)
menuitem(2, "(\144) autofire", function() alwaysfire = not alwaysfire end)
menuitem(3, "(\137) BABYMODE", function() babymode = true end)