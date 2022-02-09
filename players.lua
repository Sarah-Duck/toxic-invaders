playercount = -1
players = {}

function addplayer(sprite, bulletsprite)
    playercount += 1
    local player = {}
    player.health = 3
    player.x = 18
    player.y = 60
    player.w = 8
    player.h = 8
    player.sprite = sprite
    player.bulletsprite = bulletsprite
    player.ymov = 0
    player.inv = -1
    player.id = playercount
    player.shootcooldown = 0.0
    player.particlecooldown = 0.0
    player.shootspeed = 0.25
    player.shoot3 = false

    function player.draw(player)
        print(player.health)
        --draw a different sprite when moving, and blink when hurt
        if player.inv < 0 or ceil(player.inv*10%2) == 1 then
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
    end

    function player.update(player)
        --movement
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
        player.x = mid(0, player.x, 120)
        player.y = mid(0, player.y, 120)

        --particles from rockets, and smoke/sparks from damage
        player.particlecooldown -= 1/60
        if player.particlecooldown < 0 then
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
        if btn(4, player.id) and player.shootcooldown < 0 then
            --for i = 1, 4, 1 do
                --addcircle(player.x+3, player.y+4, rnd(1)+0.5, rnd(1)-0.5, 1.5, rnd(0.4), 12) 
            --end
            addbullet(player.x+3, player.y, 2, 0, false, player.bulletsprite)
            sfx(9)
            if player.shoot3 then
                addbullet(player.x+3, player.y+3, 2, 0.25, false, player.bulletsprite)
                addbullet(player.x+3, player.y-3, 2, -0.25, false, player.bulletsprite)
            end
            player.shootcooldown = player.shootspeed
        end
    end

    add(players, player)
end

addplayer(16, 18)