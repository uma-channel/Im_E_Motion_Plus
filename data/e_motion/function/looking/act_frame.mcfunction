
# 対象自身の向きの左・前単位ベクトルを ctx_frame の記録と比較する
tp @s ^1 ^ ^
execute store success score #e_motion.diff e_motion.internal run data modify storage e_motion: _.Lc set from entity @s Pos
tp @s ^ ^ ^1
execute unless score #e_motion.diff e_motion.internal matches 1 store success score #e_motion.diff e_motion.internal run data modify storage e_motion: _.Fc set from entity @s Pos

# マーカー位置修正
tp @s 0.0 0.0 0.0
