playercount = -1
players = {}

function addplayer()
    playercount += 1
    local player = {}
    player.health = 3
    player.x = 18
    player.y = 60
    player.w = 8
    player.h = 8
    player.ymov = 0
    player.id = playercount
    player.shootcooldown = 0.0
    player.type = "player"

    function player.draw(player)
        if (player.ymov == 0) then
            spr(2, player.x, player.y)
        elseif (player.ymov == 1) then
            spr(3, player.x, player.y)
        elseif (player.ymov == -1) then
            spr(3, player.x, player.y, 1, 1, false, true)
        end
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

        --shooting
        player.shootcooldown -= 1/60
        if btn(4, player.id) and player.shootcooldown < 0 then
            addbullet(player.x+3, player.y, 2, 0, false)
            player.shootcooldown = 0.1
        end
    end

    add(players, player)
end

addplayer()