-- bgcircles = {}

function scrollingcircles(y, speed, spacing, radius, color)
    for i = 1, 256, spacing do
        circfill((i-(gt*speed))%256-radius*2, y, radius, color)
    end
end

function scrollingcirclelines(y, speed, spacing, radius, color)
    for i = 1, 256, spacing do
        circ((i-(gt*speed))%256-radius*2, y, radius, color)
    end
end

function scrollingsprite(sprite,x,y,w,h,speed,flip)
    flip = flip or false
    spr(sprite, (-gt*speed+x+w*8)%(128+w*8)-w*8, y, w, h, flip)
end


--ringed planet
function bgplanetmegasprite(x,y)
    --default values
    --x = 160-gt
    --y = 50

    palt(0,false)
        spr(194,x+10,y+0,4,2)
        spr(199,x+50,y+0,2,2)
        spr(214,x+42,y+8,1,1)
        spr(201,x+10,y+16,6,2)
        spr(207,x+58,y+16,1,1)
        spr(234,x+2,y+32,1,1)
        spr(236,x+18,y+32,3,1)
        spr(250,x+2,y+40,4,1)
        spr(223,x+42,y+32,1,1)
    palt(0,true)
end

function drawbg()
    cls(0)
    camera((sin(shake+t())*shake)/3, (sin(shake+gt/2.1)*shake)/3)

    --stars
    for i = 1, 64, 1 do
        pset((((-gt*0.1)+i*4.3824)*(i/32))%128, sin(i*0.536382)*64+64, 4) --funny random star algorithm!!
    end

    --galaxies
    spr(254, 100, 40, 1, 1)
    spr(239, 20, 30, 1, 1)
    spr(254, 42, 72, 1, 1, true, true)

    bgplanetmegasprite(150-(gt)%300,50)
    
    --clouds
    scrollingcircles(-9, 24, 22, 22, 2)
    --small clouds
    scrollingsprite(198, 20, 10, 1, 1, 28)
    scrollingsprite(235, 60, 10, 1, 1, 28)
    scrollingsprite(198, 100, 10, 1, 1, 28)
    scrollingsprite(235, 120, 10, 1, 1, 28)
    scrollingsprite(235, 130, 12, 1, 1, 29)
    scrollingsprite(198, 145, 15, 1, 1, 30)
    scrollingsprite(235, 160, 15, 1, 1, 30)
    scrollingsprite(198, 170, 15, 1, 1, 30)
    --large clouds
    scrollingsprite(248, 40, 5, 2, 1, 35)
    scrollingsprite(248, 80, 5, 2, 1, 35)
    scrollingsprite(232, 120, 7, 2, 1, 36)
    scrollingsprite(232, 160, 7, 2, 1, 36)
    scrollingsprite(248, 180, 9, 2, 1, 38)
    scrollingsprite(232, 240, 9, 2, 1, 38)
    scrollingsprite(248, 260, 9, 2, 1, 38)
    --fg clouds
    scrollingcirclelines(-11, 40, 25, 20, 2)
    scrollingcircles(-12, 40, 25, 20, 4)


    camera((sin(shake+t())*shake)/2, (sin(shake+gt/2.1)*shake)/2)
    --landscape
    scrollingcirclelines(125, 72, 25, 20, 8)
    scrollingcircles(126, 72, 25, 20, 2)
    --landscape lines
    line(0, 112, 128, 112, 8)
    line(0, 114, 128, 114, 8)
    line(0, 116, 128, 116, 8)
    line(0, 117, 128, 117, 8)
    rectfill(0,119,128,128,8)
    for i = 1, 32, 1 do
        line(((-gt+i*2.5)*80)%128, 111, ((-gt+i*2.5)*80)%128*1.2-12.8, 125, 2)
    end
    --pine trees
    scrollingsprite(231,10,78+16,1,2,72,true)
    scrollingsprite(231,30,78+16,1,2,72)
    scrollingsprite(231,20,77+16,1,2,72,true)
    scrollingsprite(231,50,79+16,1,2,72,true)
    scrollingsprite(231,62,77+16,1,2,72,true)
    scrollingsprite(231,70,78+16,1,2,72)
    scrollingsprite(231,80,79+16,1,2,72)
    scrollingsprite(231,95,78+16,1,2,72)
    scrollingsprite(231,100,77+16,1,2,72)
    scrollingsprite(231,120,79+16,1,2,72,true)
    --small buildings
    scrollingsprite(226,15,82+16,2,2,80)
    scrollingsprite(226,65,81+16,2,2,80)
    scrollingsprite(226,95,80+16,2,2,80)
    scrollingsprite(226,115,81+16,2,2,80)
    --totem poles
    scrollingsprite(230,25,83+16,1,2,84)
    scrollingsprite(230,65,84+16,1,2,84,true)
    scrollingsprite(230,85,85+16,1,2,84)
    --dead trees
    scrollingsprite(228,30,88+16,2,2,84)
    scrollingsprite(228,75,89+16,2,2,84,true)
    scrollingsprite(228,100,88+16,2,2,84)
    scrollingsprite(228,120,89+16,2,2,84,true)
    --large buildings (front)
    scrollingsprite(192,52,94,2,4,90)
    scrollingsprite(192,22,91,2,4,90)
    scrollingsprite(192,102,90,2,4,90)
    scrollingsprite(192,137,92,2,4,90)

    camera(sin(shake+t())*shake, sin(shake+gt/2.1)*shake)

    scrollingcirclelines(150, 100, 30, 32, 8)
    scrollingcircles(151, 100, 30, 32, 2)
end