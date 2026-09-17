# Im E Motion Plus

エンチャントの`apply_impulse`を利用して、プレイヤー含むエンティティのMotionを操作するデータパック

---

このデータパックは、ひろばお氏の[PlayerMotion](https://github.com/Hirobao1/CustomEnchant_PlayerMotion)を参考に猫愛氏が作成した[ImpulseMotion](https://github.com/nea-c/ImpulseMotion)をフォークしたものです。

大規模な内部処理の変更により、使用感・同一tick動作での挙動が異なります。

---

## ひろばお氏PlayerMotion・猫愛氏ImpulseMotionと比較

| | ひろばお氏 PlayerMotion | 猫愛氏 ImpulseMotion（フォーク元） | 本バージョン |
|---|---|---|---|
| 数値の符号化方式 | 位取り記数法（3軸×3桁） | 32bit二進数（符号1bit＋仮数31bit） | 位取り記数法（3軸×3桁） |
| エンチャント条件数 | 実質9個 | 96条件＋後片付け1件＝97件 | 18条件＋後片付け1件＝19件 |
| 符号とレベルの反映 | `set_custom_data`と`set_enchantments`を別コマンドで発行 | ビット書き込みとエンチャント付与が別コマンド（中間状態が発生し得る） | 1つの連結コマンドでアトミックに反映（中間状態が原理的に発生しない） |
| 発火トリガー | `minecraft:tick`（busy判定＋1tick遅延の再試行キューが必要） | `minecraft:location_changed`（同tick発火だが、過去バージョンでは発火順序に不備があった） | `minecraft:location_changed`（発火順序を修正済み。busy判定・再試行キュー不要） |
| ブロックの隙間が無い方向への押し出し | 非対応（ゲームモード退避なし） | 対応（`6.gamemode_swap`の呼び出し順に不備があった） | 対応（呼び出し順を修正。） |
| 対象 | プレイヤー専用（`armor.body`スロット） | プレイヤー＋鞍を付けたMob（`saddle`スロット） | 同左。加えて騎乗中の判定漏れを修正し、非プレイヤーへの無駄なゲームモード判定処理も省略 |
| multiplier適用後のクランプ | （該当機能自体が無い） | 無し（1を超える倍率で桁が静かに消える不具合が潜在） | 有り（数値シミュレーションで確認・修正済み） |

要するに、
**ひろばお氏PlayerMotionの「軽量設計」**
と、
**猫愛氏ImpulseMotionの「機能性・利便性」**
を両取りしつつ、フォーク元で見つかった発火順序・クランプ漏れ・騎乗中判定漏れといった
不具合を修正したものが本バージョンです。

## 仕様上の限界

なお、ブロックの隙間が無い方向への押し出し機能は動作が不安定。
だが、「たまにMotionが消えることがある」というトレードオフは、
ひろばお氏版にも猫愛氏版にも共通して起こりうる話であり、
**本バージョン固有の弱点ではない。**

---


## 動作要件
 - Minecraft JE 1.21.11 ~ 26.1 Snap.5 版 (動作確認済み)
 - Minecraft JE 26.1 Snap.6 ~ 26.3 Snap.2 版
 - Minecraft JE 26.3 Snap.3 版
 - Minecraft JE 26.3 Snap.4 ~ 版


## 使用方法

`e_motion: in`にデータをセットしてfunctionを実行！

### 例1：実行方向で
```
data modify storage e_motion: in set value {x:0.0000,y:0.0000,z:1.0000, is_looking:true}
execute rotated ~ -20 run function #e_motion:
```
### 例2：XYZで
```
data modify storage e_motion: in set value {x:1.0000,y:10.0000,z:1.0000}
function #e_motion:
```

#### inに記載できるデータ一覧
 - x / y / z
> 方向ベクトル成分値 (0.0001単位)
 - is_knockback
> ノックバック扱いかどうか True/False
 - is_looking
> 実行時の向きに基づくかどうか True/False
 - multiplier.elytra
> エリトラ飛行中の場合の付与量を調整 (0.001単位)
 - multiplier.in_water
> 水中の場合の付与量を調整 (0.001単位)
 - multiplier.swim
> 泳いでいる場合の付与量を調整 (0.001単位)

## ライセンス
LICENSEファイルを必ず確認してください
