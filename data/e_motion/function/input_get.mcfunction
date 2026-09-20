
# 入力 (_.in.x / y / z) を 0.0001 単位の整数スコアへ変換する（四捨五入・2.looking / 2.xyz 共通）
execute store result score #e_motion eMotion.X run data get storage e_motion: _.in.x 20000
execute store result score #e_motion eMotion.Y run data get storage e_motion: _.in.y 20000
execute store result score #e_motion eMotion.Z run data get storage e_motion: _.in.z 20000

# 正側で int 最大値に飽和した場合、+1 でオーバーフローして符号が反転するため先に頭打ちにする
execute if score #e_motion eMotion.X matches 2147483647 run scoreboard players set #e_motion eMotion.X 2147483646
execute if score #e_motion eMotion.Y matches 2147483647 run scoreboard players set #e_motion eMotion.Y 2147483646
execute if score #e_motion eMotion.Z matches 2147483647 run scoreboard players set #e_motion eMotion.Z 2147483646

scoreboard players add #e_motion eMotion.X 1
scoreboard players add #e_motion eMotion.Y 1
scoreboard players add #e_motion eMotion.Z 1
scoreboard players operation #e_motion eMotion.X /= #global 2
scoreboard players operation #e_motion eMotion.Y /= #global 2
scoreboard players operation #e_motion eMotion.Z /= #global 2

function e_motion:clamp
