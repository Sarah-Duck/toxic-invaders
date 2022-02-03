bgcircles = {}
circletimer = 0


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
    cls(1)

    circletimer -= 1/60
    if circletimer < 0 then
        circletimer = .8
        addbgcircle(180,100,-1,32,3)
    end
    
    foreach(bgcircles, function(circle) circle:draw() end)

    -- rectfill(0,0,128,16,13)
    -- rectfill(0,64,128,128,13)
    -- rectfill(0,80,128,128,2)
end

