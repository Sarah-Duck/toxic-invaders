bgcircles = {}

function scrollingcircles(y, speed, spacing, radius, color)
    for i = 1, 256, spacing do
        circfill((i-(t()*speed))%256-radius*2, y, radius, color)
    end
end

function scrollingcirclelines(y, speed, spacing, radius, color)
    for i = 1, 256, spacing do
        circ((i-(t()*speed))%256-radius*2, y, radius, color)
    end
end

function scrollingsprite(sprite,x,y,w,h,speed,flip)
    flip = flip or false
    spr(sprite, (-t()*speed+x+w*8)%(128+w*8)-w*8, y, w, h, flip)
end


function addbgcircle(x, y, velx, r, color, pos)
    local circle = {}
    circle.x = x
    circle.y = y
    circle.velx = velx
    circle.r = r
    circle.color = color

    function circle.draw(circle)
        circle.x += circle.velx

        if circle.x < 0 - circle.r * 2 then
            del(bgcircles, circle)
        end
        circfill(circle.x,circle.y,circle.r,circle.color)
    end
    add(bgcircles,circle, pos)
end

function drawbg()
    cls(0)
    camera((sin(shake+t())*shake)/3, (sin(shake+t()/2.1)*shake)/3)

    --stars
    for i = 1, 64, 1 do
        pset(((-t()+i*4.3824)*(i/32))%128, sin(i*0.536382)*64+64, 4)
    end

    --ringed planet
    palt(0,false)
        spr(194,160-t(),50,4,2)
        spr(199,200-t(),50,2,2)
        spr(214,192-t(),58,1,1)
        spr(201,160-t(),66,6,2)
        spr(207,208-t(),66,1,1)
        spr(235,152-t(),82,1,1)
        spr(237,168-t(),82,3,1)
        spr(251,152-t(),90,4,1)
        spr(255,192-t(),82,1,1)
    palt(0,true)
    
    --clouds
    -- scrollingcircles(-7, 24, 22, 22, 4)
    scrollingcircles(-9, 24, 22, 22, 2)
    --small clouds
    scrollingsprite(198, 20, 10, 1, 1, 28)
    scrollingsprite(236, 60, 10, 1, 1, 28)
    scrollingsprite(198, 100, 10, 1, 1, 28)
    scrollingsprite(236, 120, 10, 1, 1, 28)
    scrollingsprite(236, 130, 12, 1, 1, 29)
    scrollingsprite(198, 145, 15, 1, 1, 30)
    scrollingsprite(236, 160, 15, 1, 1, 30)
    scrollingsprite(198, 170, 15, 1, 1, 30)
    --large clouds
    scrollingsprite(249, 40, 5, 2, 1, 35)
    scrollingsprite(249, 80, 5, 2, 1, 35)
    scrollingsprite(233, 120, 7, 2, 1, 36)
    scrollingsprite(233, 160, 7, 2, 1, 36)
    scrollingsprite(249, 180, 9, 2, 1, 38)
    scrollingsprite(233, 240, 9, 2, 1, 38)
    scrollingsprite(249, 260, 9, 2, 1, 38)
    --fg clouds
    scrollingcircles(-11, 40, 25, 20, 2)
    scrollingcircles(-12, 40, 25, 20, 4)


    camera((sin(shake+t())*shake)/2, (sin(shake+t()/2.1)*shake)/2)
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
        line(((-t()+i*2.5)*80)%128, 111, ((-t()+i*2.5)*80)%128*1.2-12.8, 125, 2)
    end
    --pine trees
    scrollingsprite(231,20,77+16,2,2,72,true)
    scrollingsprite(231,70,78+16,2,2,72)
    scrollingsprite(231,80,80+16,2,2,72)
    scrollingsprite(231,95,78+16,2,2,72)
    scrollingsprite(231,100,79+16,2,2,72)
    scrollingsprite(231,120,80+16,2,2,72,true)
    --small buildings
    scrollingsprite(226,15,80+16,2,2,78)
    scrollingsprite(226,65,80+16,2,2,78)
    scrollingsprite(226,95,80+16,2,2,78)
    scrollingsprite(226,115,80+16,2,2,78)
    --totem poles
    scrollingsprite(230,25,83+16,1,2,82)
    scrollingsprite(230,65,84+16,1,2,82)
    scrollingsprite(230,85,85+16,1,2,82)
    --dead trees
    scrollingsprite(228,30,85+16,2,2,84)
    scrollingsprite(228,75,86+16,2,2,84,true)
    scrollingsprite(228,100,87+16,2,2,84)
    scrollingsprite(228,120,88+16,2,2,84,true)
    --large buildings (front)
    scrollingsprite(192,52,94,2,4,90)
    scrollingsprite(192,22,91,2,4,90)
    scrollingsprite(192,102,90,2,4,90)
    scrollingsprite(192,137,92,2,4,90)

    camera(sin(shake+t())*shake, sin(shake+t()/2.1)*shake)
    scrollingcirclelines(150, 100, 30, 32, 8)
    scrollingcircles(151, 100, 30, 32, 2)
end