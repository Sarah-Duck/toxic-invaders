enemies = {}

basicenemysprites = {11, 27, 43, 59} --these are all possible 8x8 basic enemy sprites

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
    enemy.shootcooldown = rnd(1)+2
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
        sfx(4)
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
        enemy.y += sin(time()*speed)*speed
        enemy.shootcooldown -= 1/60
        enemy.inv -= 1/60
        foreach(players, enemy.collide)
        if enemy.shootcooldown < 0 then
            enemy.shootcooldown = 0.5 + rnd(1.5)
            addbullet(enemy.x-3, enemy.y, -1, 0, true, 3)
            sfx(3)
        end
        if enemy.x < -8 then
            del(enemies, enemy)
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
            sfx(2)
            del(enemies, enemy)
        end
    end

    add(enemies, enemy)
end

--SHOOTER THAT SHOOTS BIG WALLS!!!!!!

function addwallshooter(x, shootup, health, speed)
    local enemy = {}
    enemy.x = x
    enemy.y = 120
    enemy.sprite = 45
    enemy.offset = rnd()
    if shootup then
        enemy.y = 0
        enemy.sprite = 29
    end
    enemy.w = 8
    enemy.h = 8
    enemy.inv = -1
    enemy.health = health
    enemy.shootcooldown = 0
    enemy.speed = speed

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
        sfx(4)
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
        if enemy.shootcooldown < 0 and (t()+enemy.offset)%1>0.5 then
            enemy.shootcooldown = 0.08
            local vely = -1
            if shootup then vely = 1 end
            addbullet(enemy.x-3, enemy.y, -speed, vely, true, 3)
        end
        if enemy.x < -8 then
            del(enemies, enemy)
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
            sfx(2)
            del(enemies, enemy)
        end
    end

    add(enemies, enemy)
end