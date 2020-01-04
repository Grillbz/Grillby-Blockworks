 # store Health to score "hp" once per time stop
execute unless score @s hp = @s hp store result score @s hp run data get entity @s Health 10
 # hp - player's damage 
scoreboard players operation @s hp -= @p dmgB
 # prints damage in stopped time
execute as @s run tellraw @p [{"text":"Health: "},{"score":{"name":"@s","objective":"hp"}}]
execute as @p run tellraw @p [{"text":"dmgB: "},{"score":{"name":"@s","objective":"dmgB"}}]
 # resets damage so it doesn't accumulate
scoreboard players reset @a[scores={dmgB=0..}] dmgB