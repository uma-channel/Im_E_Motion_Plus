
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
scoreboard players operation #e_motion ImpulseMotion.X = #e_motion.left ImpulseMotion.X
scoreboard players operation #e_motion ImpulseMotion.X += #e_motion.left ImpulseMotion.Y
scoreboard players operation #e_motion ImpulseMotion.X += #e_motion.left ImpulseMotion.Z

scoreboard players operation #e_motion ImpulseMotion.Y = #e_motion.up ImpulseMotion.X
scoreboard players operation #e_motion ImpulseMotion.Y += #e_motion.up ImpulseMotion.Y
scoreboard players operation #e_motion ImpulseMotion.Y += #e_motion.up ImpulseMotion.Z

scoreboard players operation #e_motion ImpulseMotion.Z = #e_motion.forward ImpulseMotion.X
scoreboard players operation #e_motion ImpulseMotion.Z += #e_motion.forward ImpulseMotion.Y
scoreboard players operation #e_motion ImpulseMotion.Z += #e_motion.forward ImpulseMotion.Z


# リセット
scoreboard players reset #e_motion.left
scoreboard players reset #e_motion.up
scoreboard players reset #e_motion.forward


# マーカー位置修正
tp @s 0.0 0.0 0.0