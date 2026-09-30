
# #e_motion E Motion.X/Y/Z を ±999999(=±99.9999) にクランプする共通処理。
execute if score #e_motion eMotion.X matches 1000000.. run scoreboard players set #e_motion eMotion.X 999999
execute if score #e_motion eMotion.X matches ..-1000000 run scoreboard players set #e_motion eMotion.X -999999
execute if score #e_motion eMotion.Y matches 1000000.. run scoreboard players set #e_motion eMotion.Y 999999
execute if score #e_motion eMotion.Y matches ..-1000000 run scoreboard players set #e_motion eMotion.Y -999999
execute if score #e_motion eMotion.Z matches 1000000.. run scoreboard players set #e_motion eMotion.Z 999999
execute if score #e_motion eMotion.Z matches ..-1000000 run scoreboard players set #e_motion eMotion.Z -999999
