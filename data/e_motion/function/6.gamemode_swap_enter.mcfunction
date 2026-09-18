
# [3.motion_set から常時呼ばれる]
# 発火の瞬間だけ衝突判定のないゲームモードへ切り替える。
# ブロックの隙間が無い方向にも押し出せるようになる代わりに、
# プレイヤーのクライアント主導の移動処理と競合し、ごく低い確率で
# 直後に設定したMotionが上書きされて消えることがある（README参照）。

# [軽量化] /gamemodeはプレイヤーにしか作用しないため、プレイヤー以外
# （鞍を付けたMobなど）に対してはこの一連の判定処理自体を丸ごと省略する。
# Mobはサーバーが位置を完全に管理しているため、そもそもこの問題が起きない。
execute unless entity @s[type=player] run return 0

# 元のゲームモードを判定して記憶する（サバイバル=2 / アドベンチャー=3 / クリエイティブ=0）
# この値は 6.gamemode_swap_exit で使うまでスコアに保持される
scoreboard players set #e_motion e_motion.internal 0
execute if entity @s[gamemode=survival] run scoreboard players set #e_motion e_motion.internal 2
execute if entity @s[gamemode=adventure] run scoreboard players set #e_motion e_motion.internal 3

# サバイバル/アドベンチャーの場合：衝突判定のないスペクテイターへ切り替える
execute if score #e_motion e_motion.internal matches 2..3 run gamemode spectator @s
execute if score #e_motion e_motion.internal matches 2..3 run return 1

# ここに到達するのはクリエイティブの場合のみ
# （0.mcfunction冒頭でクリエ飛行中は弾いているため、ここに来る時点でクリエ飛行中ではない）
# 落下中はスペクテイターにすると落下が止まってしまうため、代わりにアドベンチャーを一瞬だけ経由する
execute if predicate e_motion:falling_player run gamemode adventure @s
execute unless predicate e_motion:falling_player run gamemode spectator @s
