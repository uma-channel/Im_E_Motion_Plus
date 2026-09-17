
# 単位ベクトル値取得

tp @s ^1 ^ ^
data modify storage e_motion: _.Pos set from entity @s Pos
function e_motion:vector_get/1.x.m with storage e_motion: _.macro
tp @s ^ ^1 ^
data modify storage e_motion: _.Pos set from entity @s Pos
function e_motion:vector_get/2.y.m with storage e_motion: _.macro
tp @s ^ ^ ^1
data modify storage e_motion: _.Pos set from entity @s Pos
function e_motion:vector_get/3.z.m with storage e_motion: _.macro


# 合計にする
scoreboard players operation #e_motion ImpulseMotion.X = #e_motion.PowerX ImpulseMotion.X
scoreboard players operation #e_motion ImpulseMotion.X += #e_motion.PowerY ImpulseMotion.X
scoreboard players operation #e_motion ImpulseMotion.X += #e_motion.PowerZ ImpulseMotion.X

scoreboard players operation #e_motion ImpulseMotion.Y = #e_motion.PowerX ImpulseMotion.Y
scoreboard players operation #e_motion ImpulseMotion.Y += #e_motion.PowerY ImpulseMotion.Y
scoreboard players operation #e_motion ImpulseMotion.Y += #e_motion.PowerZ ImpulseMotion.Y

scoreboard players operation #e_motion ImpulseMotion.Z = #e_motion.PowerX ImpulseMotion.Z
scoreboard players operation #e_motion ImpulseMotion.Z += #e_motion.PowerY ImpulseMotion.Z
scoreboard players operation #e_motion ImpulseMotion.Z += #e_motion.PowerZ ImpulseMotion.Z

# リセット
scoreboard players reset #e_motion.PowerX
scoreboard players reset #e_motion.PowerY
scoreboard players reset #e_motion.PowerZ


# マーカー位置修正
tp @s 0.0 0.0 0.0