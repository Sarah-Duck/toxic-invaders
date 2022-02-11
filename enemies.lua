enemies = {}

basicenemysprites = {14, 30, 46, 62} --these are all possible 8x8 basic enemy sprites

--Basic, small 8x8 customizable enemy. Very reusable!

function addbasicenemy(x, y, sprite, health, speed)
    local enemy = {}
    enemy.x = x
    enemy.y = y
    enemy.w = 8
    enemy.h = 8
    enemy.inv = -1
    enemy.sprite = sprite
    enemy.health = health
    enemy.shootcooldown = rnd(2)+1
    enemy.speed = speed

    function enemy.draw(enemy)
        local sprite = enemy.sprite
        if flr(sin(time()*speed)) ~= 0 then --if the ships heading up, change sprite
            sprite += 1
        end
        if enemy.inv < 0 or ceil(enemy.inv*10%2) == 1 then
            spr(sprite, enemy.x, enemy.y)
        end
    end

    function enemy.shot(enemy)
        --explode
        explosion(enemy.x, enemy.y)
        enemy.inv = 0.5
        --and reduce health
        enemy.health -= 1
        if enemy.health > 0 then
            sfx(16) 
        end
    end

    function enemy.collide(object) --f this enemy collides with something, do damage to both it and itself. also EXPLODE!!!
        if enemy.x+4 >= object.x and enemy.x+4 <= object.x+object.w and enemy.y+4 >= object.y and enemy.y+4 <= object.y+object.h and object.inv < 0 then
            object:shot()
            explosion(enemy.x+4, enemy.y+4)
            enemy.health -= 2
        end
    end

    function enemy.update()
        enemy.x -= speed
        enemy.y += sin(time()*speed)*speed
        enemy.shootcooldown -= 1/60
        enemy.inv -= 1/60
        foreach(players, enemy.collide)
        if enemy.shootcooldown < 0 then
            enemy.shootcooldown = 0.5 + rnd(1.5)
            if enemy.x < 129 then
                addbullet(enemy.x-3, enemy.y, -1, 0, true, 2) -- shoot if on screen
                sfx(15) -- play shoot sound if on screen
            end
        end
        if enemy.x < -8 then
            del(enemies, enemy) -- delete enemy if off screen
        end
        if enemy.health <= 0 then -- die!!!!!
            for i = 1, rnd(6)+6, 1 do
                addcircle(enemy.x+rnd(8), enemy.y+rnd(8), rnd(4)-2, -rnd(2)-1, 1, 2, rnd({3, 11, 9}), -0.1)
            end
            if rnd(100) > 95 then
                addpickup(enemy.x, enemy.y)
            end
            if shake < 3 then
                shake = 2.5
            end
            sfx(17)
            del(enemies, enemy)
        end
    end

    add(enemies, enemy)
end

--SHOOTER THAT SHOOTS BIG WALLS!!!!!!

function addwallshooter(x, shootup, health, speed, offset, bulletspeed)
    local enemy = {}
    enemy.x = x
    enemy.y = 119
    enemy.sprite = 60
    enemy.offset = offset or rnd()
    if shootup then
        enemy.y = 1
        enemy.sprite = 44
    end
    enemy.w = 8
    enemy.h = 8
    enemy.inv = -1
    enemy.health = health
    enemy.shootcooldown = 0
    enemy.speed = speed
    enemy.shoottoggle = true
    enemy.bulletspeed = bulletspeed or 1

    function enemy.draw(enemy)
        if enemy.inv < 0 or ceil(enemy.inv*10%2) == 1 then
            spr(enemy.sprite+t()*10%2, enemy.x, enemy.y)
        end
    end

    function enemy.shot(enemy)
        --explode
        explosion(enemy.x, enemy.y)
        --and reduce health
        enemy.health -= 1
        enemy.inv = 0.5
        sfx(16)
    end

    function enemy.collide(object)
        if enemy.x+4 >= object.x and enemy.x+4 <= object.x+object.w and enemy.y+4 >= object.y and enemy.y+4 <= object.y+object.h and object.inv < 0 then
            object:shot()
            explosion(enemy.x, enemy.y)
            enemy.health -= 2
        end
    end

    function enemy.update()
        enemy.x -= speed
        enemy.shootcooldown -= 1/60
        enemy.inv -= 1/60
        foreach(players, enemy.collide)
        if enemy.shootcooldown < 0 then
            if (t()+enemy.offset)%1>0.5/enemy.bulletspeed then
                if not enemy.shoottoggle then --implemented a toggle so that the sound effect for firing gets played only once.
                    enemy.shoottoggle = true
                    if enemy.x < 128 then
                        sfx(18)
                    end
                end
                enemy.shootcooldown = 0.08/enemy.bulletspeed
                local vely = -1
                if shootup then vely = 1 end
                addbullet(enemy.x, enemy.y, -enemy.speed, enemy.bulletspeed*vely, true, 2)
            else
                enemy.shoottoggle = false
            end
        end
        if enemy.x < -8 then
            del(enemies, enemy) --if off screen, get deleted nerd
        end
        if enemy.health <= 0 then
            for i = 1, rnd(6)+6, 1 do
                addcircle(enemy.x+rnd(8), enemy.y+rnd(8), rnd(4)-2, -rnd(2)-1, 1, 2, rnd({3, 11, 9}), -0.1)
            end
            if rnd(100) > 95 then
                addpickup(enemy.x, enemy.y)
            end
            if shake < 3 then
                shake = 2.5
            end
            sfx(17)
            del(enemies, enemy)
        end
    end

    add(enemies, enemy)
end

--Big ol fella that shoots CIRCLES of BULLETS!!!!!!

function addballshooter(x, y, health, speed)
    local enemy = {}
    enemy.x = x
    enemy.y = y
    enemy.offset = rnd()
    enemy.w = 8*3
    enemy.h = 8*2
    enemy.inv = -1
    enemy.health = health
    enemy.shootcooldown = 0
    enemy.speed = speed

    function enemy.draw(enemy)
        if enemy.inv < 0 or ceil(enemy.inv*10%2) == 1 then
            local sprite = 56
            local damaged = (enemy.health < 7)
            if damaged then sprite = 40 end
            spr(sprite, enemy.x, enemy.y, 3, 1, false, not damaged)
            spr(sprite, enemy.x, enemy.y+8, 3, 1, false, damaged)
        end
    end

    function enemy.shot(enemy)
        --explode
        explosion(enemy.x+rnd(32), enemy.y+rnd(32))
        --and reduce health
        enemy.health -= 1
        enemy.inv = 0.5
        sfx(16)
    end

    function enemy.collide(object)
        if enemy.x+4 >= object.x and enemy.x+4 <= object.x+object.w and enemy.y+4 >= object.y and enemy.y+4 <= object.y+object.h and object.inv < 0 then
            object:shot()
            explosion(enemy.x+4, enemy.y+4, 8*4, 8*2)
            enemy.health -= 3
        end
    end

    function enemy.update()
        enemy.x -= speed
        enemy.shootcooldown -= 1/60
        enemy.inv -= 1/60
        foreach(players, enemy.collide)
        if enemy.shootcooldown < 0 then
            enemy.shootcooldown = 2
            if enemy.x < 129 then
                for i = 1, 48, 1 do --shoot ring of bullets if on screen
                    if sin(i/48) < 0.3 and sin((i+currentwavetime)/8) < 0.4 then
                        addbullet(enemy.x+4, enemy.y+4, sin(i/48)/2, cos(i/48)/2, true, 2)
                    end
                end
                sfx(19) -- play shoot sound
            end
        end
        if enemy.x < -24 then
            del(enemies, enemy) --delete enemy if off screen
        end
        if enemy.health < 8 then --smokes when damaged!
            addcircle(enemy.x+20+rnd(8), enemy.y+4+rnd(8), -0.5, -0.2, rnd(8), rnd(1)+0.7, 5, 0)
        end
        if enemy.health <= 0 then
            for i = 1, 24, 1 do
                addcircle(enemy.x+rnd(8), enemy.y+rnd(8), rnd(4)-2, -rnd(2)-1, 1, 2, rnd({3, 11, 9}), -0.1)
            end
            if rnd(100) > 70 then
                addpickup(enemy.x, enemy.y)
            end
            if shake < 3 then
                shake = 12
            end
            sfx(20)
            explosion(enemy.x+4, enemy.y+4, 8*4, 8*2)
            del(enemies, enemy)
        end
    end

    add(enemies, enemy)
end

function addtargetingenemy(x, y, health, speed)
    local enemy = {}
    enemy.x = x
    enemy.y = y
    enemy.w = 16
    enemy.h = 8
    enemy.inv = -1
    enemy.health = health
    enemy.shootcooldown = rnd(0.4)+0.2
    enemy.speed = speed
    enemy.bulletcounter = 0

    function enemy.draw(enemy)
        if enemy.inv < 0 or ceil(enemy.inv*10%2) == 1 then
            spr(21, enemy.x, enemy.y, 2, 1)
        end
    end

    function enemy.shot(enemy)
        --explode
        explosion(enemy.x, enemy.y)
        enemy.inv = 0.5
        --and reduce health
        enemy.health -= 1
        if enemy.health > 0 then
            sfx(16) 
        end
    end

    function enemy.collide(object) --f this enemy collides with something, do damage to both it and itself. also EXPLODE!!!
        if enemy.x+4 >= object.x and enemy.x+4 <= object.x+object.w and enemy.y+4 >= object.y and enemy.y+4 <= object.y+object.h and object.inv < 0 then
            object:shot()
            explosion(enemy.x+4, enemy.y+4)
            enemy.health -= 2
        end
    end

    function enemy.update()
        enemy.x -= speed
        enemy.shootcooldown -= 1/60
        enemy.inv -= 1/60
        foreach(players, enemy.collide)
        if enemy.shootcooldown < 0 and currentwavetime%1.5>1.2 then
            enemy.shootcooldown = 0.1
            enemy.bulletcounter += 1
            local p = enemy.bulletcounter%#players+1
            if enemy.x < 129 and players[p].x < enemy.x+30 then --math involving a distance check to get the proper velocity for aiming
                local distance = sqrt((players[p].x - enemy.x)^2+(players[p].y - enemy.y)^2)
                local velx = (players[p].x - enemy.x)/distance
                local vely = (players[p].y - enemy.y)/distance
                addbullet(enemy.x-3, enemy.y, velx, vely, true, 2) -- shoot if on screen
                sfx(15) -- play shoot sound if on screen
            end
        end
        if enemy.x < -16 then
            del(enemies, enemy) -- delete enemy if off screen
        end
        if enemy.health <= 0 then -- die!!!!!
            for i = 1, rnd(6)+6, 1 do
                addcircle(enemy.x+rnd(8), enemy.y+rnd(16), rnd(4)-2, -rnd(2)-1, 1, 2, rnd({3, 11, 9}), -0.1)
            end
            if rnd(100) > 85 then
                addpickup(enemy.x, enemy.y)
            end
            if shake < 3 then
                shake = 3.5
            end
            sfx(17)
            explosion(enemy.x, enemy.y, 16, 8)
            del(enemies, enemy)
        end
    end

    add(enemies, enemy)
end

function addlasershooter(x, y, speed, stay)
    local enemy = {}
    enemy.x = x+128
    enemy.y = y
    if stay then enemy.y = 64-20 end
    enemy.w = 8*4
    enemy.h = 8*4
    enemy.speed = speed
    enemy.stay = stay
    enemy.inv = -1
    enemy.health = 36
    enemy.lasertimer = 0
    enemy.firedlaser = false
    enemy.shootcooldown = 0
    enemy.moveoffset = 0
    enemy.sinspeed = 4

    function enemy.draw(enemy)
        if enemy.inv < 0 or ceil(enemy.inv*10%2) == 1 then
            local damaged = (enemy.health < 12)
            local sprite = 64
            if damaged then sprite = 96 end
            spr(sprite,enemy.x+0,enemy.y+4,4,2, false, damaged)
            spr(sprite,enemy.x+0,enemy.y+20,4,2,false,not damaged)
        end
    end

    function enemy.shot(enemy)
        --explode
        explosion(enemy.x, enemy.y)
        enemy.inv = 0.5
        --and reduce health
        enemy.health -= 1
        if enemy.health > 0 then
            sfx(16) 
        end
    end

    function enemy.collide(object) --f this enemy collides with something, do damage to both it and itself. also EXPLODE!!!
        if enemy.x+4 >= object.x and enemy.x+4 <= object.x+object.w and enemy.y+4 >= object.y and enemy.y+4 <= object.y+object.h and object.inv < 0 then
            object:shot()
            explosion(enemy.x+4, enemy.y+4)
            enemy.health -= 2
        end
    end

    function enemy.update()
        if enemy.x > 90 or (not stay and enemy.lasertimer > 4) then --enemy lerps into place when first added, and if they leave they speed up
            enemy.x -= enemy.speed/2
            if enemy.lasertimer > 4 then
                enemy.speed += 0.025
            else
                enemy.x = enemy.x + 0.03 * (90 - enemy.x);
            end
        end

        if enemy.lasertimer > 4 and stay then
            enemy.y = 64-20 + sin(enemy.moveoffset+enemy.lasertimer/enemy.sinspeed) * 40
            enemy.shootcooldown -= 1/60
            if enemy.shootcooldown < 0 then
                enemy.shootcooldown = 0.18
                addbullet(enemy.x+6, enemy.y+20, -1, rnd(2)-1, true, 2) --shoooot!!!!!
                sfx(15) -- play shoot sound if on screen
            end
        end

        if enemy.x <= 90 then
            if not enemy.firedlaser then
                addlaser(enemy.x+6, enemy.y+20, 10)
                enemy.moveoffset = rnd({0,0.5}) --add offset so not moving in same direction each time
                enemy.sinspeed = rnd({4,4,4,4,4,4,4,4,4,4,4,4,1,8,2,2,2,2}) --add differing speeds to sin up and down randomly
            end
            enemy.firedlaser = true
            enemy.lasertimer += 1/60
            if enemy.lasertimer > 8 and stay then
                enemy.firedlaser = false
                enemy.lasertimer = 0
            end
        end

        if enemy.health < 8 then --smokes when damaged! copy pasted from ball shooter!
            addcircle(enemy.x+12+rnd(8), enemy.y+12+rnd(8), -0.5, -0.2, rnd(8), rnd(1)+0.7, 5, 0)
        end

        enemy.inv -= 1/60
        foreach(players, enemy.collide)

        if enemy.x < -32 then
            del(enemies, enemy) -- delete enemy if off screen
        end

        if enemy.health <= 0 then -- die!!!!!
            explosion(enemy.x,enemy.y,32,32)
            for i = 1, 40, 1 do
                addcircle(enemy.x+rnd(32), enemy.y+rnd(32), sin(t()*2), -rnd(2)-1, 1, 2, rnd({3, 11, 9}), -0.1)
            end
            addpickup(enemy.x+rnd(32), enemy.y+rnd(32), "health")
            addpickup(enemy.x+rnd(32), enemy.y+rnd(32))
            addpickup(enemy.x+rnd(32), enemy.y+rnd(32))
            if shake < 3 then
                shake = 6
            end
            sfx(26)
            del(enemies, enemy)
        end
    end

    add(enemies, enemy)
end