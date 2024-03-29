--adds zeros to score to look cooler
function scorewithzeros(string,length)
    if #string == length then return string end
    return "0"..scorewithzeros(string, length-1)
end

function printdropshadow(text,x,y,colorMain,colorShadow)
    print(text,x,y+1,colorShadow)
    print(text,x,y,colorMain)
end

function invaderslogotext(x,y)
    --default values
    -- x = 12
    -- y = 20

    local invaderstext = "I N V A D E R S"
    for i = 1, 12, 1 do
        print(invaderstext, x+i%3-1, y+i%4-1, 3)
    end
    print(invaderstext,x,y,14)
    clip(x, y, 63, 3)
    print(invaderstext,x,y,11)
    clip()
end

function drawlogo(x,y)
    --default values
    -- x = 24
    -- y = 26

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

    spr(64,x+2,y+7+(sin(t()*0.7)*2),1,3) --ships
    printdropshadow("(\142) - lone wolf\n\n(\151) - companion",x+15,y+7,6,5)
end

function titlehighscores(x,y)
    -- default values
    -- 52
    -- 110
    
    printdropshadow(scorewithzeros(tostring(highscore0),4),x-10,y,12,15) --1P high score
    spr(112,x+8,y)
    printdropshadow(scorewithzeros(tostring(highscore1),4),x+18,y,9,2) --2P high score
end

function playerscore()
    if coopmode then
        printdropshadow(scorewithzerosstore,2,121,9,4) --2P current score
    else
        printdropshadow(scorewithzerosstore,2,2,12,15) --1P current score
    end
end

--shown on edge of screen (blue for solo - orange for coop)
function runningscore(currentscore,isflashing)
    if isflashing or gt < 2 then --blinks when starting a game
        if flashtime then
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
    local sintimecredits = circletimex*1.5
    local timemodcredits = t()%2<1

    palt(2,true)
    palt(0,false)
    spr(186,x-4,y+6+sintimecredits,1,1,timemodcredits) --duck
    spr(184,x+104,y+6+-sintimecredits,1,1,timemodcredits) --bot
    palt()
    printdropshadow("1029chris   ribboncable\nLUA TUNES   ART  SOUNDS",x+9,y+5,9,2)
end

--Ending screen
function finalscorescreen(x)
    if coopmode then
        playercolour0 = 9
        playercolour1 = 2
    end

    poke(0x5f58, 0x9 | 0x4) --makes score BIG
    printdropshadow("vICTORY!", x+33,18,6,5)
    printdropshadow(scorewithzerosstore,x+48+circletimex,50+circletimey,playercolour0,playercolour1) --2P high score
    poke(0x5f58)
    

    if (coopmode and currentscore > highscore1) or (not coopmode and currentscore > highscore0) then
        if flashtime then
            printdropshadow("! new high score !", x+27,34,11,3)
        end
    end

    printdropshadow("   THANKS FOR PLAYING\nPRESS (❎ ⁙ 🅾️) TO RETRY", x+15,80,11,3)

    printdropshadow("MADE WITH ♥ IN VANCOUVER\n       ◆ 2022 ◆", x+14,113,9,2)
end

--intro/ending acid effect
function acidtransition()
    if acidcounter < 3 then
        if btn(0) and btn(5) and btn(4) then dset(0) dset(1) run() end --clear score w/ button combo (LEFT - X - O)
        for i = 1, 128, 1 do
            line(i-1,128,i-1,sin((i+0.22-acidcounter*20)/24.357)*2+acidcounter*80-5,11) --cool wavy transition effect!!!!
            line(i-1,128,i-1,sin((i+acidcounter*60)/44.357)*5+acidcounter*80,3)
        end
        addcircle(rnd(128), acidcounter*80+5, 0,rnd(1),rnd(12)+2,1.5,14)
    end
end

--sfx for the intro transition
sfx(0,3,3)

-- autofire accessibility setting
menuitem(2, "(…) autofire", function() alwaysfire = not alwaysfire end)