
# ワールド成分をマクロ引数へ渡し、対象自身の向き基準のローカル成分へ変換する
execute store result storage e_motion: _.macro.PowerX int 1 run scoreboard players get #e_motion eMotion.X
execute store result storage e_motion: _.macro.PowerY int 1 run scoreboard players get #e_motion eMotion.Y
execute store result storage e_motion: _.macro.PowerZ int 1 run scoreboard players get #e_motion eMotion.Z

execute rotated as @s in iemp: positioned 0.0 0.0 0.0 as 01343cb4-6e1b-748a-83eb-38fc01343cb4 run function e_motion:world_to_local/0
