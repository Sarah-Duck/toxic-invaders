function addbullet(x, y, velx, vely, evil, sprite)
    local bullet = {
        sprite = sprite or 2,
        evil = evil,
        x = x,
        y = y,
        velx = velx,
        vely = vely,
    }

    function bullet.draw(bullet)
        spr(bullet.sprite, bullet.x, bullet.y)
    end

    function bullet.collide(object)
        if bullet.x+4 >= object.x and bullet.x+4 <= object.x+object.w and bullet.y+4 >= object.y and bullet.y+4 <= object.y+object.h and object.inv < 0 then
            object:shot()
            del(obj, bullet)
        end
    end

    function bullet.accurate_collide(object)
        if bullet.x+4 >= object.x-2 and bullet.x+4 <= object.x+2+object.w and bullet.y+4 >= object.y-2 and bullet.y+4 <= object.y+object.h+2 then
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
            foreach(enemies, bullet.accurate_collide)
        end

        --delete bullet if off screen
        if bullet.y > 128 or bullet.y < -8 or bullet.x > 128 or bullet.x < -8 then
            del(obj, bullet)
        end
    end

    add(obj, bullet)
end

function addlaser(x, y, r)
    local laser = {
        --lasers!!!!!!!!!!!!!!!
        x = x,
        y = y,
        r = r,
        timer = 0,
        playingsound = false
    }

    function laser.draw(laser)
        if laser.timer > 1.5 then
            local radius = (min(laser.timer*laser.r*0.7,laser.r)+sin(t()*6))-mid(0, laser.timer-3, laser.r)*laser.r
            for i = -10, laser.x, 1 do
                line(i, laser.y+radius*sin(t()*3+i/(10+laser.timer^3.5))*1.6, i, laser.y-radius*sin(t()*3+i/(10+laser.timer^3.5))*1.6, 14)
                pset(i, laser.y+(cos(t()*1.5+i/50)+sin(i/4.32535+t())*2)*radius/1.8, 14)
            end
            circfill(laser.x, laser.y, radius, 14)
            rectfill(-10, laser.y-radius, laser.x, laser.y+radius, 14)
            circfill(laser.x, laser.y, radius*0.7, 11)
            rectfill(-10, laser.y-radius*0.7, laser.x, laser.y+radius*0.7, 11)
            circfill(laser.x, laser.y, radius*0.3, 7)
            rectfill(-10, laser.y-radius*0.3, laser.x, laser.y+radius*0.3, 7)
        else
            circfill(laser.x, laser.y, laser.timer*4+sin(t()*8), 11)
            circfill(laser.x, laser.y, laser.timer*2+sin(t()*8), 7)
            for i = mid(-5, laser.x-laser.timer*laser.x,laser.x), laser.x, 1 do
                pset(i, laser.y+sin(i/(3/(laser.timer/2))-t())*laser.timer*laser.r/2, 11)
                pset(i, laser.y+cos(t()*laser.timer+i/30)*laser.timer*3+sin(i/8.32535+t()), 14)
            end
        end
    end

    function laser.collide(object)
        if object.x < laser.x and laser.y+laser.r*2 > object.y+object.h and laser.y-laser.r*2 < object.y and object.inv < 0 then
            object:shot()
        end
    end

    function laser.update(laser)
        laser.timer += 1/60
        --collision detection after the warm up
        if laser.timer > 1.5 and laser.timer < 3.6 then
            if not laser.playingsound then
                sfx(24,3)
                laser.playingsound = true
            end
            shake = rnd(8)/laser.timer
            foreach(players, laser.collide)
            foreach(enemies, laser.collide)
        end

        --delete laser once its done
        if laser.timer > 4 then
            del(obj, laser)
            sfx(24, -2)
            sfx(25, 3)
            for i = 1, 16, 1 do
                addcircle(rnd(laser.x), laser.y-laser.r/2+rnd(laser.r), -0.5, -0.5, rnd(3), rnd(2), rnd({11,14,7}), 0)
            end
        end
    end

    add(obj, laser)
    sfx(23)
end