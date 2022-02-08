bgcircles = {}

function scrollingcircles(y, speed, spacing, radius, color)
    for i = 1, (128*(radius*4))/spacing, 1 do
        circfill(-time()*speed+(spacing*(i-1)), y, radius, color)
    end
end

function scrollingsprite(sprite,x,y,w,h,speed)
    spr(sprite, (-t()*speed+x+w*8)%(128+w*8)-w*8, y, w, h)
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
        pset(((-t()+i*2)*(i/32))%128, sin(i*0.536382)*64+64, 4)
    end

    --static planet
    spr(201,110-t()/4,62,7,3)
    spr(249,102-t()/4,86,7,1)
    
    --clouds
    scrollingcircles(-9, 24, 22, 22, 4)
    scrollingcircles(-14, 40, 25, 20, 13)
    scrollingsprite(194, 60, 16, 2, 1, 30)
    scrollingsprite(196, 100, 18, 2, 1, 34)
    scrollingsprite(198, 20, 20, 2, 1, 38)

    camera((sin(shake+t())*shake)/2, (sin(shake+t()/2.1)*shake)/2)
    --landscape
    scrollingcircles(110, 72, 25, 20, 8)

    --buildings
    scrollingsprite(231,100,65+16,2,2,78)
    scrollingsprite(226,65,67+16,2,2,80)
    scrollingsprite(192,55,69,2,4,81)
    scrollingsprite(230,85,70+16,1,2,82)
    scrollingsprite(228,40,72+16,2,2,84)
    scrollingsprite(192,20,75,2,4,86)
    scrollingsprite(192,120,80,2,4,88)

    camera(sin(shake+t())*shake, sin(shake+t()/2.1)*shake)
    scrollingcircles(135, 100, 30, 32, 15)
end