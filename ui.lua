menuscroll = 0
menushipscroll = 0

function invaderslogotext(x,y)
    --default values
    -- x = 12
    -- y = 20

    --font
    local text = "i n v a d e r s"
    print(text, x, y+1, 3)
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
    print(text, x, y, 14)
    clip(x, y, 60, 3)
    print(text, x, y, 11)
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
    sspr(40,24,8,8,x+26,y+7,16,16, true)
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
    print("(\142) - lone wolf", x+15,y+7,5)
    print("(\142) - lone wolf", x+15,y+6,6)
    print("(\151) - companion", x+15,y+18,5)
    print("(\151) - companion", x+15,y+17,6)
end

function titlehighscores(x,y)
    -- default values
    -- 52
    -- 110
    
    --1P high score
    print("000000", x-20,y+1,15)
    print("000000", x-20,y,12)
    print("-", x+10,y+1,5)
    print("-", x+10,y,6)
    --2P high score
    print("000000", x+20,y+1,2)
    print("000000", x+20,y,9)
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
    print("1029chris", x+10,y+6,2)
    print("1029chris", x+10,y+5,9)
    print("ribboncable", x+56,y+6,15)
    print("ribboncable", x+56,y+5,12)
    print("code tunes", x+8,y+13,3)
    print("code tunes", x+8,y+12,11)
    print("sprites sfx", x+56,y+13,3)
    print("sprites sfx", x+56,y+12,11)

    -- print("made in vancouver - 2022", x+6,y+22,0)
    -- print("made in vancouver - 2022", x+6,y+21,4)
end

--sfx for the intro transition
sfx(13,3)

-- drawlogo(24,26)
-- mainmenutext(24,62)
-- credits(10,100)

--this creates menu items that allow players to turn off screenshake, or always fire the ships gun.
doshake = true
menuitem(1, "(\129) screenshake", function() doshake = not doshake end)
menuitem(2, "(\144) autofire", function() alwaysfire = not alwaysfire end)