English | [日本語](README_jp.md)

# Im E Motion Plus

A datapack that manipulates the motion of players and mobs using the enchant `apply_impulse`.

---

This datapack is a fork of [ImpulseMotion](https://github.com/nea-c/ImpulseMotion) by nea-c and [PlayerMotion](https://github.com/Hirobao1/CustomEnchant_PlayerMotion) by Hirobao1.

Due to major internal processing changes, the user experience and behavior under identical tick operations differ.

## Operating Requirements
- Minecraft JE 26.3 or later
- [1.21.11+ Version (Deprecated)](https://github.com/uma-channel/Im_E_Motion_Plus/tree/1.21.11%2B)
- [26.1+ Version (Deprecated)](https://github.com/uma-channel/Im_E_Motion_Plus/tree/26.1-Snap.6%2B)

## Usage

Set data in `e_motion: in` and run the function!

### Example 1: By Execution Direction
```
data modify storage e_motion: in set value {x:0.0000,y:0.0000,z:1.0000, is_looking:true}
```
### Example 2: By XYZ
```
data modify storage e_motion: in set value {x:1.0000,y:10.0000,z:1.0000}
```
### Apply Motion
```
function #e_motion:
```

> Calls without `at @s`, such as `execute as @a run function #e_motion:`, will also work.
> The direction for `is_looking:true` is based on the "execution context's direction," and it works even when combined with `rotated` etc.

#### List of Data Available in `in`
- x / y / z
> Direction vector component values (in units of 0.0001)
- is_explosion
> Whether to treat as explosion knockback: True/False
- is_knockback
> Whether to treat as knockback: True/False
- is_looking
> Whether to base on the execution-time direction: True/False
- multiplier.elytra
> Adjusts the amount granted when flying with elytra (in units of 0.001)
- multiplier.in_water
> Adjusts the amount granted when underwater (in units of 0.001)
- multiplier.swim
> Adjusts the amount granted when swimming (in units of 0.001)

---

# Remaining Bugs
- The bugs where **only the Y-axis motion disappears** and **horizontal momentum disappears** remain unresolved in 26.3. These are separate issues from MC-303493.

---

## License

See [LICENSE](LICENSE) for details.
