

# 入力値の取得
execute store result score #e_motion ImpulseMotion.X run data get storage e_motion: _.in.x 10000
execute store result score #e_motion ImpulseMotion.Y run data get storage e_motion: _.in.y 10000
execute store result score #e_motion ImpulseMotion.Z run data get storage e_motion: _.in.z 10000

# 値の修正
function e_motion:clamp

# 26.3対応
function e_motion:3.motion_set
