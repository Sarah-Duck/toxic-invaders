--background pallete replacement
pal(15,132,1)
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
--print(#obj)
function drawlogo(x,y)
    --default values
    x = x or 24
    y = y or 18
    --this is a horrible way to draw the logo, but I'm doing it anyways.
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