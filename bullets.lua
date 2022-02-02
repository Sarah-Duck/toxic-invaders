bullets = {}

function addbullet(x, y, velx, vely, evil)
    local bullet = {}

    bullet.type = "bullet"
    bullet.x = x
    bullet.y = y
    bullet.velx = velx
    bullet.vely = vely

    function bullet.draw(bullet)
        spr(6, bullet.x, bullet.y)
    end

    function bullet.update(bullet)
        bullet.x += bullet.velx
        bullet.y += bullet.vely
        if bullet.y > 128 or bullet.y < -8 or bullet.x > 128 or bullet.x < -8 then
            del(obj, bullet)
        end
    end

    add(obj, bullet)
    add(bullet, #obj)
end