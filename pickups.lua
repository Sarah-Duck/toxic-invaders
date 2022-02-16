local randompickups = {}
pickuptimer = 10
function randompickups.update()
    pickuptimer -= ft
    if pickuptimer < 0 then
        pickuptimer = 10
        if rnd(100) > 85 then
            addpickup(128, rnd(80)+20)
        end
    end
end
function randompickups.draw()
end
add(obj, randompickups)

function addpickup(x, y, type)
    local pickup = {}
    x = x
    y = y
    type = type or rnd({"health", "health", "fastshoot", "3shoot"})
    sprite = 4

    if type == "fastshoot" then
        sprite = 20
    elseif type == "3shoot" then
        sprite = 36
    end

    function pickup.collide(player)
        if x+4 >= player.x-4 and x+4 <= player.x+4+player.w and y+4 >= player.y-4 and y+4 <= player.y+player.h+4 and player.health > 0 then
            pickup:affect(player)
            for i = 1, 8, 1 do
                local color = 8
                if type == "fastshoot" then
                    color = 12
                elseif type == "3shoot" then
                    color = 9
                end
                addcircle(x, y, sin(i/8), cos(i/8), 2, 0.6, color)
            end
            del(obj, pickup)
        end
    end

    function pickup:affect(player)
        if type == "health" then
            player.health = 3
        elseif type == "fastshoot" then
            player.shootspeed = 0.1
        elseif type == "3shoot" then
            player.shoot3 = true
        end
        sfx(30, 1)
    end

    function pickup.draw(pickup)
        spr(sprite, x, y)
    end

    function pickup.update(pickup)
        x -= 0.3
        y += sin(time()/2)*0.2
        foreach(players, pickup.collide)
        if x < -8 then
            del(obj, pickup)
        end
    end

    add(obj, pickup)
end

 --addpickup(120, 60)