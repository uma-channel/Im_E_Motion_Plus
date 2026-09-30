
# Y成分を 符号 + 位取り記数法3桁(y1:1/10000位, y2:1/100位, y3:1の位) に分解する

execute store result score #e_motion.digit eMotion.Y run scoreboard players get #e_motion eMotion.Y
execute if score #e_motion.digit eMotion.Y matches ..-1 run data modify storage e_motion: _.macro.signy set value "-"
execute unless score #e_motion.digit eMotion.Y matches ..-1 run data modify storage e_motion: _.macro.signy set value "+"
execute if score #e_motion.digit eMotion.Y matches ..-1 run scoreboard players operation #e_motion.digit eMotion.Y *= #global -1

execute store result storage e_motion: _.macro.y3 int 0.0001 run scoreboard players get #e_motion.digit eMotion.Y
scoreboard players operation #e_motion.digit eMotion.Y %= #global 10000
execute store result storage e_motion: _.macro.y2 int 0.01 run scoreboard players get #e_motion.digit eMotion.Y
scoreboard players operation #e_motion.digit eMotion.Y %= #global 100
execute store result storage e_motion: _.macro.y1 int 1 run scoreboard players get #e_motion.digit eMotion.Y
