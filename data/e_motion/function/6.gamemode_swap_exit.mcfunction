
# [軽量化] enter側でプレイヤー以外は丸ごとスキップしているため、exit側も同様に
# プレイヤー以外なら何もせず終了する（/gamemodeはプレイヤーにしか作用しない）。
execute unless entity @s[type=player] run return 0

# 6.gamemode_swap_enter で記憶した元のゲームモードへ戻す
execute if score #e_motion e_motion.internal matches 2 run gamemode survival @s
execute if score #e_motion e_motion.internal matches 3 run gamemode adventure @s
execute if score #e_motion e_motion.internal matches 0 run gamemode creative @s

scoreboard players reset #e_motion e_motion.internal
