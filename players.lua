alwaysfire = false
coopmode = false
players = {}

function addplayer(x, y, sprite, spriteup, spritedwn, bulletsprite)
    local player = {
        health = 3, --3
        x = x,
        y = y,
        w = 8,
        h = 8,
        --sprite = sprite,
        --bulletsprite = bulletsprite,
        ymov = 0,
        inv = 2,
        id = #players,
        shootcooldown = 0.0,
        particlecooldown = 0.0,
        shootspeed = 0.25,
        shoot3 = false
    }
    

    function player:draw()        
        --draw a different sprite when moving
        if (player.ymov == 0) then
            spritelocal = sprite
        elseif (player.ymov == 1) then
            spritelocal = spriteup
        elseif (player.ymov == -1) then
            spritelocal = spritedwn
        end
        --blink when hurt
        if (player.inv < 0 or flashtime) and player.health > 0 then
            spr(spritelocal, player.x, player.y)
        end
    end

    function player.shot()
        --when the player is shot, reduce health and make temporarily invincible
        --also remove any powerups, shake the screen, and spawn an explosion.
        player.health -= 1
        player.inv = 1
        player.shootspeed = 0.25
        player.shoot3 = false
        shake = 9
        sfx(10, 1) --hit, ouch!
        explosion(player.x, player.y)
        if isgameover() then --FUCK, GAME OVER YOU DIED!
            gameover = true -- gameover set to true
            respawntimer = 5 --respawns all players in 5 seconds
            player.inv = 20
            killallenemies()
            currentscore-=10
            sfx(11, 0) --killed
            sfx(22, 1) --rewind beat
        elseif player.health <= 0 then
            currentscore = ceil(currentscore * 0.5) --halves score if coop
            sfx(11, 0)
            player.inv = 5
        end
    end

    function player.respawn()
        player.health = 3
        player.inv = 3
        for i = 1, 8, 1 do
            addcircle(player.x+4, player.y+4, sin(i/8), cos(i/8), 2, 0.6, 7)
        end
        sfx(#players,1) --normal and light respawn sfx for co-op
    end

    function player:update()
        --movement
        if player.health > 0 then -- can only input if alive!!!
            if btn(0, player.id) then
                player.x -= 1
            elseif btn(1, player.id) then
                player.x += 1
            end
            if btn(2, player.id) then
                player.y -= 1
                player.ymov = 1
            elseif btn(3, player.id) then
                player.y += 1
                player.ymov = -1
            else
                player.ymov = 0
            end
        end
        player.x = mid(0, player.x, 120)
        player.y = mid(0, player.y, 120)

        --particles from rockets, and smoke/sparks from damage
        player.particlecooldown -= ft
        if player.particlecooldown < 0 and player.health > 0 then
            for i = 0, 1, 1 do
                addcircle(player.x-1, player.y+i*7, -0.5, 0, 1.5, 0.5, 9)
            end
            -- addcircle(player.x-1, player.y, -0.5, 0, 1.5, 0.5, 9)
            -- addcircle(player.x-1, player.y+7, -0.5, 0, 1.5, 0.5, 9)
            if player.health < 3 then --sparks
                addcircle(player.x+rnd(8), player.y+rnd(8), rnd(1.5)-0.75, -1.5, 1, rnd(1)+0.5, rnd({9,10}), -0.1)
            end
            player.particlecooldown = 0.1
        end
        if player.health == 1 then
            damagesmoke(player)
        end

        --shooting after cooldown
        player.shootcooldown -= ft
        player.inv -= ft
        if (btn(4, player.id) or alwaysfire) and player.shootcooldown < 0 and player.health > 0 then
            --for i = 1, 4, 1 do
                --addcircle(player.x+3, player.y+4, rnd(1)+0.5, rnd(1)-0.5, 1.5, rnd(0.4), 12) 
            --end
            addbullet(player.x+3, player.y, 2, 0, true, bulletsprite)
            if player.shoot3 then
                addbullet(player.x+3, player.y+3, 2, 0.25, true, bulletsprite)
                addbullet(player.x+3, player.y-3, 2, -0.25, true, bulletsprite)
                sfx(12, 2) --3shoot
            else
                sfx(9, 2) --normal shoot
            end
            player.shootcooldown = player.shootspeed
        end
        --reusing the inv timer as a respawn timer when killed
        if player.health <= 0 and player.inv < 0 and not gameover then
            player:respawn()
        end
    end
    add(players, player)
end

function isgameover()
    currentscore+=-10 --lose points if hit
    for i = 1, #players, 1 do
        if players[i].health > 0 then
            return
        end
    end
    return true
end

-- addplayer(16, 18)