enemies = {}
canshootatx = 126 --the point on screen when they can start shooting. this needs to be a thing for the final boss portal
finalbossalive = true --final boss WONT drop shit
function killallenemies()
    for i = 1, #enemies, 1 do
        enemies[i].health = -1
    end
end
--universal functions:
function enemyshot(enemy)
    enemy.inv = 0.5
    --reduce health
    enemy.health -= 1
    if enemy.health > 0 then
        sfx(16, 2)
        --explosion(enemy.x+rnd(enemy.w), enemy.y+rnd(enemy.h)) --explode!!!!!!
    end
end

function enemycollide(enemy, object) --f this enemy collides with something, do damage to both it and itself. also EXPLODE!!!
    local rnd,explosion = rnd,explosion
    local _ENV = enemy --trying to save tokens?
    if x <= object.x+object.w and x+w >= object.x and y <= object.y +object.h and y+h >= object.y and object.inv < 0 then
        object:shot()
        explosion(x+4+rnd(w-4), y+4*rnd(h-4))
        health -= 2
    end
end

function enemydie(enemy, sound, soundchannel, points, isboss)
    if enemy.health < 1 then --no health? die.
        local x,y = enemy.x,enemy.y
        for i = 1, rnd(enemy.h)+6, 1 do
            addcircle(x+rnd(enemy.w), y+rnd(enemy.h), rnd(4)-2, -rnd(2)-1, 1, 2, rnd({3, 11, 9}), -0.1)
        end
        if rnd(100) < sqrt(enemy.w*enemy.h)/1.5 and finalbossalive then --you get a better chance of a randomly dropped health from bigger enemies
            addpickup(x+rnd(enemy.w), y+rnd(enemy.h), 48)
        end
        if isboss then
            playsong(-1, 3000)
            sfx(60,-2) --stop missle sound, less tokens to just have it here.
            despawnallbullets = true
            killallenemies()
            if not gameover and finalbossalive then
                addpickup(x+rnd(32), y+rnd(32))
                addpickup(x+rnd(32), y+rnd(32), 48)
            end
        end
        if shake < 3 then
            shake = enemy.h/2
        end
        currentscore += points
        sfx(sound, soundchannel)
        explosion(x, y, enemy.w, enemy.h)
        del(enemies, enemy)
        enemy.x,enemy.y = x,y
    end
end

function enemymisc(enemy) --misc stuff every enemy needs
    enemy.shootcooldown -= ft
    enemy.inv -= ft
    foreach(players, function(player) enemy:collide(player) end)
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
        speed = speed,
        shot = enemyshot,
        collide = enemycollide
    }

    function enemy.draw()
        local sprite = enemy.sprite
        if flr(sin(time()*speed)) ~= 0 then --if the ships heading up, change sprite
            sprite += 1
        end
        if enemy.inv < 0 or flashtime then
            spr(sprite, enemy.x, enemy.y)
        end
    end

    function enemy.update()
        enemy.x -= speed
        enemy.y += sin(time()*speed)*speed
        if enemy.shootcooldown < 0 then
            enemy.shootcooldown = 0.5 + rnd(1.5)
            if enemy.x < canshootatx and enemy.x > 5 then
                addbullet(enemy.x-3, enemy.y, -1, 0) -- shoot if on screen
                sfx(15,2) -- play shoot sound if on screen
            end
        end
        enemymisc(enemy)
        enemydie(enemy,17,2,10) --die!!!!
    end

    add(enemies, enemy)
end


--SHOOTER THAT SHOOTS BIG WALLS!!!!!!
function addwallshooter(x, shootup, speed, offset, bulletspeed)
    local enemy = {
        x = x,
        y = 119,
        sprite = 60,
        offset = offset or rnd(),
        w = 8,
        h = 8,
        inv = -1,
        health = 10, --10
        shootcooldown = 0,
        -- speed = speed,
        shoottoggle = true,
        bulletspeed = bulletspeed or 1,
        shot = enemyshot,
        collide = enemycollide
    }
    if shootup then
        enemy.y = 1
        enemy.sprite = 44
    end

    function enemy.draw()
        if enemy.health < 3 then damagesmoke(enemy) end
        if enemy.inv < 0 or flashtime then
            spr(enemy.sprite+t()*10%2, enemy.x, enemy.y)
        end
    end

    function enemy.update()
        enemy.x -= speed
        if enemy.shootcooldown < 0 then
            if (t()+enemy.offset)%1>0.5/enemy.bulletspeed then
                enemy.shootcooldown = 0.08/enemy.bulletspeed
                local velywall = -1
                if shootup then velywall = 1 end
                if enemy.x < 120 and enemy.x > 20 then
                    addbullet(enemy.x, enemy.y, -speed, enemy.bulletspeed*velywall)
                    if not enemy.shoottoggle and currentwave ~= 19 then --implemented a toggle so that the sound effect for firing gets played only once.
                        enemy.shoottoggle = true
                        sfx(18,3)
                    end
                end
            else
                enemy.shoottoggle = false
            end
        end
        enemymisc(enemy)
        enemydie(enemy,17,2,15)
    end

    add(enemies, enemy)
end

--Big ol fella that shoots CIRCLES of BULLETS!!!!!!

function addballshooter(x, y, speed)
    local enemy = {
        x = x,
        y = y,
        offset = rnd(),
        w = 8*3,
        h = 8*2,
        inv = -1,
        health = 12,
        shootcooldown = 0,
        speed = speed,
        shot = enemyshot,
        collide = enemycollide
    }

    function enemy.draw()
        if enemy.inv < 0 or flashtime then
            local sprite = 9
            if enemy.health < 4 then
                damagesmoke(enemy)
                sprite = 41
            end
            -- spr(sprite, enemy.x, enemy.y, 3, 1, false, true)
            spr(sprite, enemy.x, enemy.y, 3, 2) --non-flipped image for token's sake
        end
    end

    function enemy.update()
        enemy.x -= speed
        if enemy.shootcooldown < 0 then
            enemy.shootcooldown = 2
            if enemy.x < canshootatx and enemy.x > 0 then
                for i = 1, 48, 1 do --shoot ring of bullets if on screen
                    if sin(i/48) < 0.3 and sin((i+currentwavetime)/8) < 0.4 then
                        addbullet(enemy.x+4, enemy.y+4, sin(i/48)/2, cos(i/48)/2)
                    end
                end
                sfx(19,3) -- play shoot sound
            end
        end
        enemymisc(enemy)
        enemydie(enemy,20,3,40)
    end

    add(enemies, enemy)
end

function addtargetingenemy(x, y, speed)
    local enemy = {
        x = x,
        y = y,
        w = 16,
        h = 8,
        inv = -1,
        health = 3,
        shootcooldown = rnd(0.4)+0.2,
        speed = speed,
        shot = enemyshot,
        collide = enemycollide
    }

    function enemy.draw()
        if enemy.health < 2 then
            damagesmoke(enemy)
        end
        if enemy.inv < 0 or flashtime then
            spr(28, enemy.x, enemy.y, 2, 1)
        end
    end

    function enemy.update()
        enemy.x -= speed
        if enemy.shootcooldown < 0 and currentwavetime%1.5>1.2 then
            enemy.shootcooldown = 0.1
            if enemy.x < canshootatx and targetplayer.x < enemy.x+30 then --math involving a distance check to get the proper velocity for aiming
                local distance = sqrt((targetplayer.x - enemy.x)^2+(targetplayer.y - enemy.y)^2)
                local velx = (targetplayer.x - enemy.x)/distance
                local vely = (targetplayer.y - enemy.y)/distance
                addbullet(enemy.x-3, enemy.y, velx, vely) -- shoot if on screen
                sfx(15,2) -- play shoot sound if on screen
            end
        end
        enemymisc(enemy)
        enemydie(enemy,17,2,20)
    end

    add(enemies, enemy)
end

function addlasershooter(x, y, points, speed, stay, isboss)
    local enemy = {
        x = x+128,
        y = y,
        w = 8*4,
        h = 8*4,
        speed = speed,
        stay = stay,
        inv = -1,
        health = 42 * #players, -- double health if 2 player --42
        lasertimer = 0,
        firedlaser = false,
        shootcooldown = 0,
        moveoffset = 0,
        sinspeed = 4,
        shot = enemyshot,
        collide = enemycollide
    }
    if stay then enemy.y = 48 end

    function enemy:draw()
        if enemy.inv < 0 or flashtime then
            local sprite = 5
            if enemy.health < 10 then
                damagesmoke(enemy)
                sprite = 65
            end
            spr(sprite,enemy.x,enemy.y,4,4) --non-flipped sprite to reduce tokens
            -- spr(sprite,enemy.x+0,enemy.y+16,4,2,false,true)
        end
    end

    function enemy.update()
        if enemy.x > 90 or (not stay and enemy.lasertimer > 4) then --enemy lerps into place when first added, and if they leave they speed up
            enemy.x -= enemy.speed/2
            if enemy.lasertimer > 4 then
                enemy.speed += 0.025
            else
                enemy.x = lerp(enemy.x, 90, 0.03)
            end
        end

        if enemy.lasertimer > 4 and stay then
            enemy.y = 48 + sin(enemy.moveoffset+enemy.lasertimer/enemy.sinspeed) * 40
            if enemy.shootcooldown < 0 then
                enemy.shootcooldown = 0.18
                addbullet(enemy.x+8, enemy.y+12, -1, rnd(2)-1) --shoooot!!!!!
                sfx(15,2)
            end
        end

        if enemy.x <= 90 then
            if not enemy.firedlaser then
                addlaser(enemy.x+6, enemy.y+16, 10, enemy)
                enemy.moveoffset = rnd({0,0.5}) --add offset so not moving in same direction each time
                enemy.sinspeed = rnd({4,4,4,4,4,1,8,2}) --add differing speeds to sin up and down randomly
                if enemy.health < 20*#players then
                    enemy.sinspeed /= 2
                end
            end
            enemy.firedlaser = true
            enemy.lasertimer += ft
            if enemy.lasertimer > 8 and stay then
                enemy.firedlaser = false
                enemy.lasertimer = 0
            end
        end

        enemymisc(enemy)
        enemydie(enemy,21,3,points,isboss)
    end

    add(enemies, enemy)
end


--ERROR damage model has incorrect tiling for endings and lights
function addwallboss(x, y, length, points, speed, stay, move, isboss)
    local enemy = {
        stay = stay or false,
        move = move or 1,
        x = x,
        y = y,
        length = mid(4,length,16),
        w = 16,
        h = 8*length,
        inv = -1,
        health = 3.5*length*#players, --3.5
        shootcooldown = 3,
        speed = speed,
        shot = enemyshot,
        collide = enemycollide
    }
    bulletfired = {}
    enemy.starthealth = enemy.health
    if isboss then enemy.health *= 4 end -- triple health if the boss

    for i = 1, length, 1 do
        bulletfired[i] = 0
    end

    function enemy.draw()
        local x,y = enemy.x,enemy.y
        local dmgwall = 0
        if enemy.health < enemy.starthealth*0.25 then
            damagesmoke(enemy)
            dmgwall = 32
        end
        if enemy.inv < 0 or flashtime then
            for i = 2, length-1, 1 do
                spr(93+bulletfired[i]+dmgwall, x, -8+y+i*8)
                if i < length-2 then
                    spr(79+((i%3)%2*16)+dmgwall, x+8, -8+y+i*8, 1, 1, false, (i%3 == 2))
                end
            end
            spr(77+bulletfired[1]+dmgwall, x, y)
            spr(77+bulletfired[1]+dmgwall, x, y+length*8-8, 1, 1, false, true)
            spr(71+dmgwall,x+8,y,2,2)
            spr(71+dmgwall,x+8,y+length*8-16,2,2,false,true)
            spr(79+dmgwall,x+8,y+length*8-24,1,1, false, true)
        end
    end

    function enemy.update()
        if not enemy.stay then
            enemy.x -= speed
        else 
            enemy.x = lerp(enemy.x, 102, 0.025) --lerp if boss
            enemy.move = currentwavetime\5%5 -- loops through moveset
        end
        if enemy.shootcooldown < 0 then
            enemy.shootcooldown = 0.095
            if enemy.x < canshootatx then

                local function attack(i, move) -- these are all the conditions to shoot depending on what "move" this guys on
                    if move == 0 and (t()\0.25%length == i or -t()\0.25%length == i) and i%2 == 1 then --this one shoots lines in a pattern
                        return true
                    elseif move == 1 then -- this one targets the players and shoots some random ones
                        for p = 1, #players, 1 do
                            if players[p].y\8 == i-1 and everysecondtimer < 0.7 then
                                return true
                            end
                        end
                    elseif move == 2 and i == ceil(rnd(length)) then -- this one is just random ones
                        return true
                    elseif move == 3 then --this one is that neat weaving pattern, shout out to don't get a virus fans!
                        if currentwavetime%5 < 4.5 then
                            if i > length/3 and i < length/3*2 then
                                if everysecondtimer < 0.1 then
                                    return true
                                end
                            elseif everysecondtimer > 0.5 and everysecondtimer < 0.6 then
                                return true
                            end
                        end
                    elseif move == 4 and (i < length/3+sin(t()/2)*3 or i > length/3*2+sin(t()/2)*3) then -- this one is a wavy bullet corridor
                        return true
                    end
                end

                for i = 1, length, 1 do
                    if attack(i, enemy.move) then
                        addbullet(enemy.x, enemy.y-8+i*8, -1, 0)
                        sfx(15,2)
                        bulletfired[i] = 1
                    else
                        bulletfired[i] = 0
                    end
                end
            end
        end
        enemymisc(enemy)
        enemydie(enemy,21,3,points,isboss) --die
    end

    add(enemies, enemy)
end

function addbomb(x, y, delay) --BIG BOMB!!!! KILL IIT QUICKLY!!!!
    local enemy = {
        x = x,
        y = y,
        w = 32,
        h = 32,
        inv = -1,
        health = 12,
        shootcooldown = 0+delay,
        shot = enemyshot,
        collide = enemycollide
    }
    local pointsbomb = 50 --points by default if killed by player
    local sfxbomb = 5

    function enemy.draw()
        local x,y = enemy.x,enemy.y
        local sprite = 73
        if everysecondtimer > 0.5 then sprite = 75 end --animation
        if enemy.health < 7 then
            damagesmoke(enemy)
            sprite += 32
        end
        if enemy.inv < 0 or flashtime then
            circfill(x+15, y+16, sin(enemy.shootcooldown^2)*3-enemy.shootcooldown, rnd({7,11,3}))
            local offsetbomb = mid(0, -enemy.shootcooldown-2, 3)
            spr(sprite, x, y-offsetbomb, 2, 2)
            spr(sprite, x, y+16+offsetbomb, 2, 2, false, true)
            spr(sprite, x+15, y-offsetbomb, 2, 2, true)
            spr(sprite, x+15, y+16+offsetbomb, 2, 2, true, true)
        end
    end

    function enemy.update()
        enemy.y += sin(time()/3)/8
        if enemy.shootcooldown < -8 then -- detonation
            for i = 1, 60, 1 do
                addbullet(enemy.x+16, enemy.y+16, sin(i/60), cos(i/60))
                sfxbomb = 6 --killboom
                pointsbomb = -40 --loss of points
                enemy.health = 0
            end
        elseif enemy.shootcooldown < 0 then
            enemy.x = lerp(enemy.x, 80, 0.02)
        end
        enemymisc(enemy)
        enemydie(enemy,sfxbomb,3,pointsbomb) --die bastard!!!!!!
        --charge sound
        if enemy.x < 120 and everysecondtimer%0.2 < 0.025 then
            if enemy.shootcooldown < -5 then
                sfx(8,3) --rapid
            else
                sfx(7,2) --normal
            end
        end 
    end

    add(enemies, enemy)
end


function addmissileboss(x, y) --boss that shoots missiles!!!
    local enemy = {
        x = x,
        y = y,
        targetx = 90,
        targety = 48,
        targetchangetimer = 2,
        w = 32,
        h = 32,
        inv = -1,
        health = 40*#players, --40
        shootcooldown = 1.8,
        speed = 0.04,
        shot = enemyshot,
        collide = enemycollide
    }

    function enemy.draw()
        local sprite = 69
        if enemy.health < 11 then
            sprite = 101
            damagesmoke(enemy)
        end
        if enemy.inv < 0 or flashtime then
            spr(sprite, enemy.x, enemy.y, 4, 2)
            spr(sprite, enemy.x, enemy.y+16, 4, 2, false, true)
        end
    end

    function enemy.update()
        enemy.targetchangetimer -= ft
        --some cool different moves, shout out to dont get a virus fans!
        if currentwavetime%18 > 8 and currentwavetime%20 < 12 then
            enemy.targety = everysecondtimer\0.501*96
        elseif currentwavetime%18 > 17.3 then --INTIMIDATION TACTICS!!!!!
            enemy.targety = targetplayer.y-10
            enemy.targetx = targetplayer.x+24
            enemy.shootcooldown = 0.8
        end
        enemy.x = lerp(enemy.x, enemy.targetx, enemy.speed)
        enemy.y = lerp(enemy.y, enemy.targety, enemy.speed)
        if enemy.targetchangetimer < 0 then
            enemy.targetchangetimer = rnd(0.3)+0.5
            enemy.targetx = 80+rnd(16)
            enemy.targety = rnd(96)
        end
        if enemy.shootcooldown < 0 then
            enemy.shootcooldown = 0.6 + rnd(0.6)
            if enemy.x < canshootatx then
                local offsetmissleboss = 2
                if currentwavetime%2 > 1 then offsetmissleboss = 30 end
                addmissile(enemy.x, enemy.y+offsetmissleboss, targetplayer)
                if enemy.health < 11 then
                    sfx(15,2)
                    addbullet(enemy.x,enemy.y+16,(targetplayer.x-enemy.x)/70,(targetplayer.y-enemy.y-16)/70)
                    -- ERROR attempting to find a non existant player
                end
                enemy.speed += 0.001
            end
        end
        enemymisc(enemy)
        enemydie(enemy,21,3,300,true) --death!!!!
    end

    add(enemies, enemy)
end

function addfinalboss() --THE FINAL BOSS!!!!!!! WOOOAAAHHHHHH!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    local enemy = {
        x = 150,
        y = 30,
        w = 32,
        h = 66,
        inv = -1,
        health = 200*#players, --200
        shootcooldown = 4,
        shot = enemyshot,
        collide = enemycollide,
    }
    dramaticdeathtimer = 6
    thrusterexplode = {}
    portaldestabilize = 1
    speed = 1.5
    amount = 3

    --thrusters that each fall off once the portal's health is 1/5th depleated
    function addportalthruster(x,y,id,isflipped)
        local thrusterhealth = id*50*#players-50
        if thrusterhealth < enemy.health or id == 1 then
            local spritethruster = 128
            isflipped = isflipped or 1
            if flashtime then spritethruster = 132 end --animation
            if thrusterhealth > enemy.health - 20 then
                spritethruster += 32
            end
            spr(spritethruster, x, isflipped*(sin(time()*speed)*3.5)+y, 4, 2)
        elseif rnd() < 0.4 then
            addcircle(x+20+rnd(4), y+rnd(6), -0.5, rnd(0.5)-0.25, rnd(7), 1.4, rnd({5,9}))
            if not thrusterexplode[id] then
                thrusterexplode[id] = true
                explosion(x+10,y,32)
                shake = 12
                sfx(4,3) --thruster die!
            end
        end
    end

    function enemy:draw()
        local x,y = enemy.x-8,10+sin(time()*speed+0.2)*2
        if flashtime or enemy.inv < 0 or enemy.health == 0 then
            -- portal
            local ovaly1 = (sin(time()*speed-0.12)*amount/2)+y+24+portaldestabilize
            --local ovaly2 = (-sin(time()*speed-0.12)*amount/2)+y+84
            local ovaly2 = -ovaly1+128-portaldestabilize
            ovalfill(x+28,ovaly1,x+6,ovaly2,14)
            local portalcolors = {11,3}
            for i = 1, 260, 1 do --cool swirling portal effect
                pset(x+17+sin(i/53.3465+t()/8)*i/24+sin(i/350.23548+t())*portaldestabilize, y+54+cos(i/53.3465+t()/8)*i/9,portalcolors[(ceil(i/20))%#portalcolors+1])
            end
            addcircle(x+17, y+54, rnd(0.5)-0.25, rnd(1)-0.5, 5, 2, 11)
            oval(x+28,ovaly1,x+6,ovaly2,11)
        end
        addportalthruster(x-19,y-4,3)
        addportalthruster(x-19,y+97,4,-1)
        local spriteportal = 136
        if enemy.health < 40 then spriteportal = 140 end
        spr(spriteportal, x, (sin(time()*speed)*amount)+y, 4, 3)
        spr(spriteportal, x, (-sin(time()*speed)*amount)+y+85, 4, 3, false,true)
        addportalthruster(x+6,y-4,1)
        addportalthruster(x+6,y+97,2,-1)
        clip(0,0,x+17,128)
    end

    function enemy.update()
        if enemy.health > 0 or dramaticdeathtimer < 0 or gameover then
            enemy.x = lerp(enemy.x, 103, 0.025)--lerps into place
            if enemy.shootcooldown < 0 then
                enemy.shootcooldown = 1
                if #enemies < 2 then
                    for i = 1, 10, 1 do
                        addbullet(110,64, rnd(0.5)-1, rnd(2)-1)
                    end
                    sfx(3,3) --sound for barrage of bullets
                    if rnd() < 0.4 then
                        addmissile(110, 60, targetplayer)
                    end
                end
                if rnd() < 0.4 then
                    addbasicenemy(115,rnd(30)+50,0.4+rnd(0.6))
                elseif rnd() < 0.02 then
                    addtargetingenemy(115, rnd(30)+50, 0.2)
                end
                if flr(currentwavetime%14) == 5 then
                    local moves = {
                        function()
                            if currentwavetime < 20 then
                                addballshooter(110, 56, 0.08)
                            else 
                                addballshooter(110, 40, 0.08)
                                addballshooter(140, 72, 0.08)
                            end
                        end,
                        function()
                            addwallboss(110, 30, 8, 30, 0.05, false, 3, false)
                        end,
                        function()
                            for i = 1, 7, 1 do
                                addwallshooter(100 + (54-i)*i, (i%2==1), 0.4)
                            end
                            addlasershooter(128,48,100,0.2,false,false)
                            addbomb(128, 48, 9)
                        end,
                        function ()
                            for i = 1, 5, 1 do
                                addtargetingenemy(128, i*10+32, 0.085)
                            end
                        end
                    }
                    moves[(currentwavetime\14)%#moves+1]()
                end
            end
            enemydie(enemy,17,2,1000,true) --die!!!!!!!
        else
            finalbossalive = false
            playsong(-1,1000)
            killallenemies()
            despawnallbullets = true
            speed += 0.0003
            amount += 0.02
            portaldestabilize += 0.05
            dramaticdeathtimer -= ft
            if enemy.shootcooldown < 0 then
                enemy.shootcooldown = dramaticdeathtimer/8
                explosion(103+rnd(8), rnd(128),32)
                shake = rnd(10)
                sfx(17,2)
                sfx(21,3)
            end
        end
        if dramaticdeathtimer < 0 then playsong(63,3) end --final big boom
        enemymisc(enemy)
    end

    add(enemies, enemy)
end