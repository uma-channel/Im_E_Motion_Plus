

# 爆発ノックバック耐性を取得(x)
# 1-xし、最小値は0にする
  execute store result storage e_motion: _.resistance double 0.0001 run attribute @s explosion_knockback_resistance get 10000
  data modify storage e_motion: _.resistance set compute default float {type:"max",inputs:[{type:"sub",left:1,right:{type:"storage","storage":"e_motion:","path":"_.resistance"}},0]}

# それぞれの項目にノックバック耐性の倍率を適用
  # in.x
    data modify storage e_motion: _.in.x set compute default float {type:"mul",inputs:[{type:"storage","storage":"e_motion:","path":"_.in.x"},{type:"storage","storage":"e_motion:","path":"_.resistance"}]}
  # in.y
    data modify storage e_motion: _.in.y set compute default float {type:"mul",inputs:[{type:"storage","storage":"e_motion:","path":"_.in.y"},{type:"storage","storage":"e_motion:","path":"_.resistance"}]}
  # in.z
    data modify storage e_motion: _.in.z set compute default float {type:"mul",inputs:[{type:"storage","storage":"e_motion:","path":"_.in.z"},{type:"storage","storage":"e_motion:","path":"_.resistance"}]}
