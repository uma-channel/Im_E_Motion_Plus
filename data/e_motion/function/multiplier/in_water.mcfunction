

execute store result score #e_motion iemp_value run data get storage e_motion: _.in.multiplier.in_water 1000

scoreboard players operation #e_motion ImpulseMotion.X *= #e_motion iemp_value
scoreboard players operation #e_motion ImpulseMotion.X /= #global 1000

scoreboard players operation #e_motion ImpulseMotion.Y *= #e_motion iemp_value
scoreboard players operation #e_motion ImpulseMotion.Y /= #global 1000

scoreboard players operation #e_motion ImpulseMotion.Z *= #e_motion iemp_value
scoreboard players operation #e_motion ImpulseMotion.Z /= #global 1000



