bgcircles = {}

function scrollingcircles(y, speed, spacing, radius, color)
    for i = 1, (128*(radius*4))/spacing, 1 do
        circfill(-time()*speed+(spacing*(i-1)), y, radius, color)
    end
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
    
    --static planet
    spr(202,80,62,6,3)
    spr(249,72,86,7,1)

    
    --clouds
    scrollingcircles(-9, 24, 22, 22, 4)
    scrollingcircles(-14, 40, 25, 20, 13)

    camera((sin(shake+t())*shake)/2, (sin(shake+t()/2.1)*shake)/2)
    --landscape
    scrollingcircles(110, 72, 25, 20, 8)
    camera(sin(shake+t())*shake, sin(shake+t()/2.1)*shake)
    scrollingcircles(135, 100, 30, 32, 15)
end