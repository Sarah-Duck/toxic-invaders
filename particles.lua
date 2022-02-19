shake = 0
function addcircle(x, y, velx, vely, r, time, color, grav)
    local circle = {
        t = time,
    }
    grav = grav or 0

    function circle.draw()
        circfill(x, y, r*sin(time/circle.t), color)
    end

    function circle.update()
        x += velx
        vely -= grav
        y += vely
        time -= ft
        if time < 0 then
            del(obj, circle)
        end
    end

    add(obj, circle, 1)
end

function explosion(x,y, w, h)
    w = w or 8
    h = h or 8
    for i = 1, w/2, 1 do
        addcircle(x+rnd(w), y+rnd(h), -0.5, 0, rnd(8), rnd(1.5)+1, 5)
    end
    for i = 1, w/2, 1 do
        addcircle(x+rnd(w), y+rnd(h), -0.4, 0, rnd(8), rnd(1)+0.5, 9)
    end
end

function damagesmoke(object)
    --smokes when damaged!
    if rnd() < 0.2 then
        addcircle(object.x+rnd(object.w*0.5), object.y+rnd(object.w*0.5), -0.5, -0.2, rnd(7), rnd(1.2)+1, rnd({5,5,9}))
    end
end