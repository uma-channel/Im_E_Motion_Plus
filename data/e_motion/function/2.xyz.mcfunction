
# 入力値の取得（四捨五入・clamp）
function e_motion:input_get

# 入力が 0,0,0 なら何も加算されないため、以降の処理(変換・エンチャント付与・天送り)を丸ごとスキップ
execute if score #e_motion eMotion.X matches 0 if score #e_motion eMotion.Y matches 0 if score #e_motion eMotion.Z matches 0 run return run scoreboard players reset #e_motion

# 変換（ワールド→ローカル：対象自身の向き基準）
function e_motion:world_to_local/start

function e_motion:3.motion_set
