
# 単位ベクトル値取得

tp @s ^1 ^ ^
data modify storage e_motion: _.Pos set from entity @s Pos
function e_motion:world_to_local/1.x.m with storage e_motion: _.macro
tp @s ^ ^1 ^
data modify storage e_motion: _.Pos set from entity @s Pos
function e_motion:world_to_local/2.y.m with storage e_motion: _.macro
tp @s ^ ^ ^1
data modify storage e_motion: _.Pos set from entity @s Pos
function e_motion:world_to_local/3.z.m with storage e_motion: _.macro


# 合計にする
scoreboard players operation #e_motion eMotion.X = #e_motion.left eMotion.X
scoreboard players operation #e_motion eMotion.X += #e_motion.left eMotion.Y
scoreboard players operation #e_motion eMotion.X += #e_motion.left eMotion.Z

scoreboard players operation #e_motion eMotion.Y = #e_motion.up eMotion.X
scoreboard players operation #e_motion eMotion.Y += #e_motion.up eMotion.Y
scoreboard players operation #e_motion eMotion.Y += #e_motion.up eMotion.Z

scoreboard players operation #e_motion eMotion.Z = #e_motion.forward eMotion.X
scoreboard players operation #e_motion eMotion.Z += #e_motion.forward eMotion.Y
scoreboard players operation #e_motion eMotion.Z += #e_motion.forward eMotion.Z


# リセット
scoreboard players reset #e_motion.left
scoreboard players reset #e_motion.up
scoreboard players reset #e_motion.forward


# マーカー位置修正
tp @s 0.0 0.0 0.0