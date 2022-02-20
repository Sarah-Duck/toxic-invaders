--pallete replacement
pal({1,2,131,141,5,6,7,136,9,137,139,12,133,3,140,130}, 1) --don't ask me why, but this table of colors starts at 1, and 0 is the final color



drawbg()
menushipscroll += ft

for i = 1, 3, 1 do
    spr(14+i*16, (-menushipscroll*(i*20)+(sin(i/3)*128)+8)%(128+8)-1*8, i*36+sin(menushipscroll*i/3)*i*2-20,1,1)
end

if t() < 1 then
    drawlogo(24,19.5+sin(0.25+t()*0.5)*6.5)
else
    drawlogo(24,26)
end
credits(40,116)

if not hideui then
    --main screen items
    mainmenutext(15,74)

    --intro acid transtition
    acidcounter+=ft
    acidtransition()
    drawobjs() --only used for acid trans here
end

-- print(autoplay,0,0,7)