bullets = {}

function addbullet(x, y, velx, vely, evil, sprite)
    local bullet = {}

    bullet.type = "bullet"
    bullet.sprite = sprite
    bullet.evil = evil
    bullet.x = x
    bullet.y = y
    bullet.velx = velx
    bullet.vely = vely

    function bullet.draw(bullet)
        spr(bullet.sprite, bullet.x, bullet.y)
    end

    function bullet.collide(object)
        if bullet.x+4 >= object.x and bullet.x+4 <= object.x+object.w and bullet.y+4 >= object.y and bullet.y+4 <= object.y+object.h and object.inv < 0 then
            object:shot()
            del(obj, bullet)
        end
    end

    function bullet.update(bullet)
        --applying velocity
        bullet.x += bullet.velx
        bullet.y += bullet.vely

        --collision detection
        if bullet.evil then
            foreach(players, bullet.collide)
        elseif bullet.evil == false then
            foreach(enemies, bullet.collide)
        end

        --delete bullet if off screen
        if bullet.y > 128 or bullet.y < -8 or bullet.x > 128 or bullet.x < -8 then
            del(obj, bullet)
        end
    end

    add(obj, bullet)
    add(bullet, #obj)
end