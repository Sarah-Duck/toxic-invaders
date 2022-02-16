wave = {} --store wave functions here
currentwave = 8 --THIS IS THE CURRENT WAVE, SHOLD BE 1 UNLESS TESTING SOMETHING
currentwavetime = 0
delaytimer = 0
everysecondtimer = 0
checkpoint = 1
changedmusic = false

wave[1] = {
    delay = 2,
    start = function()
        addbasicenemy(150, 60, 0.15)
    end,
}

for i = 2, 16, 1 do
    wave[i] = {}
end

wave[2] = {
    delay = 2,
    start = function()
        addbasicenemy(128, 30, 0.4)
        addtargetingenemy(128, 60, 0.1)
        addbasicenemy(128, 90, 0.4)
    end,
    conditions = function()
        if #enemies < 2 then return true
        end
    end
}

wave[3] = {
    delay = 2,
    start = function()
        for i = 1, 7, 1 do
            addbasicenemy(128, i*16, 0.5 + 0.075*i)
            addbasicenemy(170, i*16, 1.05 - 0.075*i)
        end
    end,
    conditions = function()
        if #enemies < 5 then return true
        end
    end
}

wave[4] = {
    delay = 0,
    start = function()
        addwallshooter(140, true, 10, 0.4)
        addbasicenemy(128, 30, 0.5)
        addtargetingenemy(155, 60, 0.15)
        addbasicenemy(128, 90, 0.5)
    end,
    conditions = function()
        if #enemies < 2 then return true
        end
    end
}

wave[5] = {
    delay = 2,
    start = function()
        for i = 1, 12, 1 do
            addwallshooter(100 + (54-i)*i, (i%2==1), 10, 0.4)
        end
        addpickup(490, 60, "health")
    end,
    everysecond = function()
        if flr(currentwavetime%3) == 2 and currentwavetime < 16 then
            for i = 1, currentwavetime/4, 1 do
                addbasicenemy(128+rnd(20), rnd(100)+10, 0.6) 
            end
        end
    end,
    conditions = function()
        if #enemies < 2 and currentwavetime > 12 then return true
        end
    end
}

wave[6] = {
    delay = 0,
    start = function()
        addballshooter(128, 56, 0.1)
        addballshooter(160, 14, 0.1)
        addballshooter(160, 100, 0.1)
    end,
}

wave[7] = {
    delay = 1,
    start = function()
        addballshooter(140, 56, 0.2)
        addwallshooter(120, true, 10, 0.3)
        addwallshooter(220, true, 10, 0.3)
        addbasicenemy(128, 30, 0.5)
        addbasicenemy(128, 110, 0.5)
        addbasicenemy(140, 30, 0.2)
        addbasicenemy(140, 110, 0.2)
    end,
}

wave[8] = {
    delay = 1,
    start = function()
        music(9, 0, 3)
        changedmusic = true
        addbasicenemy(240, 58, 1.1)
        addbasicenemy(240, 68, 0.9)
        addbasicenemy(240, 63, 1)
        addlasershooter(128, 64, 0.4, true)
        
    end,
    everysecond = function()
        if flr(currentwavetime%3) == 2 and rnd(100) < 40 then
            for i = 1, rnd(2), 1 do
                addbasicenemy(128+rnd(20), rnd(20)+54, 0.6) 
            end
        end
    end,
    conditions = function()
        if #enemies < 1 then checkpoint = currentwave+1 return true
        end
    end
}

wave[9] = {
    delay = 5,
    start = function()
        addtargetingenemy(128,1,0.1)
        addtargetingenemy(262,60,0.2)
        addwallshooter(138, true, 10, 0.4, 0)
        addwallshooter(144, true, 10, 0.4, 0)
        addwallshooter(185, false, 10, 0.4, 0)
        addwallshooter(230, true, 10, 0.4)
        addballshooter(230, 56, 0.2)
    end,
    conditions = function()
        if #enemies < 2 then return true
        end
    end
}

wave[10] = {
    delay = 3,
    start = function()
        for i = 1, 7, 1 do
            addtargetingenemy(128, i*16-4, 0.1)
        end
    end,
    conditions = function()
        if #enemies < 2 then return true
        end
    end
}

wave[11] = {
    delay = 1,
    start = function()
        for i = 1, 3, 1 do
            addwallshooter(128+i*65, true, 10, 0.4, 0, 0.68)
            addwallshooter(128+i*65, false, 10, 0.4, 0, 0.68)
        end
        addballshooter(200, 56, 0.2)
    end,
}

wave[12] = {
    delay = 1,
    start = function()
        music(9, 0, 3)
        changedmusic = true
        addwallboss(128,4,15,0.05,true)
    end,
    everysecond = wave[8].everysecond,
    conditions = wave[8].conditions
}

wave[13] = {
    delay = 5,
    start = function()
        addbasicenemy(130, 58, 0.6)
        addbasicenemy(130, 68, 0.5)
        addbasicenemy(130, 63, 0.7)
        addlasershooter(128, -2, 0.1, false)
        addbomb(128,46, 0)
        addlasershooter(128, 128-38, 0.1, false)
    end,
    everysecond = wave[8].everysecond,
}

wave[14] = {
    delay = 0,
    start = function()
        addbomb(140,46, 4)
        addtargetingenemy(140, 60-8, 0.2)
        addtargetingenemy(140, 60+8, 0.2)
        addballshooter(128, 14, 0.03)
        addballshooter(128, 100, 0.03)
    end,
}

wave[15] = {
    delay = 0,
    start = wave[5].start,
    everysecond = function()
        if currentwavetime%5 > 4 and currentwavetime < 20 then
            addbomb(128,20+currentwavetime*2,0)
        end
        if currentwavetime > 18 and not changedmusic then
            music(8, 0, 3)
            changedmusic = true
        end
        addbasicenemy(128,rnd(100)+14,0.4+rnd(0.4))
    end,
    conditions = function()
        if currentwavetime > 24 then return true
        end
    end
}

wave[16] = {
    delay = 0,
    start = function()
        for i = 1, #enemies, 1 do
            enemies[i].health = 0
        end
        addmissileboss(128, 0)
    end,
    everysecond = wave[8].everysecond,
}

--wave[currentwave].start()
--music(0, 0, 3)

function updatewaves()
    currentwavetime += 1/60
    everysecondtimer += 1/60
    if everysecondtimer >= 1 then
        everysecondtimer = 0
        if wave[currentwave].everysecond then
            wave[currentwave].everysecond()
        end
    end
    if (wave[currentwave].conditions and wave[currentwave].conditions() or #enemies < 1) then
        delaytimer += 1/60
        if delaytimer > wave[min(currentwave+1, #wave)].delay then
            if changedmusic and currentwave ~= 15 then
                music(0, 0, 3)
                changedmusic = false
            end
            everysecondtimer = 0
            currentwave += 1
            currentwavetime = 0
            delaytimer = 0
            currentwave = (currentwave - 1) % #wave+1 --temporarily looping the waves
            if currentwave < checkpoint then
                checkpoint = 1
            end
            wave[currentwave].start()
        end
    end
end

function setwave(num)
    everysecondtimer = 0
    currentwave = num
    currentwavetime = 0
    delaytimer = 0
    wave[currentwave].start()
    if changedmusic then
        music(0, 0, 3)
    end
end