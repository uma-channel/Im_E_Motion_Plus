
# [重要] プレイヤーの`tick`/`location_changed`エンチャント効果は、コマンドの
# 実行フェーズ（ここ）より後、Connection::tick内のServerPlayer::doTickで
# 評価される。つまりapply_impulseの実際の発火は「このtickの、もう少し後」で
# 起こる。3.motion_setから即座にこの関数を呼ぶと、発火より前に上空退避を
# 解除してしまい退避の意味が無くなるため、必ず`schedule ... 1t`で
# 1tick遅らせて呼び出すこと。
execute as @e[tag=e_motion.evacuated] at @s run function e_motion:6.evacuate_exit_each
