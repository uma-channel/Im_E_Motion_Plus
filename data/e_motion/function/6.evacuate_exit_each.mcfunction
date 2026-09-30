
# 記憶しておいた元の座標を取り出して復帰する
execute store result storage e_motion: _.origin.x double 0.0001 run scoreboard players get @s e_motion.originX
execute store result storage e_motion: _.origin.y double 0.0001 run scoreboard players get @s e_motion.originY
execute store result storage e_motion: _.origin.z double 0.0001 run scoreboard players get @s e_motion.originZ

function e_motion:6.evacuate_tp with storage e_motion: _.origin

# 後片付け
tag @s remove e_motion.evacuated
scoreboard players reset @s e_motion.originX
scoreboard players reset @s e_motion.originY
scoreboard players reset @s e_motion.originZ
