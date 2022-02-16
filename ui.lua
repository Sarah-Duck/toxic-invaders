menuscroll = 0
menushipscroll = 0

function printdropshadow(text,x,y,colorMain,colorShadow)
    print(text,x,y+1,colorShadow)
    print(text,x,y,colorMain)
end

function invaderslogotext(x,y)
    --default values
    -- x = 12
    -- y = 20

    --font
    local text = "i n v a d e r s"
    print(text, x, y-1, 3)
    print(text, x+1, y, 3)
    print(text, x-1, y, 3)
    print(text, x-1, y+1, 3)
    print(text, x+1, y+1, 3)
    print(text, x-1, y-1, 3)
    print(text, x+1, y-1, 3)
    print(text, x+1, y+1, 3)
    print(text, x-1, y+2, 3)
    print(text, x+1, y+2, 3)
    print(text, x, y+2, 3)
    printdropshadow(text,x,y,14,3)
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
    sspr(16,24,16,8,x-3,y+2,32,16) --to shadow
    sspr(16,24,16,8,x-3,y,32,16) --to
    sspr(48,24,8,8,x+55,y+2,16,16) --ic shadow
    sspr(48,24,8,8,x+55,y,16,16) --ic
    --X
    sspr(32,24,8,8,x+26,y-9,16,16)
    sspr(32,24,8,8,x+42,y-9,16,16,true)
    sspr(40,24,8,8,x+26,y+7,16,16,true)
    sspr(40,24,8,8,x+42,y+7,16,16)
    --invaders
    invaderslogotext(x+12,y+20)
end

function mainmenutext(x,y)
    -- default values
    -- x = 24
    -- y = 62
    x -= 1
    if not gamerunning then
        spr(17,x+2,y+4+sin(t()*0.7)*2,1,1) --blue ship
        spr(33,x+2,y+16+sin(t()*0.7)*2,1,1) --orange ship
    end
    printdropshadow("(\142) - lone wolf",x+15,y+7,6,5)
    printdropshadow("(\151) - companion",x+15,y+18,6,5)
end

function titlehighscores(highscore0,highscore1,x,y)
    -- default values
    -- 52
    -- 110
    
    printdropshadow(highscore0,x-20,y,12,15) --1P high score
    printdropshadow("-",x+10,y,6,5)
    printdropshadow(highscore1,x+20,y,9,2) --2P high score
end

function currentscore(currentscore0,currentscore1,isflashing0,isflashing1) 
    if #players != 1 then
        if isflashing1 then
            if ceil(t()*10%2) == 1 then
                printdropshadow(currentscore1,2,121,9,4) --2P current score
            end
        else
            printdropshadow(currentscore1,2,121,9,4) --2P current score
        end
    end

    if isflashing0 then
        if ceil(t()*10%2) == 1 then
            printdropshadow(currentscore0,2,2,12,15) --1P current score
        end
    else
        printdropshadow(currentscore0,2,2,12,15) --1P current score
    end
end

function credits(x,y)
    -- default vaues
    -- x = 10
    -- y = 100

    palt(2,true)
    palt(0,false)
    spr(48,x-4,y+6+sin(t())*2,1,1,(t()%2<1)) --duck
    spr(49,x+104,y+6+cos(t())*2,1,1,(t()%2<1)) --bot
    palt(2,false)
    palt(0,true)
    printdropshadow("1029chris",x+10,y+5,9,2)
    printdropshadow("ribboncable",x+56,y+5,12,15)
    printdropshadow("code tunes",x+8,y+12,11,3)
    printdropshadow("art sounds",x+58,y+12,11,3)

    -- print("made in vancouver - 2022", x+6,y+22,0)
    -- print("made in vancouver - 2022", x+6,y+21,4)
end

--sfx for the intro transition
sfx(0,3)

--this creates menu items that allow players to turn off screenshake, or always fire the ships gun.
doshake = true
menuitem(1, "(\129) screenshake", function() doshake = not doshake end)
menuitem(2, "(\144) autofire", function() alwaysfire = not alwaysfire end)