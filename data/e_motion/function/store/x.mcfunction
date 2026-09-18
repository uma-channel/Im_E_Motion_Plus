
# X成分を 符号 + 位取り記数法3桁(x1:1/10000位, x2:1/100位, x3:1の位) に分解する
# （x1は0.0001刻み0〜99、x2は0.01刻み0〜99、x3は1刻み0〜99 で、
#   合計値 = x3 + x2*0.01 + x1*0.0001 を表す。最大 ±99.9999 まで表現可能）

execute store result score #e_motion.digit ImpulseMotion.X run scoreboard players get #e_motion ImpulseMotion.X
execute if score #e_motion.digit ImpulseMotion.X matches ..-1 run data modify storage e_motion: _.macro.signx set value "-"
execute unless score #e_motion.digit ImpulseMotion.X matches ..-1 run data modify storage e_motion: _.macro.signx set value "+"
execute if score #e_motion.digit ImpulseMotion.X matches ..-1 run scoreboard players operation #e_motion.digit ImpulseMotion.X *= #global -1

execute store result storage e_motion: _.macro.x3 int 0.0001 run scoreboard players get #e_motion.digit ImpulseMotion.X
scoreboard players operation #e_motion.digit ImpulseMotion.X %= #global 10000
execute store result storage e_motion: _.macro.x2 int 0.01 run scoreboard players get #e_motion.digit ImpulseMotion.X
scoreboard players operation #e_motion.digit ImpulseMotion.X %= #global 100
execute store result storage e_motion: _.macro.x1 int 1 run scoreboard players get #e_motion.digit ImpulseMotion.X

# [センチネル] x1は「現在エンチャント要求が発生中かどうか」の目印を兼ねる（5.enchant_deleteの発火保証）ため、
# 実際の値が0でも、必ず何らかのレベルが乗るようにする（100はlookupの範囲外＝付与量0扱い）
execute if data storage e_motion: _.macro{x1:0} run data modify storage e_motion: _.macro.x1 set value 100
