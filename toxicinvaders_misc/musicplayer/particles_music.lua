function addcircle(x, y, velx, vely, r, time, color, grav)
    local circle = {
        x = x,
        y = y,
        velx = velx,
        vely = vely,
        r = r,
        time = time,
        t = time,
        col = color,
        grav = grav or 0
    }

    function circle.draw()
        circfill(circle.x, circle.y, circle.r*sin(circle.time/circle.t), circle.col)
    end

    function circle.update()
        circle.x += circle.velx
        circle.vely -= circle.grav
        circle.y += circle.vely
        circle.time -= ft
        if circle.time < 0 then
            del(obj, circle)
        end
    end

    add(obj, circle, 1)
end