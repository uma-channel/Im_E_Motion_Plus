

# 実行者のスコアを加算
scoreboard players operation #e_motion eMotion.X += @s eMotion.X
scoreboard players operation #e_motion eMotion.Y += @s eMotion.Y
scoreboard players operation #e_motion eMotion.Z += @s eMotion.Z


function e_motion:clamp


# 実行者に保持
scoreboard players operation @s eMotion.X = #e_motion eMotion.X
scoreboard players operation @s eMotion.Y = #e_motion eMotion.Y
scoreboard players operation @s eMotion.Z = #e_motion eMotion.Z



# エリトラでの飛行中 / Z成分が正数 のとき、functionを実行して付与量を調整
execute if predicate {type:"entity_properties",entity:"this",predicate:{flags:{is_fall_flying:true}}} if score #e_motion eMotion.Z matches 1.. run function e_motion:multiplier/elytra

# 水中 のとき、functionを実行して付与量を調整
execute if predicate {type:"entity_properties",entity:"this",predicate:{flags:{is_in_water:true}}} run function e_motion:multiplier/in_water

# 泳いでいる / Z成分が正数 のとき、functionを実行して付与量を調整
execute if predicate {type:"entity_properties",entity:"this",predicate:{flags:{is_swimming:true}}} if score #e_motion eMotion.Z matches 1.. run function e_motion:multiplier/swim

function e_motion:clamp



# saddleがない場合付与
execute unless items entity @s saddle * run item replace entity @s saddle with saddle[equippable={slot:saddle,equip_sound:"entity.cod.ambient"},enchantments={binding_curse:1,vanishing_curse:1}]

# 初期値
data modify storage e_motion: _.macro set value {"signx":"+","signy":"+","signz":"+","x1":0,"x2":0,"x3":0,"y1":0,"y2":0,"y3":0,"z1":0,"z2":0,"z3":0}

# 符号 + 位取り記数法3桁(base100, 桁ごとにエンチャントレベルへ直接載せる)に分解
function e_motion:store/x
function e_motion:store/y
function e_motion:store/z

# リセット
scoreboard players reset #e_motion
scoreboard players reset #e_motion.digit

# 天送り
summon marker ~ ~ ~ {Tags:["iemp."]}
rotate @n[tag=iemp.] ~ ~
execute at @s run tp @s ~ 10000 ~

# エンチャント付与：符号(custom_data)とレベルを1コマンドでアトミックに反映する。
function e_motion:4.enchant_set with storage e_motion: _.macro

# 天から帰還
tp @s @n[tag=iemp.]
kill @n[tag=iemp.]
