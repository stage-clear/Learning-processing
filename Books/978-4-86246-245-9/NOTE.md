## The things is should remember.

- __運動のアルゴリズム__:
 - 新しい位置 = 現在の位置に速度を適用
 - `location(位置) = location + velocity(速度)`
- __ベクトルの長さ__ :
 - ピタゴラスの定理を使って斜辺の長さを割り出します
 - `‖v→‖ = √vx * vx + vy * vy`
- __ベクトルの正規化__ :
 - ベクトルの長さで, 各辺を割ります
 - `u^ = u→ / ‖u→‖`
- __Motion 101__ (運動の基礎):
 1. 位置に速度を加算 _Add velocity to location_
 1. 位置にオブジェクトを描画 _Draw object at location_
- __加速度__ :
 - 速度の変化の割合
- __速度__ :
 - 場所の変化の割合
- __加速度の対話的処理__ :
 1. オブジェクトからターゲット位置<sup>（ex.マウス）</sup>を指すベクトルを計算します
 1. このベクトルを正規化します.
 1. このベクトルを適切な値にスケーリングします<sup>（特定の値を掛けます）<sup>
 1. このベクトルを加速度に代入します
- __加速度はすべての力の合計を質量で割ったものに等しい__
 - これを実装するためには__力の積算__を行います. これはとても単純で, すべての力を合計するだけです.
- __摩擦__: <sup>摩擦は速度の反対方向を指している</sup>
 - `Friction = -1 * μ * N * v^`

## Word
- __Location__ - 位置
- __Position__ - 位置
- __Velocity__ - 速度
- __Acceleration__ - 加速度
- __Friction__ - 摩擦
- [不平衡力](https://kotobank.jp/word/%E4%B8%8D%E5%B9%B3%E8%A1%A1-776350)
- [散逸力](https://ja.wikipedia.org/wiki/%E6%95%A3%E9%80%B8) - 非保存力
- [摩擦係数](https://ja.wikipedia.org/wiki/%E6%91%A9%E6%93%A6%E5%8A%9B) - (μ). 特定の表面における摩擦力の強さを決定します.

## Snippet

- __以前の軌跡を残す__
```
void draw() {
 fill(255, 0);
 rect(0,0, width, height);
 // ...
}
```
