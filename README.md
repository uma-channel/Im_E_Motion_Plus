English | [日本語](README_jp.md)

# Im E Motion Plus

A datapack that manipulates the motion of players and mobs using the enchant `apply_impulse`.

Please refer to [this site](https://clpc.club/e_motion) for the values to input.

---

This datapack is a fork of [ImpulseMotion](https://github.com/nea-c/ImpulseMotion) by nea-c and [PlayerMotion](https://github.com/Hirobao1/CustomEnchant_PlayerMotion) by Hirobao1.

Due to major internal processing changes, the user experience and behavior under identical tick operations differ.

## Support for 26.3 and Later

Following Impulse Motion r2 released by nea-c for 26.3 (an update keeping pace with Mojang's bug fixes for `apply_impulse`), this fork has also been fully adapted to the 26.3-series API. See below for details.

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
> Please refer to [this site](https://clpc.club/e_motion).
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

# Changes

## Mojang-Side Changes
- **MC-303493**: A bug where `apply_impulse` "does not apply components in the direction of collision." Fixed in 26.3 Snap.4.
- **MC-303789**: A bug where using `apply_impulse` while looking straight up causes effects on the X/Z axes to apply to only one of the two horizontal axes. Fixed as well.
- Along with these fixes, because local-to-world conversion via `direction` now functions correctly on Mojang's side, it is no longer necessary to always perform local-to-world conversion manually (formerly `vector_get`) when `is_looking` is true. However, because `direction` is based on the "subject's own direction," manual conversion via calculation is still necessary only when the execution direction differs from the subject's direction (such as with `rotated`). This fork determines whether the directions match (`looking/ctx_frame` / `looking/act_frame`) and converts **only when they differ** (`looking/convert` → `local_to_world` → `world_to_local`). When they match (normal calls like `execute as .. at @s`), no conversion overhead is incurred, and the values are passed precisely.
- To achieve direct xyz specification (absolute world coordinates), inverse conversion (world-to-local) is still required (since `direction` is always interpreted locally based on the direction at the moment of firing).

## Remaining Bugs
- The bugs where **only the Y-axis motion disappears** and **horizontal momentum disappears** remain unresolved in 26.3. These are separate issues from MC-303493.

## Adaptation to Major API Changes
All files were rewritten due to schema changes in 26.3, such as:
- Predicate identification key changed from `condition` to `type`
- Item modifier identification key changed from `function` to `type`
- Description changes for `dimension_type`
- Enchantment effect trigger changed from `location_changed` to `tick`
- Added native vehicle field `vehicle` to `entity_properties` predicate (replacing the old `nbt={RootVehicle:{}}` selector check)
- Added a new NBT source `data modify ... set compute ...` (allowing arithmetic operations to be completed entirely on the NBT side). Knockback and blast resistance multiplier calculations were replaced with this, eliminating the old brute-force fixed-point method of "multiplying by 1000 and dividing by 1000."

### Other Fixes
- Fixed UUID inconsistency with the official version where UUIDs did not match
- Fixed scoreboard inconsistency with the official version
- Completely skipped processing when input values are 0
- Fixed an issue where approximately 6.9% of inputs at 0.0001 increments were off by 1 unit (0.0001)
- Incorporated `is_explosion` (treating as explosion knockback) from official r2
- Fixed `rotated`
- Uploaded 2 missing `.json` files

## ImpulseMotion r2 Comparison
- Lighter enchantment conditions using positional notation
- Measures against clamp omissions after applying multipliers. Official r2 `removed upper and lower limits` (abolished clamping itself), meaning this type of bug no longer occurs (though it incurs a different risk of 32-bit integer overflow).
- Removed the `rotated` syntax when `is_looking: true`

---

## License

See [LICENSE](LICENSE) for details.
