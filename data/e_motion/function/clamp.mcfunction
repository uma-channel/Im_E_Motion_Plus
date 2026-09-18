
# #e_motion ImpulseMotion.X/Y/Z を ±999999(=±99.9999) にクランプする共通処理。
# 2.looking・2.xyz・3.motion_set の3箇所で全く同じ内容が重複していたため統合した。
execute if score #e_motion ImpulseMotion.X matches 1000000.. run scoreboard players set #e_motion ImpulseMotion.X 999999
execute if score #e_motion ImpulseMotion.X matches ..-1000000 run scoreboard players set #e_motion ImpulseMotion.X -999999
execute if score #e_motion ImpulseMotion.Y matches 1000000.. run scoreboard players set #e_motion ImpulseMotion.Y 999999
execute if score #e_motion ImpulseMotion.Y matches ..-1000000 run scoreboard players set #e_motion ImpulseMotion.Y -999999
execute if score #e_motion ImpulseMotion.Z matches 1000000.. run scoreboard players set #e_motion ImpulseMotion.Z 999999
execute if score #e_motion ImpulseMotion.Z matches ..-1000000 run scoreboard players set #e_motion ImpulseMotion.Z -999999
