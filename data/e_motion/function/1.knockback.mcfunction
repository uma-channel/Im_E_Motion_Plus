

# ノックバック耐性を取得(1%刻み)
  execute store result score #e_motion.is_knockback.resist iemp_value run attribute @s knockback_resistance get -100
  scoreboard players add #e_motion.is_knockback.resist iemp_value 100
  execute if score #e_motion.is_knockback.resist iemp_value matches ..-1 run scoreboard players set #e_motion.is_knockback.resist iemp_value 0
  execute if score #e_motion.is_knockback.resist iemp_value matches 101.. run scoreboard players set #e_motion.is_knockback.resist iemp_value 100

# それぞれの項目に要素が入っている時、ノックバック耐性の倍率を適用
  # in.x
    execute if data storage e_motion: _.in.x store result score #e_motion.is_knockback.amount iemp_value run data get storage e_motion: _.in.x 10000
    execute if data storage e_motion: _.in.x store result storage e_motion: _.in.x double 0.000001 run scoreboard players operation #e_motion.is_knockback.amount iemp_value *= #e_motion.is_knockback.resist iemp_value
  # in.y
    execute if data storage e_motion: _.in.y store result score #e_motion.is_knockback.amount iemp_value run data get storage e_motion: _.in.y 10000
    execute if data storage e_motion: _.in.y store result storage e_motion: _.in.y double 0.000001 run scoreboard players operation #e_motion.is_knockback.amount iemp_value *= #e_motion.is_knockback.resist iemp_value
  # in.z
    execute if data storage e_motion: _.in.z store result score #e_motion.is_knockback.amount iemp_value run data get storage e_motion: _.in.z 10000
    execute if data storage e_motion: _.in.z store result storage e_motion: _.in.z double 0.000001 run scoreboard players operation #e_motion.is_knockback.amount iemp_value *= #e_motion.is_knockback.resist iemp_value

# スコアリセット
  scoreboard players reset #e_motion.is_knockback.amount
  scoreboard players reset #e_motion.is_knockback.resist