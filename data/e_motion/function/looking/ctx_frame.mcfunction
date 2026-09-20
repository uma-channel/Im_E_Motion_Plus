
# 実行コンテキストの向きの左(L)・前(F)単位ベクトルを記録する
tp @s ^1 ^ ^
data modify storage e_motion: _.Lc set from entity @s Pos
tp @s ^ ^ ^1
data modify storage e_motion: _.Fc set from entity @s Pos

# マーカー位置修正
tp @s 0.0 0.0 0.0
