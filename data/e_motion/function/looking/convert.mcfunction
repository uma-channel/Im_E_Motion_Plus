
# 実行向き基準のローカル値(左,上,前) → ワールド成分 → 対象向き基準のローカル値

execute store result storage e_motion: _.macro.PowerX int 1 run scoreboard players get #e_motion eMotion.X
execute store result storage e_motion: _.macro.PowerY int 1 run scoreboard players get #e_motion eMotion.Y
execute store result storage e_motion: _.macro.PowerZ int 1 run scoreboard players get #e_motion eMotion.Z

# 1) 実行向き基準のローカル値 → ワールド成分（実行向きは引き継ぐ）
execute in iemp: positioned 0.0 0.0 0.0 as 01343cb4-6e1b-748a-83eb-38fc01343cb4 run function e_motion:local_to_world/0

# 2) ワールド成分 → 対象自身の向き基準のローカル値
function e_motion:world_to_local/start
