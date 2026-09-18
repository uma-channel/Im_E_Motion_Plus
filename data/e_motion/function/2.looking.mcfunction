


# 入力値の取得
execute store result score #e_motion ImpulseMotion.X run data get storage e_motion: _.in.x 10000
execute store result score #e_motion ImpulseMotion.Y run data get storage e_motion: _.in.y 10000
execute store result score #e_motion ImpulseMotion.Z run data get storage e_motion: _.in.z 10000

# 値の修正
function e_motion:clamp


# [注記] ここで作る macro.PowerX/Y/Z は「is_looking時：向き基準のローカル入力値」を
# 表す。3.motion_set冒頭で同名のmacro.PowerX/Y/Zを再度作っているが、そちらは
# 「ワールド座標に変換済みの値」を表しており、意味が異なる点に注意
# （vector_getは ローカル→ワールド、local_to_worldは ワールド→ローカル、と
# 逆方向の変換を行うため、双方が同じ変数名を別の意味で使い回している）。
execute store result storage e_motion: _.macro.PowerX int 1 run scoreboard players get #e_motion ImpulseMotion.X
execute store result storage e_motion: _.macro.PowerY int 1 run scoreboard players get #e_motion ImpulseMotion.Y
execute store result storage e_motion: _.macro.PowerZ int 1 run scoreboard players get #e_motion ImpulseMotion.Z

# 変換
execute in iemp: positioned 0.0 0.0 0.0 as 01343cb4-6e1b-748a-83eb-38fc01343cb4 run function e_motion:vector_get/0


function e_motion:3.motion_set

