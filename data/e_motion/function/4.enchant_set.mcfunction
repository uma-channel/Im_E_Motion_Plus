
# 符号(custom_data)とレベル(位取り記数法3桁×3軸)を1コマンドで同時に反映する。
# 2コマンドに分けてしまうと「符号だけ書き換わりレベルはまだ」という中間状態が
# 発生し得るため、item modifierを連結して必ずアトミックに適用する。
$item modify entity @s saddle [{function:"set_custom_data",tag:{"e_motion.signx":"$(signx)","e_motion.signy":"$(signy)","e_motion.signz":"$(signz)"}},{function:"set_enchantments",enchantments:{"e_motion:x_1":$(x1),"e_motion:x_2":$(x2),"e_motion:x_3":$(x3),"e_motion:y_1":$(y1),"e_motion:y_2":$(y2),"e_motion:y_3":$(y3),"e_motion:z_1":$(z1),"e_motion:z_2":$(z2),"e_motion:z_3":$(z3)}}]
