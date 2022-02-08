bgcircles = {}

function scrollingcircles(y, speed, spacing, radius, color)
    for i = 1, (128*(radius*4))/spacing, 1 do
        circfill(-time()*speed+(spacing*(i-1)), y, radius, color)
    end
end

function scrollingsprite(sprite,x,y,w,h,speed,flip)
    flip = flip or false
    spr(sprite, (-t()*speed+x+w*8)%(128+w*8)-w*8, y, w, h, flip)
end


function addbgcircle(x, y, velx, r, color, pos)
    local circle = {}
    circle.x = x
    circle.y = y
    circle.velx = velx
    circle.r = r
    circle.color = color

    function circle.draw(circle)
        circle.x += circle.velx

        if circle.x < 0 - circle.r * 2 then
            del(bgcircles, circle)
        end
        circfill(circle.x,circle.y,circle.r,circle.color)
    end
    add(bgcircles,circle, pos)
end

function drawbg()
    cls(0)
    camera((sin(shake+t())*shake)/3, (sin(shake+t()/2.1)*shake)/3)

    --stars
    for i = 1, 64, 1 do
        pset(((-t()+i*2)*(i/32))%128, sin(i*0.536382)*64+64, 4)
    end

    --ringed planet
    palt(0,false)
    spr(201,130-t(),76,7,3)
    spr(249,122-t(),100,7,1)
    palt(0,true)
    
    --clouds
    scrollingcircles(-9, 24, 22, 22, 4)
    scrollingcircles(-14, 40, 25, 20, 2)
    --sprites
    --small clouds
    scrollingsprite(198, 20, 10, 1, 1, 28)
    scrollingsprite(214, 60, 10, 1, 1, 28)
    scrollingsprite(198, 100, 10, 1, 1, 28)
    scrollingsprite(214, 120, 10, 1, 1, 28)
    scrollingsprite(214, 130, 12, 1, 1, 29)
    scrollingsprite(198, 145, 15, 1, 1, 30)
    scrollingsprite(214, 160, 15, 1, 1, 30)
    scrollingsprite(198, 170, 15, 1, 1, 30)

    --large clouds
    scrollingsprite(196, 40, 3, 2, 1, 35)
    scrollingsprite(194, 80, 3, 2, 1, 35)
    scrollingsprite(212, 120, 5, 2, 1, 36)
    scrollingsprite(210, 160, 5, 2, 1, 36)
    scrollingsprite(210, 180, 10, 2, 1, 38)
    scrollingsprite(210, 240, 10, 2, 1, 38)
    scrollingsprite(210, 260, 10, 2, 1, 38)


    camera((sin(shake+t())*shake)/2, (sin(shake+t()/2.1)*shake)/2)
    --landscape
    scrollingcircles(125, 72, 25, 20, 8)
    --scrolling sprites
    --pine trees
    scrollingsprite(231,20,77+16,2,2,72,true)
    scrollingsprite(231,70,78+16,2,2,72)
    scrollingsprite(231,80,78+16,2,2,72)
    scrollingsprite(231,100,79+16,2,2,72)
    scrollingsprite(231,120,80+16,2,2,72,true)
    --small buildings
    scrollingsprite(226,15,80+16,2,2,78)
    scrollingsprite(226,65,80+16,2,2,78)
    scrollingsprite(226,95,80+16,2,2,78)
    scrollingsprite(226,115,80+16,2,2,78)
    --totem poles
    scrollingsprite(230,25,83+16,1,2,82)
    scrollingsprite(230,65,84+16,1,2,82)
    scrollingsprite(230,85,85+16,1,2,82)
    --dead trees
    scrollingsprite(228,30,85+16,2,2,84)
    scrollingsprite(228,75,86+16,2,2,84,true)
    scrollingsprite(228,100,87+16,2,2,84)
    scrollingsprite(228,120,88+16,2,2,84,true)
    --large buildings (front)
    scrollingsprite(192,55,94,2,4,90)
    scrollingsprite(192,20,91,2,4,90)
    scrollingsprite(192,100,90,2,4,90)
    scrollingsprite(192,130,92,2,4,90)


    camera(sin(shake+t())*shake, sin(shake+t()/2.1)*shake)
    scrollingcircles(154, 100, 30, 32, 2)
end