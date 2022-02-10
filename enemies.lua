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

function addwallshooter(x, shootup, health, speed)
    local enemy = {}
    enemy.x = x
    enemy.y = 119
    enemy.sprite = 60
    enemy.offset = rnd()
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
            if (t()+enemy.offset)%1>0.5 then
                if not enemy.shoottoggle then --implemented a toggle so that the sound effect for firing gets played only once.
                    enemy.shoottoggle = true
                    if enemy.x < 128 then
                        sfx(18)
                    end
                end
                enemy.shootcooldown = 0.08
                local vely = -1
                if shootup then vely = 1 end
                addbullet(enemy.x, enemy.y, -speed, vely, true, 2)
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
    enemy.w = 8*4
    enemy.h = 8*2
    enemy.inv = -1
    enemy.health = health
    enemy.shootcooldown = 0
    enemy.speed = speed

    function enemy.draw(enemy)
        if enemy.inv < 0 or ceil(enemy.inv*10%2) == 1 then
            local sprite = 56
            if enemy.health < 7 then sprite = 40 end
            spr(sprite, enemy.x, enemy.y, 4, 1, false, true)
            spr(sprite, enemy.x, enemy.y+8, 4, 1)
        end
    end

    function enemy.shot(enemy)
        --explode
        explosion(enemy.x+rnd(16), enemy.y+rnd(8))
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
        if enemy.x < -32 then
            del(enemies, enemy) --delete enemy if off screen
        end
        if enemy.health < 8 then --smokes when damaged!
            addcircle(enemy.x+20+rnd(8), enemy.y+4+rnd(8), -0.5, -0.2, rnd(8), rnd(1)+0.7, 5, 0)
        end
        if enemy.health <= 0 then
            for i = 1, 24, 1 do
                addcircle(enemy.x+rnd(8), enemy.y+rnd(8), rnd(4)-2, -rnd(2)-1, 1, 2, rnd({3, 11, 9}), -0.1)
            end
            if rnd(100) > 80 then
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