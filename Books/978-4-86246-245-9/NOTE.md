## The things is should remember.

- __運動のアルゴリズム__:
  - 新しい位置 = 現在の位置に速度を適用
  - 位置 = 位置 + 速度
  - 速度 = 速度 + 加速度
  - `location = location + velocity`
- __ベクトルの長さ__ :
  - ピタゴラスの定理を使って斜辺の長さを割り出します
  - `‖v→‖ = √vx * vx + vy * vy`
- __ベクトルの正規化__ :
  - ベクトルの長さで, 各辺を割ります
  - `u^ = u→ / ‖u→‖`
- __Motion 101__ <sup>(運動の基礎)</sup>:
  1. 位置に速度を加算 `position.add(velocity)`
  1. 位置にオブジェクトを描画
- __加速度__ :
  - 速度の変化の割合
- __速度__ :
  - 場所の変化の割合
  - 速度 = 速度 + 加速度
- __加速度の対話的処理__ :
  1. オブジェクトからターゲット位置<sup>（ex.マウス）</sup>を指すベクトルを計算します
  1. このベクトルを正規化します.
  1. このベクトルを適切な値にスケーリングします<sup>（特定の値を掛けます）<sup>
  1. このベクトルを加速度に代入します
- __加速度はすべての力の合計を質量で割ったものに等しい__
  - これを実装するためには__力の積算__を行います. これはとても単純で, すべての力を合計するだけです.
  - __摩擦__: <sup>(摩擦は速度の反対方向を指している)</sup> <sup>([説明](https://github.com/stage-clear/Learning-processing/blob/master/Books/978-4-86246-245-9/02/README.md#section-2_7))</sup>
  - `Friction = -1 * μ * N * v^`
- __抗力__: <sup>([説明](https://github.com/stage-clear/Learning-processing/blob/master/Books/978-4-86246-245-9/02/README.md#section-2_8))</sup>
  - `Fd = ‖v‖2 * cd * v * -1`
  - 抗力は, __抗力係数に Mover の速さの2乗を掛けて, 向きを速度の反対にしたものと同じ__です.
- __重力__:
  - `F = G * m1 * m1 / (r2) * r^`
  - F: 重力, G: 万有引力定数, m1: 物体1, m2: 物体2, r^: 物体1から物体2への単位ベクトル, r2: 2つの物体の距離を2乗したもの
- __ニュートンの運動の第1法則__:
  - 静止している物体は静止状態を続け, 運動している物体は運動を続ける
- __ニュートンの運動の第2法則__:
  - 質量に加速度を掛けると力になる
  - `F→ = M * A→` `A→ = F→ / M`
- __ニュートンの運動の第3法則__:
  - すべての作用には, 大きさが同じで向きが反対の反作用がある
- __度数からラジアンに変換する方法__:
  - `radian = 2 * PI * (degree / 360)`
- __角度__:
  - 角度 = 角度 + 角速度
  - 角速度 = 角速度 + 角加速度
- __正接__:
  - tangent(angle) = velocity.y / velocity.x`
- __デカルト座標__: ベクトルの__x__成分, __y__成分
- __極座標__: ベクトルの大きさ(長さ)と方向(角度)

## Words
- __Location__ - 位置
- __Position__ - 位置
- __Velocity__ - 速度
- __Acceleration__ - 加速度
- __Friction__ - 摩擦
- __Gravity__ - 重力
- __Attraction__ - 引力
- [不平衡力](https://kotobank.jp/word/%E4%B8%8D%E5%B9%B3%E8%A1%A1-776350)
- [散逸力](https://ja.wikipedia.org/wiki/%E6%95%A3%E9%80%B8) - 非保存力
- [摩擦係数](https://ja.wikipedia.org/wiki/%E6%91%A9%E6%93%A6%E5%8A%9B) - (μ). 特定の表面における摩擦力の強さを決定します
- [垂直抗力](https://ja.wikipedia.org/wiki/%E5%9E%82%E7%9B%B4%E6%8A%97%E5%8A%9B) _normal force_(N) - 表面上を動く物体の運動に直交する力
- [粘性力](https://ja.wikipedia.org/wiki/%E7%B2%98%E5%BA%A6) _viscous force_, [抗力](https://ja.wikipedia.org/wiki/%E6%8A%97%E5%8A%9B) _drag force_, [流体抵抗]() _fluid resistance_
  - すべて同じことを意味します
- [誘導抗力](https://ja.wikipedia.org/wiki/%E7%BF%BC%E5%B9%85%E8%8D%B7%E9%87%8D) - 速度ベクトルの垂直方向にはたらく抗力
- [トルク](https://ja.wikipedia.org/wiki/%E3%83%88%E3%83%AB%E3%82%AF)
- [慣性モーメント](https://ja.wikipedia.org/wiki/%E6%85%A3%E6%80%A7%E3%83%A2%E3%83%BC%E3%83%A1%E3%83%B3%E3%83%88)

 
## Snippets

- __以前の軌跡を残す__
```processing
void draw() {
 fill(255, 0);
 rect(0,0, width, height);
 // ...
}
```
