[English](README.md) | 日本語

# Im E Motion Plus

エンチャントの`apply_impulse`を利用してプレイヤー・MobのMotionを操作するデータパック

入力する数値は[このサイト](https://clpc.club/e_motion)を参考にしてください。

---

このデータパックは、猫愛氏の[ImpulseMotion](https://github.com/nea-c/ImpulseMotion)及び ひろばお氏の[PlayerMotion](https://github.com/Hirobao1/CustomEnchant_PlayerMotion)をフォークしたものです。

大規模な内部処理の変更により、使用感・同一tick動作での挙動が異なります。


## 動作要件
- Minecraft JE 26.3 以降
- [1.21.11+版(非推奨)](https://github.com/uma-channel/Im_E_Motion_Plus/tree/1.21.11%2B)
- [26.1+版(非推奨)](https://github.com/uma-channel/Im_E_Motion_Plus/tree/26.1-Snap.6%2B)


## 使用方法

`e_motion: in`にデータをセットしてfunctionを実行！

### 例1：実行方向で
```
data modify storage e_motion: in set value {x:0.0000,y:0.0000,z:1.0000, is_looking:true}
```
### 例2：XYZで
```
data modify storage e_motion: in set value {x:1.0000,y:10.0000,z:1.0000}
```
### Motion適用
```
function #e_motion:
```

> `execute as @a run function #e_motion:` のように `at @s` を付けない呼び方でも動作する。
> `is_looking:true` の向きは「実行コンテキストの向き」基準で、
> `rotated` などを併用しても動作する。

#### inに記載できるデータ一覧
 - x / y / z
> 方向ベクトル成分値 (0.0001単位)
[このサイト](https://clpc.club/e_motion)を参考にしてください。
 - is_explosion
> 爆発ノックバック扱いかどうか True/False
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

---

# それでも残っている不具合
- **Y軸方向のMotionのみが消える**及び**水平方向の勢いが消える**という不具合は26.3でも
解消されていない。MC-303493とは別種の問題。

---

## ライセンス

詳細は [LICENSE](LICENSE) を参照。
