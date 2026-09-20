# Im E Motion Plus

エンチャントの`apply_impulse`を利用してプレイヤー・MobのMotionを操作するデータパック

---

このデータパックは、ひろばお氏の[PlayerMotion](https://github.com/Hirobao1/CustomEnchant_PlayerMotion)及び猫愛氏の[ImpulseMotion](https://github.com/nea-c/ImpulseMotion)をフォークしたものです。

大規模な内部処理の変更により、使用感・同一tick動作での挙動が異なります。

---

## 26.3 以降への対応

猫愛氏が26.3向けに公開したImpulse Motion r2（`apply_impulse`のMojang側バグ修正に
追随した更新）を参考に、本フォークも26.3系のAPIへ全面対応させた。詳細は下記参照。

---

## 動作要件
- Minecraft JE 26.3 以降
- [1.21.11+版](https://github.com/uma-channel/Im_E_Motion_Plus/tree/1.21.11%2B)
- [26.1+版](https://github.com/uma-channel/Im_E_Motion_Plus/tree/26.1-Snap.6%2B)


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

> 実行者の位置・向き（視点）・ディメンションは変化しないため、`execute as @a run function #e_motion:` のように
> `at @s` を付けない呼び方でも動作する。`is_looking:true` の向きは「実行コンテキストの向き」基準で、
> `rotated ~ -20` などを併用しても、計算で反映されるだけで対象の視点は動かない。

#### inに記載できるデータ一覧
 - x / y / z
> 方向ベクトル成分値 (0.0001単位)
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

# 変更点

## Mojang側の変更点
- **MC-303493**：`apply_impulse`が「ぶつかる方向の成分を適用しない」不具合。
  26.3 Snap.4で修正。
- **MC-303789**：真上を見て`apply_impulse`を使うと、X/Z軸への効果が
  水平2軸のうち片方にしか適用されない不具合。同じく修正。
- 上記の修正に伴い、`direction`によるローカル→ワールド変換がMojang側で
  正しく機能するようになったため、is_looking時に**常に**自前でローカル→ワールド
  変換（旧`vector_get`）を行う必要はなくなった。ただし`direction`は「対象自身の向き」基準のため、
  `rotated`等で実行向きが対象の向きと違う場合だけは、依然として計算での変換が必要。
  本フォークは向きが一致するか(`looking/ctx_frame`・`looking/act_frame`)を判定し、
  **違うときだけ**変換する（`looking/convert` → `local_to_world` → `world_to_local`）。
  一致しているとき（`execute as .. at @s` の通常呼び出し）は変換コストがかからず、値も厳密なまま渡る。
- xyz直接指定（ワールド絶対座標）を実現するには、引き続き逆変換（ワールド→ローカル）が必要
  （`direction`は常に発火時点の向きを基準にローカル解釈されるため）。

## それでも残っている不具合
- **Y軸方向のMotionのみが消える**という不具合は26.3でも
解消されていない。MC-303493とは別種の問題。
猫愛氏のImpulseMotion(r2)では条件下で必ず起きるこの問題を、
本フォークでは発火の瞬間だけ
**何もない空間に転移する**対策で、
問題が起きる確率を下げた。
- しかしこの対策は、コマンドブロック実行などの特定の条件下で適用されない。
詳しくは[tick処理順序表](https://gist.github.com/misode/77ee37217a69a3c74032679d8084d6c6)を確認。

## 主なAPI変更点への追随
26.3で下記のようにスキーマが変わっているため、全ファイルを書き換えた。
- predicateの判別キーが`condition` → `type`に変更
- item modifierの判別キーが`function` → `type`に変更
- dimension_typeの記述変更
- エンチャント効果のトリガーが`location_changed` → `tick`に変更
- `entity_properties`述語に騎乗判定のネイティブフィールド`vehicle`が追加
  （旧`nbt={RootVehicle:{}}`セレクタ判定から置き換え）
- `data modify ... set compute ...`という新しいNBTソース（四則演算をNBT側で
  完結できる）が追加された。ノックバック・爆発耐性の倍率計算をこれに置き換え、
  従来の「1000倍して/1000する」ような固定小数点の力業をやめた
- `explosion_knockback_resistance`属性を使った`is_explosion`（爆発ノックバック
  扱い）を本家r2から取り入れた。

### その他修正
- 本家と不同のUUID
- UUIDが一致しない問題を修正
- 本家と不同のスコアボード
- 入力値が0の場合の処理全スキップ
- 0.0001刻みの入力の約6.9%が、1単位(0.0001)ずれる問題を修正
- rotatedの修正

## ImpulseMotion r2 比較
- 位取り記数法によるエンチャント条件の軽量化
- 虚無空間への転移によるY軸消失バグへの対策
- multiplier適用後のクランプ漏れ
  への対策。本家r2は`上限下限を削除`（クランプ自体を撤廃）した
  ため、この不具合の形自体が起こらなくなっている
  （代わりに32bit整数のオーバーフローという別のリスクを負っている）

---

## ライセンス
LICENSEファイルを必ず確認してください
