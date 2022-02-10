playercount = -1
alwaysfire = false
players = {}

function addplayer(x, y, sprite, bulletsprite)
    playercount += 1
    local player = {}
    player.health = 3
    player.x = x
    player.y = y
    player.w = 8
    player.h = 8
    player.sprite = sprite
    player.bulletsprite = bulletsprite
    player.ymov = 0
    player.inv = 2
    player.id = playercount
    player.shootcooldown = 0.0
    player.particlecooldown = 0.0
    player.shootspeed = 0.25
    player.shoot3 = false

    function player.draw(player)
        -- print(player.health)
        
        --draw a different sprite when moving, and blink when hurt
        if (player.inv < 0 or ceil(player.inv*10%2) == 1) and player.health > 0 then
            if (player.ymov == 0) then
                spr(player.sprite, player.x, player.y)
            elseif (player.ymov == 1) then
                spr(player.sprite+1, player.x, player.y)
            elseif (player.ymov == -1) then
                spr(player.sprite+1, player.x, player.y, 1, 1, false, true)
            end
        end
    end

    function player.shot(player)
        --when the player is shot, reduce health and make temporarily invincible
        --also remove any powerups, shake the screen, and spawn an explosion.
        player.health -= 1
        player.inv = 1
        player.shootspeed = 0.25
        player.shoot3 = false
        shake = 9
        sfx(10)
        explosion(player.x, player.y)
        if isgameover() then --FUCK, GAME OVER YOU DIED!
            gameover = true -- gameover set to true
            respawntimer = 5 --respawns all players in 5 seconds
            player.inv = 20
            for i = 1, #enemies, 1 do
                enemies[i].health = -1
            end
            sfx(29, 1)
        elseif player.health <= 0 then
            player.inv = 5
        end
    end

    function player.respawn(player)
        player.health = 3
        player.inv = 3
        for i = 1, 8, 1 do
            addcircle(player.x+4, player.y+4, sin(i/8), cos(i/8), 2, 0.6, 7, 0)
        end
    end

    function player.update(player)
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
        player.particlecooldown -= 1/60
        if player.particlecooldown < 0 and player.health > 0 then
            addcircle(player.x-1, player.y, -0.5, 0, 1.5, 0.5, 9, 0)
            addcircle(player.x-1, player.y+7, -0.5, 0, 1.5, 0.5, 9, 0)
            if player.health < 3 then
                addcircle(player.x+rnd(8), player.y+rnd(8), -0.5, -0.2, rnd(8), rnd(1.5)+1, 5, 0)
                if player.health < 2 then
                    addcircle(player.x+rnd(8), player.y+rnd(8), rnd(1.5)-0.75, -1.5, 1, rnd(1)+0.5, 9, -0.1)
                    if ceil(rnd(2)) == 1 then
                        addcircle(player.x+rnd(8), player.y+rnd(8), -0.4, -0.2, rnd(8), rnd(1)+0.5, 9, 0)
                    end
                end
            end
            player.particlecooldown = 0.1
        end

        --shooting after cooldown
        player.shootcooldown -= 1/60
        player.inv -= 1/60
        if (btn(4, player.id) or alwaysfire) and player.shootcooldown < 0 and player.health > 0 then
            --for i = 1, 4, 1 do
                --addcircle(player.x+3, player.y+4, rnd(1)+0.5, rnd(1)-0.5, 1.5, rnd(0.4), 12) 
            --end
            addbullet(player.x+3, player.y, 2, 0, false, player.bulletsprite)
            if player.shoot3 then
                addbullet(player.x+3, player.y+3, 2, 0.25, false, player.bulletsprite)
                addbullet(player.x+3, player.y-3, 2, -0.25, false, player.bulletsprite)
                sfx(12)
            else
                sfx(9)
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
    for i = 1, #players, 1 do
        if players[i].health > 0 then
            return false
        end
    end
    return true
end

-- addplayer(16, 18)