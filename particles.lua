function addcircle(x, y, velx, vely, r, time, color)
    local circle = {}
    circle.x = x
    circle.y = y
    circle.velx = velx
    circle.vely = vely
    circle.r = r
    circle.time = time
    circle.t = time
    circle.col = color

    function circle.draw(circle)
        circfill(circle.x, circle.y, circle.r*sin(circle.time/circle.t), circle.col)
    end

    function circle.update(circle)
        circle.x += circle.velx
        circle.y += circle.vely
        circle.time -= 1/60
        if circle.time < 0 then
            del(obj, circle)
        end
    end

    add(obj, circle)
end