
# [FIX] スペクテイター経由だと、弓を引く・盾を構える・食べる等の
# long-press系アイテム使用が途中で中断されてしまう。ゲームモードを
# 変えずに衝突判定を避けるため、代わりに何もない上空へ一瞬だけ
# 退避させる方式にした。

# [FIX] 既に退避中（同じtick内で複数回Motionが付与された場合）は、
# 元座標の記憶を上書きしない。上書きしてしまうと、退避後の座標を
# 「元の座標」として誤って覚えてしまい、復帰時に地上へ戻れなくなる。
execute if entity @s[tag=e_motion.evacuated] run return 0

# 現在位置を記憶する（1/10000のfixed-pointでエンティティごとに保持）
execute store result score @s e_motion.originX run data get entity @s Pos[0] 10000
execute store result score @s e_motion.originY run data get entity @s Pos[1] 10000
execute store result score @s e_motion.originZ run data get entity @s Pos[2] 10000

# 退避中の目印（同時に複数のエンティティが退避しても混線しないようにする）
tag @s add e_motion.evacuated

# 何もない上空へ送る。同じチャンク列の上方向へ移動するだけなので
# 新規のチャンク読み込みは発生しない。500は目安の値で、天井の高い
# 建築物の中などで再現しない場合は大きくしても良い
tp @s ~ ~500 ~
