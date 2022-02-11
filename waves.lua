wave = {} --store wave functions here
currentwave = 1 --THIS IS THE CURRENT WAVE, SHOLD BE 1 UNLESS TESTING SOMETHING
currentwavetime = 0
delaytimer = 0
everysecondtimer = 0

wave[1] = {
    delay = 2,
    start = function()
        addbasicenemy(150, 60, rnd(basicenemysprites), 1, 0.15)
    end,
    everysecond = function()
    end,
    conditions = function()
        if #enemies < 1 then return true else return false
        end
    end
}

wave[2] = {
    delay = 2,
    start = function()
        addbasicenemy(128, 30, rnd(basicenemysprites), 1, 0.4)
        addtargetingenemy(128, 60, 3, 0.1)
        addbasicenemy(128, 90, rnd(basicenemysprites), 1, 0.4)
    end,
    everysecond = function()
    end,
    conditions = function()
        if #enemies < 2 then return true else return false
        end
    end
}

wave[3] = {
    delay = 2,
    start = function()
        for i = 1, 7, 1 do
            addbasicenemy(128, i*16, rnd(basicenemysprites), 1, 0.5 + 0.075*i)
            addbasicenemy(170, i*16, rnd(basicenemysprites), 1, 1.05 - 0.075*i)
        end
    end,
    everysecond = function()
    end,
    conditions = function()
        if #enemies < 5 then return true else return false
        end
    end
}

wave[4] = {
    delay = 0,
    start = function()
        addwallshooter(140, true, 10, 0.4)
        addbasicenemy(128, 30, rnd(basicenemysprites), 1, 0.5)
        addtargetingenemy(155, 60, 3, 0.15)
        addbasicenemy(128, 90, rnd(basicenemysprites), 1, 0.5)
    end,
    everysecond = function()
    end,
    conditions = function()
        if #enemies < 2 then return true else return false
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
                addbasicenemy(128+rnd(20), rnd(100)+10, rnd(basicenemysprites), 1, 0.6) 
            end
        end
    end,
    conditions = function()
        if #enemies < 2 and currentwavetime > 12 then return true else return false
        end
    end
}

wave[6] = {
    delay = 0,
    start = function()
        addballshooter(128, 56, 12, 0.1)
        addballshooter(160, 14, 12, 0.1)
        addballshooter(160, 100, 12, 0.1)
    end,
    everysecond = function()
    end,
    conditions = function()
        if #enemies < 1 then return true else return false
        end
    end
}

wave[7] = {
    delay = 1,
    start = function()
        addballshooter(140, 56, 12, 0.2)
        addwallshooter(120, true, 10, 0.3)
        addwallshooter(220, true, 10, 0.3)
        addbasicenemy(128, 30, rnd(basicenemysprites), 1, 0.5)
        addbasicenemy(128, 110, rnd(basicenemysprites), 1, 0.5)
        addbasicenemy(140, 30, rnd(basicenemysprites), 1, 0.2)
        addbasicenemy(140, 110, rnd(basicenemysprites), 1, 0.2)
    end,
    everysecond = function()
    end,
    conditions = function()
        if #enemies < 2 then return true else return false
        end
    end
}

wave[8] = {
    delay = 1,
    start = function()
        addtargetingenemy(128,1,3,0.1)
        addtargetingenemy(262,60,3,0.2)
        addwallshooter(138, true, 10, 0.4, 0)
        addwallshooter(144, true, 10, 0.4, 0)
        addwallshooter(185, false, 10, 0.4, 0)
        addwallshooter(230, true, 10, 0.4)
        addballshooter(230, 56, 12, 0.2)
    end,
    everysecond = function()
    end,
    conditions = function()
        if #enemies < 2 then return true else return false
        end
    end
}

wave[9] = {
    delay = 3,
    start = function()
        for i = 1, 7, 1 do
            addtargetingenemy(128, i*16-4, 3, 0.1)
        end
    end,
    everysecond = function()
    end,
    conditions = function()
        if #enemies < 2 then return true else return false
        end
    end
}

wave[10] = {
    delay = 1,
    start = function()
        for i = 1, 3, 1 do
            addwallshooter(128+i*65, true, 10, 0.4, 0, 0.68)
            addwallshooter(133+i*65, false, 10, 0.4, 0, 0.68)
        end
        addballshooter(200, 56, 12, 0.2)
    end,
    everysecond = function()
    end,
    conditions = function()
        if #enemies < 1 then return true else return false
        end
    end
}

--wave[currentwave].start()
--music(0, 0, 3)

function updatewaves()
    currentwavetime += 1/60
    everysecondtimer += 1/60
    if everysecondtimer >= 1 then
        everysecondtimer = 0
        wave[currentwave].everysecond()
    end
    if wave[currentwave].conditions() then
        delaytimer += 1/60
        if delaytimer > wave[currentwave].delay then
            everysecondtimer = 0
            currentwave += 1
            currentwavetime = 0
            delaytimer = 0
            currentwave = (currentwave - 1) % #wave+1 --temporarily looping the waves
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
end