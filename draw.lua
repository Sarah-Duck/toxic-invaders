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
-- print(#obj)

function drawlogo(x,y)
    --default values
    -- x = 24
    -- y = 26

    --this is a horrible way to draw the logo, but I'm doing it anyways. x3
    -- muahahahahahahaha!!!!!!
    sspr(0,24,16,8,x-1,y+2,32,16) --to
    sspr(16,24,8,8,x+53,y+2,16,16) --ic
    sspr(0,24,16,8,x-1,y+1,32,16) --to
    sspr(16,24,8,8,x+53,y+1,16,16) --ic
    --X
    sspr(24,24,8,8,x+26,y-6,16,16)
    sspr(24,24,8,8,x+42,y-6,16,16,true)
    sspr(32,24,8,8,x+26,y+10,16,16, true)
    sspr(32,24,8,8,x+42,y+10,16,16)
    --X
    sspr(24,24,8,8,x+26,y-8,16,16)
    sspr(24,24,8,8,x+42,y-8,16,16,true)
    sspr(32,24,8,8,x+26,y+8,16,16, true)
    sspr(32,24,8,8,x+42,y+8,16,16)
    --font
    local text = "i n v a d e r s"
    print(text, x+10, y+21, 3)
    print(text, x+10, y+19, 3)
    print(text, x+11, y+20, 3)
    print(text, x+9, y+20, 3)
    print(text, x+9, y+21, 3)
    print(text, x+11, y+21, 3)
    print(text, x+9, y+19, 3)
    print(text, x+11, y+19, 3)
    print(text, x+11, y+21, 3)
    print(text, x+9, y+22, 3)
    print(text, x+11, y+22, 3)
    print(text, x+10, y+22, 3)
    print(text, x+10, y+20, 14)
    clip(x+10, y+20, 60, 3)
    print(text, x+10, y+20, 11)
    clip()
end

function mainmenutext(x,y)
    -- default values
    -- x = 24
    -- y = 62

    spr(17,x+2,y+4,1,1) --blue ship
    spr(33,x+2,y+16,1,1) --orange ship
    print("(A) - Lone Wolf", x+15,y+7,5)
    print("(A) - Lone Wolf", x+15,y+6,6)
    print("(B) - Companion", x+15,y+18,5)
    print("(B) - Companion", x+15,y+17,6)
end

function credits(x,y)
    -- default vaues
    -- x = 10
    -- y = 100

    palt(2,true)
    palt(0,false)
    spr(53,x-5,y+6,1,1) --duck
    pset(x+3,y+10,13) --extra dot for glasses
    spr(54,x+104,y+6,1,1) --bot
    palt(2,false)
    palt(0,true)
    print("1029chris   ribboncable", x+9,y+6,0)
    print("1029chris   ribboncable", x+9,y+5,9)
    print("code/tunes   art/sounds", x+8,y+13,0)
    print("code/tunes   art/sounds", x+8,y+12,9)
    print("made in vancouver - 2022", x+6,y+22,0)
    print("made in vancouver - 2022", x+6,y+21,4)
end


-- drawlogo(24,26)
-- mainmenutext(24,62)
-- credits(10,100)