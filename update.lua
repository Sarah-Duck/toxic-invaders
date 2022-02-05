updateobjs()
--screenshake math
shake = shake + 0.11 * (0 - shake);
if shake < 1 then
    shake = 0
end
--add another player if they fire
if btn(4, 1) and playercount == 0 then
    addplayer(32, 35)
end