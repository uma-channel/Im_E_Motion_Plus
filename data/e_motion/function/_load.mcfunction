



scoreboard objectives add eMotion.X dummy
scoreboard objectives add eMotion.Y dummy
scoreboard objectives add eMotion.Z dummy

# [FIX] 天送り退避(6.evacuate_enter/6.return)の間、元の座標を覚えておくための
# エンティティごとのスコア(1/10000のfixed-point)。マーカーではなくスコアで
# 覚えることで、複数のエンティティが同時に天送りされても混線しない。
scoreboard objectives add e_motion.originX dummy
scoreboard objectives add e_motion.originY dummy
scoreboard objectives add e_motion.originZ dummy
