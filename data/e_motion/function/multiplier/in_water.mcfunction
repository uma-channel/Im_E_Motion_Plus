

execute store result score #e_motion iemp_value run data get storage e_motion: _.in.multiplier.in_water 1000

scoreboard players operation #e_motion eMotion.X *= #e_motion iemp_value
scoreboard players operation #e_motion eMotion.X /= #global 1000

scoreboard players operation #e_motion eMotion.Y *= #e_motion iemp_value
scoreboard players operation #e_motion eMotion.Y /= #global 1000

scoreboard players operation #e_motion eMotion.Z *= #e_motion iemp_value
scoreboard players operation #e_motion eMotion.Z /= #global 1000



