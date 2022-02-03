enemies = {}

function addbasicenemy(x, y, sprite, health)
    local enemy = {}
    enemy.x = x
    enemy.y = y
    enemy.w = 8
    enemy.h = 8
    enemy.inv = -1
    enemy.sprite = sprite
    enemy.health = health
    enemy.shootcooldown = 3

    function enemy.draw(enemy)
        spr(enemy.sprite, enemy.x, enemy.y, 1,1)
    end

    function enemy.shot(enemy)
        --explode
        for i = 1, 4, 1 do
            addcircle(enemy.x+rnd(8), enemy.y+rnd(8), -0.5, 0, rnd(8), rnd(1.5)+1, 5)
        end
        for i = 1, 4, 1 do
            addcircle(enemy.x+rnd(8), enemy.y+rnd(8), -0.4, 0, rnd(8), rnd(1)+0.5, 9)
        end
        --and reduce health
        enemy.health -= 1
        if enemy.health <= 0 then
            del(enemies, enemy)
        end
    end

    function enemy.update()
        enemy.x -= 0.1
        enemy.y += sin(time()/5)*0.1
        enemy.shootcooldown -= 1/60
        if enemy.shootcooldown < 0 then
            enemy.shootcooldown = 0.5 + rnd(2)
            addbullet(enemy.x-3, enemy.y, -1, 0, true, 38)
        end
        if enemy.x < -8 then
            del(enemies, enemy)
        end
    end

    add(enemies, enemy)
end

addbasicenemy(128, 60, 9, 1)
addbasicenemy(128, 90, 9, 1)
addbasicenemy(128, 20, 9, 1)
