

# 実行者のスコアを加算
scoreboard players operation #e_motion ImpulseMotion.X += @s ImpulseMotion.X
scoreboard players operation #e_motion ImpulseMotion.Y += @s ImpulseMotion.Y
scoreboard players operation #e_motion ImpulseMotion.Z += @s ImpulseMotion.Z


function e_motion:clamp


# 実行者に保持
scoreboard players operation @s ImpulseMotion.X = #e_motion ImpulseMotion.X
scoreboard players operation @s ImpulseMotion.Y = #e_motion ImpulseMotion.Y
scoreboard players operation @s ImpulseMotion.Z = #e_motion ImpulseMotion.Z



# エリトラでの飛行中 / Z成分が正数 のとき、functionを実行して付与量を調整
execute if predicate {type:"entity_properties",entity:"this",predicate:{flags:{is_fall_flying:true}}} if score #e_motion ImpulseMotion.Z matches 1.. run function e_motion:multiplier/elytra

# 水中 のとき、functionを実行して付与量を調整
execute if predicate {type:"entity_properties",entity:"this",predicate:{flags:{is_in_water:true}}} run function e_motion:multiplier/in_water

# 泳いでいる / Z成分が正数 のとき、functionを実行して付与量を調整
execute if predicate {type:"entity_properties",entity:"this",predicate:{flags:{is_swimming:true}}} if score #e_motion ImpulseMotion.Z matches 1.. run function e_motion:multiplier/swim

function e_motion:clamp



# saddleがない場合付与
execute unless items entity @s saddle * run item replace entity @s saddle with saddle[equippable={slot:saddle,equip_sound:"entity.cod.ambient"},enchantments={binding_curse:1,vanishing_curse:1}]

# 初期値
data modify storage e_motion: _.macro set value {"signx":"+","signy":"+","signz":"+","x1":0,"x2":0,"x3":0,"y1":0,"y2":0,"y3":0,"z1":0,"z2":0,"z3":0}

# 符号 + 位取り記数法3桁(base100, 桁ごとにエンチャントレベルへ直接載せる)に分解
# ビット単位ではなく数値そのものをレベルとして使うため、32bit分解(96条件)が
# 3桁×3軸(9エンチャント/18条件)まで軽量化される
function e_motion:store/x
function e_motion:store/y
function e_motion:store/z

# リセット
scoreboard players reset #e_motion
scoreboard players reset #e_motion.digit

# 発火の瞬間だけスペクテイター
function e_motion:6.gamemode_swap_enter

# エンチャント付与：符号(custom_data)とレベルを1コマンドでアトミックに反映する。
function e_motion:4.enchant_set with storage e_motion: _.macro

function e_motion:6.gamemode_swap_exit
