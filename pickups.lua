-- local randompickups = {}
-- pickuptimer = 10
-- function randompickups.update()
--     pickuptimer -= ft
--     if pickuptimer < 0 then
--         pickuptimer = 10
--         if rnd(100) > 85 then
--             addpickup(128, rnd(80)+20)
--         end
--     end
-- end
-- function randompickups.draw()
-- end
-- add(obj, randompickups)

function addpickup(x, y, type)
    --if type is "48," then health. otherwise it'll be a rnd powerup
    local pickup = {}
    type = type or rnd({49, 50}) --48 = health / 49 = fastshoot / 50 = 3shoot
    local sprite = type
    
    function pickup.draw()
        spr(sprite, x, y)
    end

    function pickup.collide(player)
        if x+4 >= player.x-4 and x+4 <= player.x+4+player.w and y+4 >= player.y-4 and y+4 <= player.y+player.h+4 and player.health > 0 then
            pickup:affect(player)
            del(obj, pickup)
        end
    end

    function pickup:affect(player)
        local pickupcolor = 8 --health
        if type == 49 then --fastshoot
            player.shootspeed = 0.17
            pickupcolor = 12
        elseif type == 50 then --3shoot
            player.shoot3 = true
            player.shootspeed = 0.4
            pickupcolor = 9
        else
            player.health = 3
        end
        for i = 1, 8, 1 do
            addcircle(x, y, sin(i/8), cos(i/8), 2, 0.6, pickupcolor)
        end
        currentscore+=10 --10 points
        sfx(13, 1)
    end

    function pickup.update()
        x -= 0.3
        y += sin(time()/2)*0.2
        foreach(players, pickup.collide)
        if x < -8 then
            del(obj, pickup)
        end
    end

    add(obj, pickup)
end

--  addpickup(128, 60, 48)
--  addpickup(128, 70)