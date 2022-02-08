pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
#include objects.lua
#include particles.lua
#include players.lua
#include enemies.lua
#include bullets.lua
#include pickups.lua
#include waves.lua

function _update60()
#include update.lua
end

function _draw()
#include background.lua
#include draw.lua
end
__gfx__
00000000000000000000000000bbbb00577777750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000b7777b07778877700000000000000000000000000000000000000000000000000000000000000000000000073bb330000000000
00700700003b3300000bb000b77b777b777887770000000000000000000000000000000000000000000000000000000000000000000000000b33bbb973bbb300
0007700000bbb00000b77b00b77bbb7b78888887000000000000000000000000000000000000000000000000000000000000000000000000b3bbbbb9b3bb3b39
00077000007b700000b77b00b7bbb77b72288227000000000000000000000000000000000000000000000000000000000000000000000000b3bb3b30b3bbbbb9
0070070000030300000bb000b777b77b77788777000000000000000000000000000000000000000000000000000000000000000000000000b3bbbbb90b33bbb9
0000000000000000000000000b7777b0777227770000000000000000000000000000000000000000000000000000000000000000000000000b33bbb973bb3300
00000000000000000000000000bbbb005777777500000000000000000000000000000000000000000000000000000000000000000000000073bb330000000000
9ccc1cc7000000000000000000cccc00577777750000000000000000000000000000000000000000000000000000000000000000000000007bbbbb3000000000
0cccc1009ccc1cc7000000000c7777c07c77c7770000000000000000000000000000000000000000000000000000000000000000000000000003bbb97bb33b30
01ccccc00cc11110000cc000c77c777c7cc7cc7700000000000000000000000000000000000000000000000000000000000000000000000000003bb9003bb3b9
00c111cc01c111cc00c77c00c77ccc7c7cccccc7000000000000000000000000000000000000000000000000000000000000000000000000003bb3b0003bb3b9
00c111cc01cccccc00c77c00c7ccc77c7cc1cc17000000000000000000000000000000000000000000000000000000000000000000000000003bb3b000003bb9
01ccccc00cccc110000cc000c777c77c7c17c17700000000000000000000000000000000000000000000000000000000000000000000000000003bb90003bbb9
0cccc1009ccc1cc7000000000c7777c0717717770000000000000000000000000000000000000000000000000000000000000000000000000003bbb97bbbbb30
9ccc1cc7000000000000000000cccc00577777750000000000000000000000000000000000000000000000000000000000000000000000007bbbbb3000000000
9aaa4aa700000000000000000099990057777775003bb300000000000b0000007e33e3ee33bee33bbee3e3e3e3eea00000033000000330000000000000000000
0aaaa4009aaa4aa7000000000977779077999a7703bbbbb3b900b339b30000b36ebebe3ebebebebee33bebebeb3300009b9b9b9999b9b9b9003bbbb900000000
04aaaaa00aa444a000099000977977797999a777bbb333333bbb000033000b3303eeeee3333333333eeeeeee00000000000330000003300003bbb30003bbbbb9
00a444aa04a444aa0097790097799979799999a77b3bbbbbb3b3b9003300b33300bebebebebebebeb3300bebe3b3b33a0bbbbbb00bbbbbb07b3b30007b3b3300
00a444aa04aaaaaa009779009799977977779a777b3bbbbbb3b3b900330b3333006eeee33eeeeee33000003ee3e3e33a03b3bb3003b3bb307b3b30007bbbb300
04aaaaa00aaaa44000099000977797797779a777bbb333333bbb0000030333330073beb33ebe03beeeea0000000000000033b3000033b30003bbb300033bbbb9
0aaaa4009aaa4aa70000000009777790777a777703bbbbb3b900b33900033330000763eeee30003ebeba000000000000000bb000000bb000003bbbb900000000
9aaa4aa700000000000000000099990057777775003bb30000000000000033000000006776000000000000000000000000077000000770000000000000000000
00003333333333333333333300a00000a9a000000000000000000000000000007b33b3bb33ebe33bebe3b3b3b3bb900000077000000770000000000000000000
00003bbbbb3bbbb33b3bbbb30a9a0000999a00000000000000000000000000006ebbbe3bebebebebe33ebebbee3300000b0b30b00b0b30b0003bbb3000003300
0000333b333b33b33b3b3333a999a000a999a000003bb300000000000000000003bebbe3333333333ebbbbbe000000000b3b3bb00b3b3bb07bbb33b97bb3bb39
0000003b303b33b33b3b30000a999a000aaaaa0000bbbbb3b3b3b3b3b3b3b3b300bbbbbbbbbbbebbb3300ebbebebeee903b33b3003b33b300003bbb00003bbb0
0000003e303e33e33e3e300000a999a000a999a0007b7bb3b3b3b3b3b3b3b3b0006bbbb33bebbebee000003bebebeee90bbbbbb00bbbbbb00003bbb07bbb33b9
0000003b303b33b33b3b3333000a999a000aaaaa00bbbb3003003003003003000073ebb33bbb03bbbee900000000000033333333333333337bbb33b9003bbb30
0000003e303eeee33e3eeee30000a9990000a9a0000300300300300300300300000763ebbe30003ebee9000000000000b3b3b3b33b3b3b3b003bbb3000000000
00000033303333333333333300000a9a00000a00000030030030030030030030000000677600000000000000000000003b3b3b3bb3b3b3b30000000000000000
3bbbbbbbbbbbbbbbbbbbbe3300000000003bbbbbbbbbbbbb30000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbeebbebebbbe33eeee9a07bbbbbbbbbbbbbbb3000000000000000000000000000000000000000000000000000000000000000000000000000000
be3ebe3ebe3ebbbbbbbbbbbbbe3e3e9907bb3b3b3bbbbbbbb3000000000000000000000000000000000000000000000000000000000000000000000000000000
b33eb33eb33ebe33333333ebbbb33e9907bb3b3b3bbbbbbbb300000000000000000000000000bbbbbbbb00000000000000000000000000000000000000000000
be3ebe3ebe3ebbbbbbbbe33ebbbb3e9907bb3b3b3bbbbbbbb3333303030000000000000000bbbbbbbbbbbb000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbe33ebbbb39a07bb3b3b3bbbbbbbb3bbbbbbbbbbbb9a00000000bbbbbbbbbbbbbbbb0000000000000000000000000000000000000000
3eeeeee0000003bbb3ebbbe33bbbbe3007bbbbbbbbbbbbbbb3bbbbbbbbbbbb990000000bbbbbbbbbbbbbbbbbb000000000000000000000000000000000000000
077777000000003bb3ebbbe33bb3eb30003bbbbbbbbbbbbbb3bb33b33b33bb99000000bbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000000000
077770000000000bbbbbbbb33bb3ebe000333333333333333bbb33b33b33bb9900000bbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000
0777000000000033ebebbbe33bbbbbb3003bbbbbbbbbbbbbbbbbbbbbbbbbbb9900000bbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000
07700000000007ee3bebbbb33bbbbbbe00bbbbbbbbbbbbbbbbbbbbbbbbbbbb9a0000bbbbbbbbbbbbbbbbbbbbbbbb000000000000000000000000000000000000
07000000000007ee3bebbbb33bbeeeee00bbbbb3bbbb3333333b3bbbb33030000000bbbbbbbbbbbbbbbbbbbbbbbb000000000000000000000000000000000000
00000000000007ee3bee3bb33beebeee0bbbbb3bbb3bbbbbbbbbb3bb30000000000bbbbbbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000000
00000000000007ee3bbbbbb33beebebe0b33bbbbb3bbbbb3333bb3bb00000000000bbbbbbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000000
00000000000007ee3b3ebbb33bbebebe0b33bbbb3bb733333bb3bbb300000000000bbbbbbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000000
00000000000007ee3bbeeeb33bbebebe0b33bbbb3bb7bbbbb3b3bbb000000000000bbbbbbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000000
00000000000007ee3bbeeeb33bbebebe0b33bbbb3bb7bbbbb3b3bbb000000000000bbbbbbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000000
00000000000007ee3b3ebbb33bbebebe0b33bbbb3bb733333bb3bbb300000000000bbbbbbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000000
00000000000007ee3bbbbbb33beebebe0b33bbbbb3bbbbb3333bb3bb00000000000bbbbbbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000000
00000000000007ee3bee3bb33beebeee0bbbbb3bbb3bbbbbbbbbb3bb30000000000bbbbbbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000000
07000000000007ee3bebbbb33bbeeeee00bbbbb3bbbb3333333b3bbbb33030000000bbbbbbbbbbbbbbbbbbbbbbbb000000000000000000000000000000000000
07700000000007ee3bebbbb33bbbbbbe00bbbbbbbbbbbbbbbbbbbbbbbbbbbb9a0000bbbbbbbbbbbbbbbbbbbbbbbb000000000000000000000000000000000000
0777000000000033ebebbbe33bbbbbb3003bbbbbbbbbbbbbbbbbbbbbbbbbbb9900000bbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000
077770000000000bbbbbbbb33bb3ebe000333333333333333bbb33b33b33bb9900000bbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000
077777000000003bb3ebbbe33bb3eb30003bbbbbbbbbbbbbb3bb33b33b33bb99000000bbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000000000
3eeeeee0000003bbb3ebbbe33bbbbe3007bbbbbbbbbbbbbbb3bbbbbbbbbbbb990000000bbbbbbbbbbbbbbbbbb000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbe33ebbbb39a07bb3b3b3bbbbbbbb3bbbbbbbbbbbb9a00000000bbbbbbbbbbbbbbbb0000000000000000000000000000000000000000
be3ebe3ebe3ebbbbbbbbe33ebbbb3e9907bb3b3b3bbbbbbbb3333303030000000000000000bbbbbbbbbbbb000000000000000000000000000000000000000000
b33eb33eb33ebe33333333ebbbb33e9907bb3b3b3bbbbbbbb300000000000000000000000000bbbbbbbb00000000000000000000000000000000000000000000
be3ebe3ebe3ebbbbbbbbbbbbbe3e3e9907bb3b3b3bbbbbbbb3000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbeeebebebbbe33eeee9a07bbbbbbbbbbbbbbb3000000000000000000000000000000000000000000000000000000000000000000000000000000
3bbbbbbbbbbbbbbbbbbbbe3300000000003bbbbbbbbbbbbb30000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000444440000004444440000000000440000044444000000000000000000000000000000000000000002220000000000000000000000
02888888888882000000004440444000044444444000044004004004444444400000000000000000000000000000000000000022222000000000000000000000
28888888888888200444444404444040444000044400400404000044400044440000000000000000000000000000000000000022222000000000000000000000
88222244422228804444444404440444440444404440000400400444044404440000000000000000000000002222222200000022222000000000000000000000
88222444222228804444400440004444440444440444004400044440444404440000000000000000000002222222222222200002220000000022222200000000
88888888888888804444044444444444444044440444444000000000444044400000000000000000000222222222222222222000000000022222222222220000
88202200022028800444044444444440444444440000000000000000444444000000000000222000022222222222222222222200000002222202000002222000
22002800028002200000004444444000044444400000000000000000044440000000000002222200220022222222222222222220000222220222222222022200
00002200022000000000000000044440004444000444440000444000000000000000000002200202202202222220000222222222002222222222222222202200
00028888888200000044440000444444040000004444444004444400004444000000000002202202220202222202222022222222202222220000002202202200
00288888888820000444444004444444400000044440004444444400444444400000000002220000222202222022202202200222220222000000000222202200
04888222228884004440044404444444400000444004440444044004444000440000000000222222222022220022020202022022220200000000000202202200
02882888882882004400004440440444440004440044440444400444400000040000000000000000000222220022022202202022220000000000002202202200
48888888888888404400000444004444444444400044404444444444000040040000000000000000022222220022200000222022220000000000022022202200
48828828288288400440040044444440044444000004444404444400000004400000000000022222222222220002222222220222220000000000220222202000
48888888888888400044400000444400004400000000444000000000000000000000000000222222222222222000022222002222200000000002202222022000
48282828282828400002888888882000000000000000000044404440000000080000000000000222222222222220000000022222020000000022222220220000
48288888888828400028822422288200000000004840000048444840000000282000000002222022222002222222000000222220200000000220222202200000
48282828282828400088888888888800000000484840000048888840000000888000000022222202220220222222222200000002000000202200222022020000
48288888888828400022200220022200000000484848400444848444000008888200000022200220222020222222222022222220000000000002222222000000
48282828282828400048400220048400000048484848400484848484000082888820000022020022002220222222220200000000000222220022202220000000
48288888888828400048288888828400000048484848400488888884000008888880000022220002222202222222202000000000022222200222022200000000
48282828282828400042888888882400000048484848400444848444000088882880000002202000000022222222020000000000222222002200222000000000
48288888888828400048282828288400000048484848400004848400000288288082000000002200000222222220200000000000222222022020220000000000
48222828282228400028888888888200000048484848400004848400000002888800000000000000000222222222222222202000000002022220222200022000
48288888888828400488224442228840000004884884000004848400000088888880000000022200000222222222222220002000000020022222222200220000
48282828282828400488244422228840000000484840000004848400000828088282000000220200000022222222220002220000000000022002202002200200
48288822288828400488888888888840000000288400000004848400000008888800000002222220000000000000002220000000000020020022222022020000
48282822282828400482888888282840000000282000000004848400000082022204000022220222000000002022220000000000000000000220222220220200
48888822288888400488882828888840000000282000000002828200000000222000020022022022200000000000000000000000000000002202222222220000
28282822282888200482882228282840000200282000400004848400400200022402020422222202222000000000000000000000022200022022002222200000
28288822288828200488882228888840020240282020202022828220000002042402000002200220022222220000000000000002222000220220020222000000
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ff00000000000000000000000000000000ff
__map__
9700808100008485002600008687000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000808100000090910000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9091000000949500000096970000008600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000003001313131300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0010001313130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000030000002c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000004041424300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000002123230000232323235051525300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000002323000000000061626300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000300000000000b007071727300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000828300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000929300000300003b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a0a1a4a500a2a3a0a1a7a800a6a7a8a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b0b1b4b500b2b3b0b1b7b800b6b7b8b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
490100001902036040361402e03027020210201d11005610240002600000000290002a0002b000000002c0002d0002d000000002d0002d0002b0002a00027000220001e000180001600014000130001300013000
49020000296200e07034630150703564010070276400d0000a05005000010500465006660076000866006600056600365000650006500f7000f7000f7000f7000f7000f7000f7000f7000f700000000000000000
4d020000116611b36110661026510e551193510e6510e6410b5310d6310d621006210862105621026010261101611006110061100611006010060101601016010060100601006010060100601006010060100001
49010000133101a440193401e4501c450173501454011520113001c5000e100175000b50011100031003510000100000000000000000000000000000000000000000000000000000000000000000000000000000
49010000233403a3703d16020650191602266024140206301e63000000000001c63000000000001b4200000019420000000000000000000000000000000000000000000000000000000000000000000000000000
490200003003734637350473664738407326473940730647384072f6473204730047290371a627120270000708057090570000700007076570764700007080370863707627000070862708617000070000700007
55040000243363233637036110361f136264362e136374363c1360000600306003060030600306003060030600306003062a30600006000060000600006000060000600006000060000600006000060000600006
490100002f0332a0533b063297633405323743270331c7230f023127130a013077130000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003
