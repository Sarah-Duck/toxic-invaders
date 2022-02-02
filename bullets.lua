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

    function bullet.collide(object, bullet)
        if bullet.x >= object.x and bullet.x <= object.x+object.w and bullet.y >= object.y and bullet.y <= object.y+object.h then
            cls(4)
        end
    end

    function bullet.update(bullet)
        --applying velocity
        bullet.x += bullet.velx
        bullet.y += bullet.vely

        --collision detection
        if bullet.evil then
            foreach(players, bullet.collide(bullet))
        end

        --delete bullet if off screen
        if bullet.y > 128 or bullet.y < -8 or bullet.x > 128 or bullet.x < -8 then
            del(obj, bullet)
        end
    end

    add(obj, bullet)
    add(bullet, #obj)
end