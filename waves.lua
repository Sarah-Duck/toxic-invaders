wave = {} --store wave functions here
currentwave = 1 --THIS IS THE CURRENT WAVE
currentwavetime = 0
delaytimer = 0
everysecondtimer = 0

wave[1] = {
    delay = 2,
    start = function()
        addbasicenemy(130, 60, rnd(basicenemysprites), 1, 0.15)
    end,
    everysecond = function()
    end,
    conditions = function()
        if #enemies < 1 then
            return true
        else
            return false
        end
    end
}

wave[2] = {
    delay = 2,
    start = function()
        addbasicenemy(128, 30, rnd(basicenemysprites), 1, 0.4)
        addbasicenemy(128, 60, rnd(basicenemysprites), 1, 0.8)
        addbasicenemy(128, 90, rnd(basicenemysprites), 1, 0.4)
    end,
    everysecond = function()
    end,
    conditions = function()
        if #enemies < 1 then
            return true
        else
            return false
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
        if #enemies < 1 then
            return true
        else
            return false
        end
    end
}

wave[4] = {
    delay = 0,
    start = function()
        addwallshooter(130, true, 10, 0.7)
    end,
    everysecond = function()
    end,
    conditions = function()
        if #enemies < 1 then
            return true
        else
            return false
        end
    end
}

wave[4] = {
    delay = 0,
    start = function()
        addwallshooter(140, true, 10, 0.4)
        addbasicenemy(128, 30, rnd(basicenemysprites), 1, 0.5)
        addbasicenemy(155, 60, rnd(basicenemysprites), 1, 0.4)
        addbasicenemy(128, 90, rnd(basicenemysprites), 1, 0.5)
    end,
    everysecond = function()
    end,
    conditions = function()
        if #enemies < 1 then
            return true
        else
            return false
        end
    end
}

wave[5] = {
    delay = 0,
    start = function()
        for i = 1, 10, 1 do
            addwallshooter(100 + (50-i)*i, (i%2==1), 10, 0.4)
        end
        addpickup(420, 60, "health")
    end,
    everysecond = function()
        if flr(currentwavetime%3) == 2 and currentwavetime < 14 then
            addbasicenemy(128, rnd(100)+10, rnd(basicenemysprites), 1, 0.6)
        end
    end,
    conditions = function()
        if #enemies < 1 then
            return true
        else
            return false
        end
    end
}

wave[currentwave].start()

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
            currentwave += 1
            currentwavetime = 0
            delaytimer = 0
            currentwave = (currentwave - 1) % #wave+1 --temporarily looping the waves
            wave[currentwave].start()
        end
    end
end