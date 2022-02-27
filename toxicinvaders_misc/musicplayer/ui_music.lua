function printdropshadow(text,x,y,colorMain,colorShadow)
    print(text,x,y+1,colorShadow)
    print(text,x,y,colorMain)
end

function invaderslogotext(x,y)
    --default values
    -- x = 12
    -- y = 20

    invaderstext = "I N V A D E R S"
    for i = 1, 12, 1 do
        print(invaderstext, x+i%3-1, y+i%4-1, 3)
    end
    print(invaderstext,x,y,14)
    clip(x, y, 63, 3)
    print(invaderstext,x,y,11)
    clip()

    soundtracktext = "the soundtrack"
    for i = 1, 12, 1 do
        print(soundtracktext, x+i%3+1, y+i%4+9, 2)
    end
    print(soundtracktext,x+2,y+10,10)
    clip(x+2, y+9, 69, 3)
    print(soundtracktext,x+2,y+10,9)
    clip()
end

function drawlogo(x,y)
    --default values
    -- x = 24
    -- y = 26

    sspr(88,88,16,8,x-3,y+2,32,16) --to shadow
    sspr(88,88,16,8,x-3,y,32,16) --to
    sspr(120,88,8,8,x+55,y+2,16,16) --ic shadow
    sspr(120,88,8,8,x+55,y,16,16) --ic
    --X
    sspr(104,88,8,8,x+26,y-9,16,16)
    sspr(104,88,8,8,x+42,y-9,16,16,true)
    sspr(112,88,8,8,x+26,y+7,16,16,true)
    sspr(112,88,8,8,x+42,y+7,16,16)
    --invaders
    invaderslogotext(x+11,y+20)
end

function mainmenutext(x,y,currentlyplaying)
    -- default values
    -- x = 24
    -- y = 62
    x -= 1

    printdropshadow("(\139) track selection (\145)",x,y,9,2)

    poke(0x5f58, 0x9 | 0x4) --makes score BIG
    printdropshadow("iDLE iNERTIA         bATTLE bEATS         pADRONE pANIC         fISSURE fINALE         vICTORY vESSLE",x-tracktitleposition+circletimex,y+18+circletimey,11,3)
    poke(0x5f58)
end

function credits(x,y)
    -- default vaues
    -- x = 10
    -- y = 100
    sintimecredits = sin(t())*2
    timemodcredits = (t()%2<1)

    palt(2,true)
    palt(0,false)
    spr(186,x,y+sintimecredits,1,1,timemodcredits) --duck
    palt()
    printdropshadow("1029chris",x+11,y+2,9,2)
end

--intro/ending acid effect
function acidtransition()
    if acidcounter < 3 then
        for i = 1, 128, 1 do
            line(i-1,128,i-1,sin((i+0.22-acidcounter*20)/24.357)*2+acidcounter*80-5,11) --cool wavy transition effect!!!!
            line(i-1,128,i-1,sin((i+acidcounter*60)/44.357)*5+acidcounter*80,3)
        end
        addcircle(rnd(128), acidcounter*80+5, 0,rnd(1),rnd(12)+2,1.5,14)
    end
end

--sfx for the intro transition
sfx(0,3,3)

menuitem(1, "(\152) hide ui", function() hideui = not hideui end)
menuitem(3, "(❎ ⁙ 🅾️) to end", function() music(-1,3000,3) end)