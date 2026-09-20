
# X成分を 符号 + 位取り記数法3桁(x1:1/10000位, x2:1/100位, x3:1の位) に分解する

execute store result score #e_motion.digit eMotion.X run scoreboard players get #e_motion eMotion.X
execute if score #e_motion.digit eMotion.X matches ..-1 run data modify storage e_motion: _.macro.signx set value "-"
execute unless score #e_motion.digit eMotion.X matches ..-1 run data modify storage e_motion: _.macro.signx set value "+"
execute if score #e_motion.digit eMotion.X matches ..-1 run scoreboard players operation #e_motion.digit eMotion.X *= #global -1

execute store result storage e_motion: _.macro.x3 int 0.0001 run scoreboard players get #e_motion.digit eMotion.X
scoreboard players operation #e_motion.digit eMotion.X %= #global 10000
execute store result storage e_motion: _.macro.x2 int 0.01 run scoreboard players get #e_motion.digit eMotion.X
scoreboard players operation #e_motion.digit eMotion.X %= #global 100
execute store result storage e_motion: _.macro.x1 int 1 run scoreboard players get #e_motion.digit eMotion.X

execute if data storage e_motion: _.macro{x1:0} run data modify storage e_motion: _.macro.x1 set value 100
