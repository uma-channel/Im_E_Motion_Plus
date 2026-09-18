
# 発火の瞬間だけ衝突判定のないゲームモードへ切り替える。

# Mobはサーバーが位置を完全に管理しているため、そもそもこの問題が起きない。
execute unless entity @s[type=player] run return 0

# 元のゲームモードを判定して記憶する（サバイバル=2 / アドベンチャー=3 / クリエイティブ=0）
scoreboard players set #e_motion e_motion.internal 0
execute if entity @s[gamemode=survival] run scoreboard players set #e_motion e_motion.internal 2
execute if entity @s[gamemode=adventure] run scoreboard players set #e_motion e_motion.internal 3

# サバイバル/アドベンチャーの場合：衝突判定のないスペクテイターへ切り替える
execute if score #e_motion e_motion.internal matches 2..3 run gamemode spectator @s
execute if score #e_motion e_motion.internal matches 2..3 run return 1

# クリエイティブの場合のみ
execute if predicate e_motion:falling_player run gamemode adventure @s
execute unless predicate e_motion:falling_player run gamemode spectator @s
