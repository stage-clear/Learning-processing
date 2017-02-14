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

## <a id="section-3_4"></a> 3.4  運動の方向

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

式が完成したので, Mover の `display()` 関数を見てみましょう.
Processing の逆正接の関数は `atan()` です.

```processing
Mover {
  // ...
  void display() {
    float angle = atan(velocity.y / velocity.x); // atan() を使って角度を解決
    
    stroke(0);
    fill(175);
    pushMatrix();
    rectMode(CENTER);
    rotate(angle); // 解決した角度だけ回転
    rect(0, 0, 30, 10);
    popMatrix();
  }
}
```

2つの正反対のベクトルに, 角度を解決するための式を適用してみると, 次のようになります.

- V1 : `angle = atan(3 / -4) = atan(-0.75) = -0.643501109 = -37度`
- V2 : `angle = atan(-3 / 4) = atan(-0.75) = -0.643501109 = -37度`

なんと, 2つのベクトルの角度は同じになります.
実は, これはコンピュータグラフィックの世界ではよくある問題です.
いくつもの条件文と `atan()` を組み合わせて正か負か判断することもできますが, Processing には `atan2()` という便利な関数が用意されています.

```processing
Mover {
  // ...
  void display() {
    float angle = atan2(velocity.y, velocity.x); // atan2() を使って, 考え得るすべての方向に対応
    
    stroke(0);
    fill(175);
    pushMatrix();
    rectMode(CENTER);
    translate(location.x, location.y);
    rotate(angle);
    rect(0, 0, 30, 10);
    popMatrix();
  }
}
```

これをさらに簡潔にするため, PVectorクラスには `atan2()` を呼び出す `heading()` 関数があります.

```processing
float angle = velocity.haeading(); // 一番簡単な方法がこれ!
```

- [ ] Exercise 3.3
  - 矢印キーを使って画面を動き回らせることのできる車のシミュレーションを作成してください. 左矢印キーを押すと左方向に加速し, 右矢印キーを押すと右方向に加速します. 車は常に現在の方向を向きます.

## <a id="section-3_5"></a> 3.5 極座標とデカルト座標

- デカルト座標: ベクトルの__x__成分, __y__成分
- 極座標: ベクトルの大きさ(長さ)と方向(角度)

Processing の描画関数では, 極座標は認識されません.
Processing で何かを表示するためには, __(x, y)__のデカルト座標で位置を指定する必要があります.

```mathematica
sin(theta) = y / r  →  y = r * sin(theta)
cos(theta) = x / r  →  x = r * cos(theta)
```

例えば, rが75でΘが45度(PI/4ラジアン)である場合, x 及び y を次のように求めます.

```processing
float r = 75;
float theta = PI / 4;
float x = r * cos(theta);
float y = r * sin(theta);
```

このような変換が役に立つ場合があります.
例えば, 円弧に沿って何かを動かす場合にデカルト座標を使うのは容易ではありませんが, 極座標を使えば簡単です.
角度を増やしていくだけでよいのですから!

以下は, グローバル変数 r 及び theta を使った方法です.

```processing
float r = 75;
float theta = 0;

void setup() {
  size(640, 360);
  background(255);
}

void draw() {
  float x = r * cos(theta); // ellipse関数で使用するため, 極座標(r, theta) からデカルト座標に変換
  float y = r * sin(theta);
  
  noStroke();
  fill(0);
  ellipse(x + width / 2, y + height / 2, 16, 16);
  
  theta += 0.01;
}
```

- [ ] Exercise 3.4 
  - 例3.4を利用して, 中心から外に向かって進むらせん軌道を描いてください. 1行を変更し, 1行を追加するだけです.
```processing
+ flaot r = 0;
- float r = 75;

+ r += 0.05;
```

- [ ] Exercise 3.5
  - ゲーム「Asteroids」の宇宙をシミュレートしてみましょう. 「Asteroids」をご存じない方は, 次のような宇宙船を作ってみてください.
    その宇宙船(三角形で表します)は2次元空間に浮かんでいて, 左矢印キーを押すと反時計回りに回転し, 右矢印キーを押すと時計回りに回転します.
    [Z]キーを押すと推進力が加えられ, 進行方向に進みます.

## <a id="section-3_6"></a> 3.6 振動と振幅の周期

- 正接の利用法 - ベクトルの角度を確認
- 正弦および余弦の利用法 - 極座標からデカルト座標への変換

正弦と余弦の用途は, 数式と直角三角形の範囲にとどまりません.

`y = sin(x)`の正弦関数を見てみましょう.

このような2転換の周期的な動きを__振動__(Oscillation)と言います.
ギターの弦をはじく, 振り子を揺らす, ホッピングで跳ねるなどは, すべて振動運動です.

- __振幅(Amplitude)__: 運動の中心からどちらかの端までの距離
- __周期(Period)__: 1つの運動サイクルにかかる時間

正弦のグラフを見ると, 振幅は 1, 周期は TWO_PI です.
正弦の出力が 1 を上回ることも -1 を下回ることもなく, 同じ波のパターンが TWO_PI ラジアン(360度)ごとに繰り返されます.


```processing
float amplitude = 100;  // 距離の単位はピクセル
float period = 120;     // 周期の単位はフレーム(アニメーションの時間の単位)
```

振幅と周期が分かったら, xを時間の関数として計算する式を記述します.

```processing
float x = amplitude * cos(TWO_PI * frameCount / period);
```

余弦は-1から1までの間で振動することが分かっています.
その値に振動を掛ければ, 負の振動から正の振動までを行き来する値が得られます.

余弦関数の中身を見てみましょう.

```processing
TWO_PI * frameCount / period
```

| frameCount | frameCount / 周期 | TWO_PI * frameCount / 周期|
|:---:|:---:|:------:|
|  0  |  0  |   0    |
|  60 | 0.5 |   PI   |
| 120 |  1  | TWO_PI |
| 240 |  2  | 2\*TWO_PI (4\*PI)|
| ... |     |        |

`frameCount`を`period`で割ると, その時点で完了しているサイクル数がわかります.

```processing
// Example 3.5: 単振動
void setup() {
  size(640, 360);
}

void draw() {
  background(255);
  
  float period = 120;
  float amplitude = 100;
  float x = amplitude * cos(TWO_PI * frameCount / period);
  // 単振動の式に従って水平の位置を計算
  
  stroke(0);
  fill(175);
  translate(width / 2, height / 2);
  line(0, 0, x, 0);
  ellipse(x, 0, 20, 20);
}
```

- [ ] Exercise 3.6
  - 正弦関数を使って, ウィンドウの上部からばねにつるすおもりのシミュレーションを作成してください.
    `map()`関数を使って, おもりの垂直位置を計算します. この章の後半では, フックの法則を使って同じシミュレーションを行う方法を確認します.

## <a id="section-3_7"></a> 3.7 角速度を使った振動
## <a id="section-3_8"></a> 3.8 
## <a id="section-3_9"></a> 3.9 
## <a id="section-3_10"></a> 3.10 
