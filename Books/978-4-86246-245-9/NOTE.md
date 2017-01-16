## The things is should remember.

- __運動のアルゴリズム__: <sup>(Chapter 1)</sup>
 - 新しい位置 = 現在の位置に速度を適用
 - `location(位置) = location + velocity(速度)`
- __ベクトルの長さ__ : <sup>(Chapter 1)</sup>
 - ピタゴラスの定理を使って斜辺の長さを割り出します
 - `‖v→‖ = √vx * vx + vy * vy`
- __ベクトルの正規化__ : <sup>(Chapter 1)</sup>
 - ベクトルの長さで, 各辺を割ります
 - `u^ = u→ / ‖u→‖`
- __Motion 101__ (運動の基礎): <sup>(Chapter 1)</sup>
 1. 位置に速度を加算 _Add velocity to location_
 1. 位置にオブジェクトを描画 _Draw object at location_
- __加速度__ : <sup>(Chapter 1)</sup>
 - 速度の変化の割合
- __速度__ : <sup>(Chapter 1)</sup>
 - 場所の変化の割合
- __加速度の対話的処理__ : <sup>(Chapter 1)</sup>
 1. オブジェクトからターゲット位置（ex.マウス）を指すベクトルを計算します
 2. このベクトルを正規化します.
 3. このベクトルを適切な値にスケーリングします（特定の値を掛けます）
 4. このベクトルを加速度に代入します

## Snippet

- __以前の軌跡を残す__
```
void draw() {
 fill(255, 0);
 rect(0,0, width, height);
 // ...
}
```
