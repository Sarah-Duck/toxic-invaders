enemies = {}

--universal functions:
function enemyshot(enemy)
    --explode
    explosion(enemy.x+rnd(enemy.w), enemy.y+rnd(enemy.h))
    enemy.inv = 0.5
    --and reduce health
    enemy.health -= 1
    if enemy.health > 0 then
        sfx(16, 2) 
    end
end

function enemycollide(enemy, object) --f this enemy collides with something, do damage to both it and itself. also EXPLODE!!!
    if enemy.x <= object.x+object.w and enemy.x+enemy.w >= object.x and enemy.y <= object.y +object.h and enemy.y+enemy.h >= object.y and object.inv < 0 then
        object:shot()
        explosion(enemy.x+4+rnd(enemy.w-4), enemy.y+4*rnd(enemy.h-4))
        enemy.health -= 2
    end
end

function enemydie(enemy, sound)
    for i = 1, rnd(enemy.h)+6, 1 do
        addcircle(enemy.x+rnd(enemy.w), enemy.y+rnd(enemy.h), rnd(4)-2, -rnd(2)-1, 1, 2, rnd({3, 11, 9}), -0.1)
    end
    if rnd(100) > 95 then
        addpickup(enemy.x+rnd(enemy.w), enemy.y+rnd(enemy.h))
    end
    if shake < 3 then
        shake = enemy.h/2
    end
    sfx(sound, 2)
    del(enemies, enemy)
end

function enemymisc(enemy) --misc stuff every enemy needs
    enemy.shootcooldown -= 1/60
    enemy.inv -= 1/60
    for i = 1, #players, 1 do
        enemy.collide(enemy, players[i])
    end
    if enemy.x < -enemy.w then
        del(enemies, enemy) -- delete enemy if off screen
    end
end

function addbasicenemy(x, y, speed) --basic small weak enemy
    local enemy = {
        x = x,
        y = y,
        w = 8,
        h = 8,
        inv = -1,
        sprite = rnd({14, 30, 46, 62}), --these are all possible 8x8 basic enemy sprites
        health = 1,
        shootcooldown = rnd(2)+1,
        speed = speed
    }

    function enemy.draw(enemy)
        local sprite = enemy.sprite
        if flr(sin(time()*speed)) ~= 0 then --if the ships heading up, change sprite
            sprite += 1
        end
        if enemy.inv < 0 or ceil(enemy.inv*10%2) == 1 then
            spr(sprite, enemy.x, enemy.y)
        end
    end

    enemy.shot = enemyshot

    enemy.collide = enemycollide

    function enemy.update()
        enemy.x -= speed
        enemy.y += sin(time()*speed)*speed
        if enemy.shootcooldown < 0 then
            enemy.shootcooldown = 0.5 + rnd(1.5)
            if enemy.x < 129 then
                addbullet(enemy.x-3, enemy.y, -1, 0, true, 2) -- shoot if on screen
                sfx(15, 2) -- play shoot sound if on screen
            end
        end
        enemymisc(enemy)
        if enemy.health <= 0 then -- die!!!!!
            enemydie(enemy,17)
        end
    end

    add(enemies, enemy)
end

--SHOOTER THAT SHOOTS BIG WALLS!!!!!!

function addwallshooter(x, shootup, health, speed, offset, bulletspeed)
    local enemy = {
        x = x,
        y = 119,
        sprite = 60,
        offset = offset or rnd(),
        w = 8,
        h = 8,
        inv = -1,
        health = health,
        shootcooldown = 0,
        speed = speed,
        shoottoggle = true,
        bulletspeed = bulletspeed or 1,
    }
    if shootup then
        enemy.y = 1
        enemy.sprite = 44
    end

    function enemy.draw(enemy)
        if enemy.inv < 0 or ceil(enemy.inv*10%2) == 1 then
            spr(enemy.sprite+t()*10%2, enemy.x, enemy.y)
        end
    end

    enemy.shot = enemyshot

    enemy.collide = enemycollide

    function enemy.update()
        enemy.x -= speed
        if enemy.shootcooldown < 0 then
            if (t()+enemy.offset)%1>0.5/enemy.bulletspeed then
                if not enemy.shoottoggle then --implemented a toggle so that the sound effect for firing gets played only once.
                    enemy.shoottoggle = true
                    if enemy.x < 128 then
                        sfx(18, 3)
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
        enemymisc(enemy)
        if enemy.health <= 0 then
            enemydie(enemy,17)
        end
    end

    add(enemies, enemy)
end

--Big ol fella that shoots CIRCLES of BULLETS!!!!!!

function addballshooter(x, y, health, speed)
    local enemy = {
        x = x,
        y = y,
        offset = rnd(),
        w = 8*3,
        h = 8*2,
        inv = -1,
        health = health,
        shootcooldown = 0,
        speed = speed
    }

    function enemy.draw(enemy)
        if enemy.inv < 0 or ceil(enemy.inv*10%2) == 1 then
            local sprite = 27
            if health < 7 then sprite = 11 end
            spr(sprite, enemy.x, enemy.y, 3, 1, false, true)
            spr(sprite, enemy.x, enemy.y+8, 3, 1)
        end
    end

    enemy.shot = enemyshot

    enemy.collide = enemycollide

    function enemy.update()
        enemy.x -= speed
        if enemy.shootcooldown < 0 then
            enemy.shootcooldown = 2
            if enemy.x < 129 then
                for i = 1, 48, 1 do --shoot ring of bullets if on screen
                    if sin(i/48) < 0.3 and sin((i+currentwavetime)/8) < 0.4 then
                        addbullet(enemy.x+4, enemy.y+4, sin(i/48)/2, cos(i/48)/2, true, 2)
                    end
                end
                sfx(19, 3) -- play shoot sound
            end
        end
        enemymisc(enemy)
        if enemy.health < 8 then --smokes when damaged!
            addcircle(enemy.x+20+rnd(8), enemy.y+4+rnd(8), -0.5, -0.2, rnd(8), rnd(1)+0.7, 5, 0)
        end
        if enemy.health <= 0 then
            enemydie(enemy,20)
        end
    end

    add(enemies, enemy)
end

function addtargetingenemy(x, y, health, speed)
    local enemy = {
        x = x,
        y = y,
        w = 16,
        h = 8,
        inv = -1,
        health = health,
        shootcooldown = rnd(0.4)+0.2,
        speed = speed,
        bulletcounter = 0
    }

    function enemy.draw(enemy)
        if enemy.inv < 0 or ceil(enemy.inv*10%2) == 1 then
            spr(58, enemy.x, enemy.y, 2, 1)
        end
    end

    enemy.shot = enemyshot

    enemy.collide = enemycollide

    function enemy.update()
        enemy.x -= speed
        if enemy.shootcooldown < 0 and currentwavetime%1.5>1.2 then
            enemy.shootcooldown = 0.1
            enemy.bulletcounter += 1
            local p = enemy.bulletcounter%#players+1
            if enemy.x < 129 and players[p].x < enemy.x+30 then --math involving a distance check to get the proper velocity for aiming
                local distance = sqrt((players[p].x - enemy.x)^2+(players[p].y - enemy.y)^2)
                local velx = (players[p].x - enemy.x)/distance
                local vely = (players[p].y - enemy.y)/distance
                addbullet(enemy.x-3, enemy.y, velx, vely, true, 2) -- shoot if on screen
                sfx(15, 2) -- play shoot sound if on screen
            end
        end
        enemymisc(enemy)
        if enemy.health <= 0 then -- die!!!!!
            enemydie(enemy,17)
        end
    end

    add(enemies, enemy)
end

function addlasershooter(x, y, speed, stay)
    local enemy = {
        x = x+128,
        y = y,
        w = 8*4,
        h = 8*4,
        speed = speed,
        stay = stay,
        inv = -1,
        health = 36 * #players, -- double health if 2 player
        lasertimer = 0,
        firedlaser = false,
        shootcooldown = 0,
        moveoffset = 0,
        sinspeed = 4
    }
    if stay then enemy.y = 64-20 end

    function enemy.draw(enemy)
        if enemy.inv < 0 or ceil(enemy.inv*10%2) == 1 then
            local sprite = 64
            if enemy.health < 12 then sprite = 96 end
            spr(sprite,enemy.x+0,enemy.y+4,4,2)
            spr(sprite,enemy.x+0,enemy.y+20,4,2,false,true)
        end
    end

    enemy.shot = enemyshot

    enemy.collide = enemycollide

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
            if enemy.shootcooldown < 0 then
                enemy.shootcooldown = 0.18
                addbullet(enemy.x+6, enemy.y+20, -1, rnd(2)-1, true, 2) --shoooot!!!!!
                sfx(15, 2) -- play shoot sound if on screen
            end
        end

        if enemy.x <= 90 then
            if not enemy.firedlaser then
                addlaser(enemy.x+6, enemy.y+20, 10)
                enemy.moveoffset = rnd({0,0.5}) --add offset so not moving in same direction each time
                enemy.sinspeed = rnd({4,4,4,4,4,4,4,4,4,4,4,4,1,8,2,2,2,2}) --add differing speeds to sin up and down randomly
                if enemy.health < 15*#players then
                    enemy.sinspeed /= 2
                end
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

        enemymisc(enemy)

        if enemy.health <= 0 then -- die!!!!!
            enemydie(enemy,26)
            addpickup(enemy.x+rnd(32), enemy.y+rnd(32), "health")
            addpickup(enemy.x+rnd(32), enemy.y+rnd(32))
            addpickup(enemy.x+rnd(32), enemy.y+rnd(32))
        end
    end

    add(enemies, enemy)
end

function addwallboss(x, y, length, speed, stay, move)
    local enemy = {
        stay = stay or false,
        move = move or 1,
        x = x,
        y = y,
        length = mid(4,length,16),
        w = 24,
        h = 8*length,
        inv = -1,
        health = 10*length*#players,
        shootcooldown = 3,
        speed = speed,
        bulletfired = {},
    }

    for i = 1, length, 1 do
        enemy.bulletfired[i] = 0
    end

    function enemy.draw(enemy)
        local dmg = 0
        if enemy.health < length * 4 * #players then
            dmg = 16
        end
        if enemy.inv < 0 or ceil(enemy.inv*10%2) == 1 then
            for i = 2, length-1, 1 do
                spr(93+enemy.bulletfired[i]+dmg, enemy.x, -8+enemy.y+i*8)
                if i < length-2 then
                    spr(79+((i%3)%2*16)+dmg*2, enemy.x+8, -8+enemy.y+i*8, 1, 1, false, (i%3 == 2))
                end
            end
            spr(77+enemy.bulletfired[1]+dmg*2, enemy.x, enemy.y)
            spr(77+enemy.bulletfired[1]+dmg*2, enemy.x, enemy.y+length*8-8, 1, 1, false, true)
            spr(70+dmg,enemy.x+8,enemy.y,2,2)
            spr(70+dmg*2,enemy.x+8,enemy.y+length*8-16,2,2,false,true)
            spr(79+dmg,enemy.x+8,enemy.y+length*8-24,1,1)
        end
    end

    enemy.shot = enemyshot

    enemy.collide = enemycollide

    function enemy.update()
        if not enemy.stay then
            enemy.x -= speed
        else 
            enemy.x = enemy.x + 0.025 * (102 - enemy.x); --lerp if boss
            enemy.move = flr((currentwavetime/5)%5) -- loops through moveset
        end
        if enemy.shootcooldown < 0 then
            enemy.shootcooldown = 0.095
            if enemy.x < 129 then

                local function attack(i, move) -- these are all the conditions to shoot depending on what "move" this guys on
                    if move == 0 and (flr((t()*4)%length) == i or flr((-t()*4)%length) == i) and i%2 == 1 then --this one shoots lines in a pattern
                        return true
                    elseif move == 1 then -- this one targets the players and shoots some random ones
                        for p = 1, #players, 1 do
                            if flr(players[p].y/8) == i-1 and everysecondtimer < 0.7 then
                                return true
                            end
                        end
                    elseif move == 2 and i == ceil(rnd(length*1.3)) then -- this one is just random ones
                        return true
                    elseif move == 3 then --this one is that neat weaving pattern, shout out to don't get a virus fans!
                        if i > length/3 and i < length/3*2 then
                            if currentwavetime%1.5 < 0.15 then
                                return true
                            end
                        elseif currentwavetime%1.5 > 0.7 and currentwavetime%1.5 < 0.85 then
                            return true
                        end
                    elseif move == 5 and (i < length/3+sin(t()/3)*3 or i > length/3*2+sin(t()/3)*3 or ceil(rnd(length*7)) == i) then -- this one is a wavy bullet corridor
                        return true
                    end
                end

                for i = 1, length, 1 do
                    if attack(i, enemy.move) then
                        addbullet(enemy.x, -4+i*8, -1, 0, true, 2)
                        enemy.bulletfired[i] = 1
                    else
                        enemy.bulletfired[i] = 0
                    end
                end
            end
        end
        enemymisc(enemy)
        if enemy.health <= 0 then -- die!!!!!
            enemydie(enemy,17)
        end
    end

    add(enemies, enemy)
end