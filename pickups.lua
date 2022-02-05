local randompickups = {}
pickuptimer = 10
function randompickups.update()
    pickuptimer -= 1/60
    if (pickuptimer < 0) then
        pickuptimer = 10
        if rnd(100) > 93 then
            addpickup(128, rnd(80)+20)
        end
    end
end
function randompickups.draw()
end
add(obj, randompickups)

function addpickup(x, y, type)
    local pickup = {}
    pickup.x = x
    pickup.y = y
    pickup.type = type or rnd({"health", "fastshoot", "3shoot"})
    pickup.sprite = 5

    if (pickup.type == "fastshoot") then
        pickup.sprite = 21
    elseif (pickup.type == "3shoot") then
        pickup.sprite = 37
    end

    function pickup.collide(player)
        if pickup.x+4 >= player.x-4 and pickup.x+4 <= player.x+4+player.w and pickup.y+4 >= player.y-4 and pickup.y+4 <= player.y+player.h+4 then
            pickup:affect(player)
            for i = 1, 8, 1 do
                local color = 8
                if (pickup.type == "fastshoot") then
                    color = 12
                elseif (pickup.type == "3shoot") then
                    color = 9
                end
                addcircle(pickup.x, pickup.y, sin(i/8), cos(i/8), 2, 0.6, color, 0)
            end
            del(obj, pickup)
        end
    end

    function pickup.affect(pickup, player)
        if pickup.type == "health" then
            player.health = 3
        elseif pickup.type == "fastshoot" then
            player.shootspeed = 0.1
        elseif pickup.type == "3shoot" then
            player.shoot3 = true
        end
    end

    function pickup.draw(pickup)
        spr(pickup.sprite, pickup.x, pickup.y)
    end

    function pickup.update(pickup)
        pickup.x -= 0.3
        pickup.y += sin(time()/2)*0.2
        foreach(players, pickup.collide)
        if pickup.x < -8 then
            del(obj, pickup)
        end
    end

    add(obj, pickup)
end

addpickup(120, 60)