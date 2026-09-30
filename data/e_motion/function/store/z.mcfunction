
# Z成分を 符号 + 位取り記数法3桁(z1:1/10000位, z2:1/100位, z3:1の位) に分解する

execute store result score #e_motion.digit eMotion.Z run scoreboard players get #e_motion eMotion.Z
execute if score #e_motion.digit eMotion.Z matches ..-1 run data modify storage e_motion: _.macro.signz set value "-"
execute unless score #e_motion.digit eMotion.Z matches ..-1 run data modify storage e_motion: _.macro.signz set value "+"
execute if score #e_motion.digit eMotion.Z matches ..-1 run scoreboard players operation #e_motion.digit eMotion.Z *= #global -1

execute store result storage e_motion: _.macro.z3 int 0.0001 run scoreboard players get #e_motion.digit eMotion.Z
scoreboard players operation #e_motion.digit eMotion.Z %= #global 10000
execute store result storage e_motion: _.macro.z2 int 0.01 run scoreboard players get #e_motion.digit eMotion.Z
scoreboard players operation #e_motion.digit eMotion.Z %= #global 100
execute store result storage e_motion: _.macro.z1 int 1 run scoreboard players get #e_motion.digit eMotion.Z
