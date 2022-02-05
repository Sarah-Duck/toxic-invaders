shake = 0
function addcircle(x, y, velx, vely, r, time, color, grav)
    local circle = {}
    circle.x = x
    circle.y = y
    circle.velx = velx
    circle.vely = vely
    circle.r = r
    circle.time = time
    circle.t = time
    circle.col = color
    circle.grav = grav

    function circle.draw(circle)
        circfill(circle.x, circle.y, circle.r*sin(circle.time/circle.t), circle.col)
    end

    function circle.update(circle)
        circle.x += circle.velx
        circle.vely -= circle.grav
        circle.y += circle.vely
        circle.time -= 1/60
        if circle.time < 0 then
            del(obj, circle)
        end
    end

    add(obj, circle)
end

function explosion(x,y)
    for i = 1, 4, 1 do
        addcircle(x+rnd(8), y+rnd(8), -0.5, 0, rnd(8), rnd(1.5)+1, 5, 0)
    end
    for i = 1, 4, 1 do
        addcircle(x+rnd(8), y+rnd(8), -0.4, 0, rnd(8), rnd(1)+0.5, 9, 0)
    end
end