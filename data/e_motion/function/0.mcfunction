
## データ記法
# x/y/z : 方向ベクトル成分値 (0.0001単位)
# is_knockback : ノックバック扱いかどうか True/False
# is_looking : 実行時の向きに基づくかどうか True/False
# multiplier.elytra : エリトラ飛行中の場合の付与量を調整 (0.001単位)
# multiplier.in_water : 水中の場合の付与量を調整 (0.001単位)
# multiplier.swim : 泳いでいる場合の付与量を調整 (0.001単位)
#
# [常時有効] 発火の瞬間だけ衝突判定のないゲームモード（スペクテイター/
# アドベンチャー）を経由し、目標方向にブロックの隙間が無くても押し出せる
# ようにしている。ただしこれはプレイヤーのクライアント主導の移動処理と
# 競合しうるため、ごく低い確率でMotionが上書きされ消えてしまうことがある
# （詳細はREADME.md「ゲームモード退避（6.gamemode_swap）について」を参照）。
# data modify storage e_motion: in set value {x:0.0000,y:0.0000,z:0.0000, is_knockback:false,is_looking:false,is_elytra_suppression:true}



# スペクテイターのプレイヤーなら中断
execute if entity @s[type=player,gamemode=spectator] run \
  return fail
# クリエイティブのプレイヤーで、かつクリエ飛行中なら中断
execute if entity @s[type=player,gamemode=creative] \
  if predicate {condition:"entity_properties",entity:"this",predicate:{flags:{is_flying:1b,is_fall_flying:0b}}} run \
    return fail
# [FIX] 何かに騎乗している場合は中断（本家PlayerMotionも同様の前提を明記している）
execute if entity @s[nbt={RootVehicle:{}}] run \
  return fail



# ストレージを初期化
# ["macro"は3.motion_set.mcfunctionで毎回上書きされるため、ここでは"in"のみ初期化すれば十分]
data modify storage e_motion: _ set value {in:{x:0.0000,y:0.0000,z:0.0000, is_knockback:false,is_looking:false,multiplier:{elytra:0.500,swim:0.500,in_water:1.5}}}

# 入力値を受け取る
data modify storage e_motion: _.in merge from storage e_motion: in



# ノックバック扱いなら耐性値で調整
execute if data storage e_motion: _.in{is_knockback:true} run function e_motion:1.knockback


# is_lookingがtrueなら向きにMotion付与
execute if data storage e_motion: _.in{is_looking:true} run \
  return run function e_motion:2.looking


# 向きに関係なくXYZ軸にMotion付与
function e_motion:2.xyz
