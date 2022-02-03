obj = {}

function updateobjs()
    foreach(players, function(obj) obj:update() end)
    foreach(obj, function(obj) obj:update() end)
end

function drawobjs()
    foreach(obj, function(obj) obj:draw() end)
    foreach(players, function(obj) obj:draw() end)
end