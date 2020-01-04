 # repeat this function w/ powered repeating command block or tick functions; do /function main:torch/tmeLoad to set up scoreboards

 # 5 seconds starting from 1 to 100
scoreboard players add @a[scores={coas=1..}] time 1
execute as @a unless score @s coas = @s coas run scoreboard players reset @s time
scoreboard players reset @a[scores={time=100..}] coas

 # summon armor stands and turn base blocks (most abundant ones so immersion can be achieved with less processing) into different blocks (concrete bc most people don't use them) that can be identified and turned back into their original (endstone <-> black concrete, cobble <-> purple concrete, etc.); this maximizes out /fill areas and does it instantly (time 1 and 2 is to make the area looks like it's spreading); # = unused
execute as @a[scores={time=1}] at @s run summon minecraft:armor_stand ~14 ~ ~14 {Tags:["tm"],Invisible:1,Marker:1}
execute as @a[scores={time=1}] at @s run summon minecraft:armor_stand ~14 ~ ~-14 {Tags:["tm"],Invisible:1,Marker:1}
execute as @a[scores={time=1}] at @s run summon minecraft:armor_stand ~-14 ~ ~14 {Tags:["tm"],Invisible:1,Marker:1}
execute as @a[scores={time=1}] at @s run summon minecraft:armor_stand ~-14 ~ ~-14 {Tags:["tm"],Invisible:1,Marker:1}
#execute as @a[scores={time=2}] at @s run summon minecraft:armor_stand ~42 ~ ~42 {Tags:["tm"],Invisible:1,Marker:1}
execute as @a[scores={time=2}] at @s run summon minecraft:armor_stand ~14 ~ ~42 {Tags:["tm"],Invisible:1,Marker:1}
execute as @a[scores={time=2}] at @s run summon minecraft:armor_stand ~-14 ~ ~42 {Tags:["tm"],Invisible:1,Marker:1}
#execute as @a[scores={time=2}] at @s run summon minecraft:armor_stand ~-42 ~ ~42 {Tags:["tm"],Invisible:1,Marker:1}
execute as @a[scores={time=2}] at @s run summon minecraft:armor_stand ~-42 ~ ~14 {Tags:["tm"],Invisible:1,Marker:1}
execute as @a[scores={time=2}] at @s run summon minecraft:armor_stand ~42 ~ ~14 {Tags:["tm"],Invisible:1,Marker:1}
execute as @a[scores={time=2}] at @s run summon minecraft:armor_stand ~-42 ~ ~-14 {Tags:["tm"],Invisible:1,Marker:1}
execute as @a[scores={time=2}] at @s run summon minecraft:armor_stand ~42 ~ ~-14 {Tags:["tm"],Invisible:1,Marker:1}
#execute as @a[scores={time=2}] at @s run summon minecraft:armor_stand ~42 ~ ~-42 {Tags:["tm"],Invisible:1,Marker:1}
execute as @a[scores={time=2}] at @s run summon minecraft:armor_stand ~14 ~ ~-42 {Tags:["tm"],Invisible:1,Marker:1}
execute as @a[scores={time=2}] at @s run summon minecraft:armor_stand ~-14 ~ ~-42 {Tags:["tm"],Invisible:1,Marker:1}
#execute as @a[scores={time=2}] at @s run summon minecraft:armor_stand ~-42 ~ ~-42 {Tags:["tm"],Invisible:1,Marker:1}
execute as @a[scores={time=1..2}] at @e[type=armor_stand,tag=tm] run fill ~-16 ~-13 ~-16 ~16 ~13 ~16 black_concrete replace end_stone
execute as @a[scores={time=99..}] at @e[type=armor_stand,tag=tm] run fill ~-16 ~-13 ~-16 ~16 ~13 ~16 end_stone replace black_concrete
execute as @a[scores={time=1..2}] at @e[type=armor_stand,tag=tm] run fill ~-16 ~-39 ~-16 ~16 ~-13 ~16 black_concrete replace end_stone
execute as @a[scores={time=99..}] at @e[type=armor_stand,tag=tm] run fill ~-16 ~-39 ~-16 ~16 ~-13 ~16 end_stone replace black_concrete
	#execute as @a[scores={time=1}] at @e[type=armor_stand,tag=tm] run fill ~-15 ~-15 ~-15 ~15 ~15 ~15 purple_concrete replace cobblestone
	#execute as @a[scores={time=99..}] at @e[type=armor_stand,tag=tm] run fill ~-15 ~-15 ~-15 ~15 ~15 ~15 cobblestone replace purple_concrete
	#execute as @a[scores={time=1}] at @e[type=armor_stand,tag=tm] run fill ~-15 ~-15 ~-15 ~15 ~15 ~15 pink_concrete replace stone
	#execute as @a[scores={time=99..}] at @e[type=armor_stand,tag=tm] run fill ~-15 ~-15 ~-15 ~15 ~15 ~15 stone replace pink_concrete
#execute as @a[scores={time=3}] as @e[type=armor_stand,tag=tm] at @s run spreadplayers ~ ~ 0 1 true @s

 # makes mobs freeze and invincible
execute as @a[scores={time=..98}] as @e[type=armor_stand,tag=tm] at @s as @e[distance=..30,nbt=!{NoGravity:1b},type=#main:mobs] run data merge entity @s {NoAI:1b,NoGravity:1b,Glowing:1b,ActiveEffects:[{Id:11b,Duration:100,Amplifier:10b,ShowParticles:0b}]}

 # when mobs get hurt during stopped time, the player's damage_dealt_resisted is subtracted from their virtual health score, and attacks bypass armor
execute as @a[scores={time=..98}] at @s as @e[distance=..10,nbt={HurtTime:9s},type=#main:mobs,type=!armor_stand,type=!player] run function main:torch/tme3
 # when objects are thrown, their Motion is saved into a score; during stopped time, 1% of this score applies to their real Motion; when time resumes, 100% of this score is applied and the object acts as if it's thrown normally
execute as @a[scores={time=..100}] as @e[type=armor_stand,tag=tm] at @s as @e[distance=..30,type=!#main:mobs,type=!player] run function main:torch/tme2

 # time resumes, removes invincibility and mobs move again
execute as @a[scores={time=99..}] as @e[nbt={NoGravity:1b}] run data merge entity @s {NoAI:0,NoGravity:0,Glowing:0,ActiveEffects:[{Id:11b,Duration:0}]}

 # time resumes, mob's virtual health score applies to its real Health
execute as @a[scores={time=99..}] as @e[type=armor_stand,tag=tm] at @s as @e[distance=..30,type=#main:mobs] if score @s hp = @s hp store result entity @s Health float 0.1 run scoreboard players get @s hp
 # resets mob's health score for next time stop
execute as @a[scores={time=99..}] as @e[type=armor_stand,tag=tm] at @s as @e[distance=..30,type=#main:mobs] run scoreboard players reset @e[scores={hp=0..}] hp
 # kill armor stands used for time stop
execute as @a[scores={time=99..}] run kill @e[type=armor_stand,tag=tm]

 # extra; kills arrows on the ground
kill @e[nbt={inGround:1b},type=#arrows]