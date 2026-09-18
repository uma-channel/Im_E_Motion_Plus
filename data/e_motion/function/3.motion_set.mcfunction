


# [注記] ここのmacro.PowerX/Y/Zは「ワールド座標に変換済みの値」を表す
# （2.looking内のmacro.PowerX/Y/Zとは意味が異なる。上記の注記を参照）
execute store result storage e_motion: _.macro.PowerX int 1 run scoreboard players get #e_motion ImpulseMotion.X
execute store result storage e_motion: _.macro.PowerY int 1 run scoreboard players get #e_motion ImpulseMotion.Y
execute store result storage e_motion: _.macro.PowerZ int 1 run scoreboard players get #e_motion ImpulseMotion.Z

# 絶対座標ベクトルへ変換
execute rotated as @s in iemp: positioned 0.0 0.0 0.0 as 01343cb4-6e1b-748a-83eb-38fc01343cb4 run function e_motion:local_to_world/0


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
execute if predicate {condition:"entity_properties",entity:"this",predicate:{flags:{is_fall_flying:1b}}} if score #e_motion ImpulseMotion.Z matches 1.. run function e_motion:multiplier/elytra

# 水中 のとき、functionを実行して付与量を調整
execute if predicate {condition:"entity_properties",entity:"this",predicate:{flags:{is_in_water:1b}}} run function e_motion:multiplier/in_water

# 泳いでいる / Z成分が正数 のとき、functionを実行して付与量を調整
execute if predicate {condition:"entity_properties",entity:"this",predicate:{flags:{is_swimming:1b}}} if score #e_motion ImpulseMotion.Z matches 1.. run function e_motion:multiplier/swim

# [FIX] multiplier.in_water の既定値(1.5)のように1を超える倍率を掛けると、
# クランプ済みの値でも位取り記数法の表現上限(±999999=±99.9999)を再び
# 超えてしまう場合がある。これを放置すると1の位の桁(x3/y3/z3)が
# lookupテーブルの範囲(1〜99)を超えたレベルになり、エンチャント側の
# fallback:0が適用されてその桁だけ静かに消えてしまう（クランプではなく
# 欠落になる）。そのため倍率適用後にもう一度クランプする。
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

# [常時有効] 発火の瞬間だけ衝突判定のないゲームモード（スペクテイター/
# アドベンチャー）を経由し、ブロックの隙間が無い方向にも押し出せるようにする。
# ただしこれはプレイヤーのクライアント主導の移動処理と競合しうるため、
# ごく低い確率で直後に設定したMotionが上書きされて消えることがある
# （詳細はREADME.md「ゲームモード退避（6.gamemode_swap）について」を参照）。
function e_motion:6.gamemode_swap_enter

# エンチャント付与：符号(custom_data)とレベルを1コマンドでアトミックに反映する。
function e_motion:4.enchant_set with storage e_motion: _.macro

function e_motion:6.gamemode_swap_exit
