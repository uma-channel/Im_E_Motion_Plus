

# 入力値の取得
execute store result score #e_motion ImpulseMotion.X run data get storage e_motion: _.in.x 10000
execute store result score #e_motion ImpulseMotion.Y run data get storage e_motion: _.in.y 10000
execute store result score #e_motion ImpulseMotion.Z run data get storage e_motion: _.in.z 10000

# 値の修正
function e_motion:clamp

# 26.3対応
execute store result storage e_motion: _.macro.PowerX int 1 run scoreboard players get #e_motion ImpulseMotion.X
execute store result storage e_motion: _.macro.PowerY int 1 run scoreboard players get #e_motion ImpulseMotion.Y
execute store result storage e_motion: _.macro.PowerZ int 1 run scoreboard players get #e_motion ImpulseMotion.Z

# 変換（ワールド→ローカル）
execute rotated as @s in iemp: positioned 0.0 0.0 0.0 as 01343cb4-6e1b-748a-83eb-38fc01343cb4 run function e_motion:world_to_local/0

function e_motion:3.motion_set
