scoreboard players add @s time 1
 # no crits, no gravity
execute as @s unless score @s x2 = @s x2 run data modify entity @s crit set value 0b
execute as @s unless score @s y2 = @s y2 run data modify entity @s NoGravity set value 1b
 # store Motion to score
execute as @s unless score @s x2 = @s x2 store result score @s x2 run data get entity @s Motion[0] 1000
execute as @s unless score @s y2 = @s y2 store result score @s y2 run data get entity @s Motion[1] 1000
execute as @s unless score @s z2 = @s z2 store result score @s z2 run data get entity @s Motion[2] 1000
 # store score to Motion, stops object but preserves direction
execute as @s[scores={time=1}] if score @s x2 = @s x2 store result entity @s Motion[0] double 0.00000001 run scoreboard players get @s x2
execute as @s[scores={time=1}] if score @s y2 = @s y2 store result entity @s Motion[1] double 0.00000001 run scoreboard players get @s y2
execute as @s[scores={time=1}] if score @s z2 = @s z2 store result entity @s Motion[2] double 0.00000001 run scoreboard players get @s z2
 # store score to Motion, time resumes, crit and gravity continues
execute as @s if entity @a[scores={time=99..}] store result entity @s Motion[0] double 0.001 run scoreboard players get @s x2
execute as @s if entity @a[scores={time=99..}] store result entity @s Motion[1] double 0.001 run scoreboard players get @s y2
execute as @s if entity @a[scores={time=99..}] store result entity @s Motion[2] double 0.001 run scoreboard players get @s z2
execute as @s if entity @a[scores={time=99..}] run data modify entity @s crit set value 1b
execute as @s if entity @a[scores={time=99..}] run data modify entity @s NoGravity set value 0b
