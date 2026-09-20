
# 入力値の取得（四捨五入・clamp）
function e_motion:input_get

# 入力が 0,0,0 なら何も加算されないため、以降の処理を丸ごとスキップ
execute if score #e_motion eMotion.X matches 0 if score #e_motion eMotion.Y matches 0 if score #e_motion eMotion.Z matches 0 run return run scoreboard players reset #e_motion

# 入力は「実行コンテキストの向き」基準のローカル値(左,上,前)
execute in iemp: positioned 0.0 0.0 0.0 as 01343cb4-6e1b-748a-83eb-38fc01343cb4 run function e_motion:looking/ctx_frame
execute rotated as @s in iemp: positioned 0.0 0.0 0.0 as 01343cb4-6e1b-748a-83eb-38fc01343cb4 run function e_motion:looking/act_frame
execute if score #e_motion.diff e_motion.internal matches 1 run function e_motion:looking/convert
scoreboard players reset #e_motion.diff e_motion.internal

function e_motion:3.motion_set
