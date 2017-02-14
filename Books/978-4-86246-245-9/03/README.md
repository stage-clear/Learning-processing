# 3. 振動
<sup>_Oscillation_</sup>

- 3.1 [角度](#section-3_1)
- 3.2 [角運動](#section-3_2)
- 3.3 [三角法](#section-3_3)
- 3.4 [運動の方向](#section-3_4)
- 3.5 [極座標とデカルト座標](#section-3_5)
- 3.6 [振動の振幅と周期](#section-3_6)
- 3.7 [角速度を使った振動](#section-3_7)
- 3.8 [波](#section-3_8)
- 3.9 [三角法と力: 振り子](#section-3_9)
- 3.10 [ばね力](#section-3_10)

## <a id="section-3_1"></a> 3.1 角度
__ラジアン__は, 円の半径と円の弧の長さの比率によって定義される角度の単位です.
1ラジアンとは, その比率が1である角度です. 180度 = PIラジアン, 360度 = 2\*PIラジアン, 90度 = PI / 2ラジアンのように表します.

- 180度 `PI`
- 360度 `TWO_PI`

```processing
// 60度回転させたい場合:
float angle = radians(60);
rotate(angle);
```

- [ ] Exercise 3.1
  - `translate()` と `rotate()` を使ってバトンのようなオブジェクトを, 中心を軸として回転させてください.

## <a id="section-3_2"></a> 3.2 角運動

- 角度 = 角度 + 角速度
- 角速度 = 角速度 + 角加速度

```processing
float angle = radians(60);
translate(width / 2, height / 2);
rotate(angle);
line(-50, 0, 50, 0);
ellipse(50, 0, 8, 8);
ellipse(-50, 0, 8, 8);
```

```processing
// Example 3.1: rotate() を使った角運動
float angle = 0;
float aVelocity = 0;
float aAcceleration = 0.001;

void setup() {
  size(640, 360);
}

void draw() {
  background(255);
  
  fill(175);
  stroke(0);
  rectMode(CENTER);
  translate(width/2, height/2);
  rotate(angle);
  line(-50, 0, 50, 0);
  ellipse(50, 0, 8, 8);
  ellipse(-50, 0, 8, 8);
  
  aVelocity += aAcceleration;
  angle += aVelocity;
}
```

Mover オブジェクトに組み込むことができます.
```processing
class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  
  float angle = 0;
  float aVelocity = 0;
  float aAcceleration = 0;
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    
    aVelocity += aAcceleration; // <-
    angle += aVelocity; // <-
    
    acceration.mult(0);
  }
  
  void display() {
    stroke(0);
    fill(175, 200);
    rectMode(CENTER);
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    rect(0, 0, mass * 16, mass * 16);
    popMatrix();
  }
}
```

```processing
float aAcceleration = 0.01;
```

```processing
// Example 3.2: （任意の）角運動を使った力
void update() {
  velocity.add(acceleration);
  location.add(velocity);
  
  aAcceleration = acceleration.x / 10.0;
  aVelocity += aAcceleration;
  aVelocity = constrain(aVelocity, -0.1, 0.1);
  angle += aVelocity;
  
  acceleration.mult(0);
}
```

- [ ] Exercise 3.2
  1. 大砲から発射された物体をシミュレートしてください. この物体は, 発射時に(一度だけ)急激に力と重力(常に存在します)を受けます.
  2. 物体に回転を追加して, 大砲から発射されたときの回転をシミュレートしてください. できるだけリアルなシミュレーションにしてみましょう.

## <a id="section-3_3"></a> 3.3 三角法
__SohCarToa__は正弦(sine:サイン), 余弦(cosine:コサイン), 正接(tangent:タンジェント)の三角関数を, 暗記用に縮めたものです.

- __Soh__: 正弦(s) = 対辺(o) / 斜辺(h)
- __Cah__: 余弦(c) = 隣辺(a) / 斜辺(h)
- __Toa__: 正接(t) = 対辺(o) / 隣辺(a)

<img src="//betterexplained.com/wp-content/uploads/trig/sohcahtoa-bleh.png" width="300">

## 3.4 運動の方向

- 正接の定義: `tangent(angle) = velocity.y / velocity.x`

この問題点は, 速度が分かっていて角度がわからないことです.
角度を知る必要があります. ここで__逆正接__と呼ばれる特殊な関数の出番です.
__アークタンジェント__, __tan<sup>-1</sup>__と呼ばれることあります.

値aの正接が値bと等しい場合, bの逆正接はaと等しくなります.

```
if    tangent(a) = b
then  a = arctangent(b)
```

「逆」になっていることが分かりましたか? これで角度の問題は解決します.

```
if    tangent(angle) = velocity.y / velocity.x
then  angle = arctangent(velocity.y / velocity.x)
```

## <a id="section-3_4"></a> 3.4 
## <a id="section-3_5"></a> 3.5 
## <a id="section-3_6"></a> 3.6 
## <a id="section-3_7"></a> 3.7 
## <a id="section-3_8"></a> 3.8 
## <a id="section-3_9"></a> 3.9 
## <a id="section-3_10"></a> 3.10 
