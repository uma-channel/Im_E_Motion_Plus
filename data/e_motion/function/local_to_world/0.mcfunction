
# 実行向き基準のローカル値(左,上,前)をワールド成分へ変換する

tp @s ^1 ^ ^
data modify storage e_motion: _.Pos set from entity @s Pos
function e_motion:local_to_world/1.x.m with storage e_motion: _.macro
tp @s ^ ^1 ^
data modify storage e_motion: _.Pos set from entity @s Pos
function e_motion:local_to_world/2.y.m with storage e_motion: _.macro
tp @s ^ ^ ^1
data modify storage e_motion: _.Pos set from entity @s Pos
function e_motion:local_to_world/3.z.m with storage e_motion: _.macro

# 合計にする
scoreboard players operation #e_motion eMotion.X = #e_motion.lx eMotion.X
scoreboard players operation #e_motion eMotion.X += #e_motion.ly eMotion.X
scoreboard players operation #e_motion eMotion.X += #e_motion.lz eMotion.X

scoreboard players operation #e_motion eMotion.Y = #e_motion.lx eMotion.Y
scoreboard players operation #e_motion eMotion.Y += #e_motion.ly eMotion.Y
scoreboard players operation #e_motion eMotion.Y += #e_motion.lz eMotion.Y

scoreboard players operation #e_motion eMotion.Z = #e_motion.lx eMotion.Z
scoreboard players operation #e_motion eMotion.Z += #e_motion.ly eMotion.Z
scoreboard players operation #e_motion eMotion.Z += #e_motion.lz eMotion.Z

# リセット
scoreboard players reset #e_motion.lx
scoreboard players reset #e_motion.ly
scoreboard players reset #e_motion.lz

# マーカー位置修正
tp @s 0.0 0.0 0.0
