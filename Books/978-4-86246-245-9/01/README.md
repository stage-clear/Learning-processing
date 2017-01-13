# 1. ベクトル

1. [ベクトルなしでは始まらない](#section-1_1)
1. [Processing プログラマーのためのベクトル](#section-1_2)
1. [ベクトル加算](#section-1_3)
1. [その他のベクトル演算](#section-1_4)
1. [ベクトルの大きさ](#section-1_5)
1. [ベクトルの正規化](#section-1_6)
1. [ベクトル運動: 速度](#section-1_7)
1. [ベクトル運動: 加速度](#section-1_8)
1. [static 関数と非 static 関数](#section-1_9)
1. [加速度の対話的処理](#section-1_10)

## <a id="section-1_1"></a>1.1 ベクトルなしでは始まらない

```processing
// Example 1.1: バウンドするボール(ベクトルを使わない場合)

float x = 100; // ボールの位置と高さ
float y = 100;
float xspeed = 1;
float yspeed = 3.3;

void setup() {
  size(640, 360);
  background(255);
}

void draw() {
  background(255);
  
  x = x + xspeed; // ボールを速さに準じて動かす
  y = y + yspeed;
  
  if ((x > width) || (x < 0)) {
    xspeed = xspeed * -1;
  }
  
  if ((y > height) || (y < 0)) {
    yspeed = yspeed * -1;
  }
  
  stroke(0);
  fill(175);
  ellipse(x, y, 16, 16); // 位置(x, y)にボールを表示
}
```

## <a id="section-1_2"></a>1.2 Processing プログラマーのためのベクトル
ベクトルは2つの点の差異であると考えることもできます.

> __新しい位置 = 現在の位置に速度を適用__

```processing
class PVector {
  float x;
  float y;
  
  PVector(float x_, float y_) {
    x = x_;
    y = y_;
  }
}
```

以下のコードは,

```processing
float x = 100;
float y = 100;
float xspeed = 1;
float yspeed = 3.3;
```

以下のように書くことができます.

```processing
PVector location = new PVector(100, 100);
PVector velocity = new PVector(1, 3.3);
```

> 運動のアルゴリズム、 __位置(location) = 位置 + 速度(velocity)__

```processing
x = x + xspeed;
y = y + yspeed;
```

このコードは, 以下のように書き換えることができ __そうです__ .

```processing
location = location + velocity;
```

しかし Processing では, 加算演算子はプリミティブ値しか使えません.

## <a id="section-1_3"></a>1.3 ベクトル加算

ベクトルは一般にボールドで, または上に矢印を付けて表記されています.
ここでは __スカラー__ と区別するために, __ベクトル__ の表記には矢印を使います.

- ベクトル: u→
- スカラー: x

以下の式は

```mathematica
w→ = u→ + v→
```

次のように書くことができます

```mathematica
wx = ux + vx
wu = uy + vy

w→ = (x, y)  
```

```processing
// 別の PVector オブジェクトを引数として受け取る add() という関数を作成します

class Pvector {
  float x;
  float y;
  
  PVector(float x_, float y_) {
    x = x_;
    y = y_;
  }
  
  void add(PVector v) { // 追加箇所
    y = y + v.y;
    x = x + v.x;
  }
}
```

```processing
// Example 1.2: バウンドするボール(PVectorを使った場合)

PVector location;
PVector velocity;

void setup() {
  size(640, 320);
  location = new PVector(100, 100);
  velocity = new PVector(2.5, 5);
}

void draw() {
  background(255);
  
  location.add(velocity);
  
  if ((location.x > width) || (location.x < 0)) {
    velocity.x = velocity.x * -1;
  }
  
  if ((location.y > height) || (location.y < 0)) {
    velocity.y = velocity.y * -1;
  }
  
  stroke(0);
  fill(175);
  ellipse(location.x, location.y, 16, 16);
}
```

- [ ] Exercise 1.1
- [ ] Exercise 1.2
- [ ] Exercise 1.3

## <a id="section-1_4"></a>1.4 その他のベクトル演算
- `add()` - ベクトル加算
- `sub()` - ベクトル減算
- `mult()` - 乗算によるベクトルのスケーリング
- `div()` - 除算によるベクトルのスケーリング
- `mag()` - ベクトルの大きさを計算
- `setMag()` - ベクトルの大きさを設定
- `normalize()` - ベクトルを単位を長さに1に正規化
- `limit()` - ベクトルの大きさを制限
- `heading()` - 角度で表されるベクトルの2Dの方向
- `rotate()` - 指定した角度だけ2Dベクトルを回転
- `lerp()` - 別のベクトルに対する線形補間
- `dist()` - 2つのベクトル（点と見なされる）間のユークリッド距離
- `angleBetween()` - 2つのベクトル間の角度
- `dot()` - 2つのベクトル間のドット積
- `cross()` - 2つのベクトルのクロス積(3次元のみ)
- `random2D()` - ランダムな2Dベクトルを作成
- `random3D()` - ランダムな3Dベクトルを作成

### ベクトル減算

```mathematica
w→ = u→ - v→
```

これは次のように書くことができます.

```mathematica
wx = ux - vx  
wy = uy - vy
```

```processing
void sub(PVector v) {
  x = x - v.x;
  y = y - v.y;
}
```

```processing
// Example 1.3: ベクトル減算
void setup() {
  size(640, 320);
}

void draw() {
  background(255);
  
  PVector mouse = new PVector(mouseX, mouseY); // マウスの位置用の PVector
  PVector center = new PVector(width / 2, height / 2); // ウィンドウの中心用の PVector
  mouse.sub(center); // PVector の減算
  translate(width / 2, height / 2); // ベクトルを表す線を引く
  line(0, 0, mouse.x, mouse.y);
}
```

> __ベクトルの基本的な特性__  
> ベクトルの加算は, 実数の加算と同じ代数規則に従います.  
> 交換法則: `u→ + v→ = v→ + u→`  
> 結合法則: `u→ + (v→ + w→) = (u→ + v→) + w→`  

### ベクトル乗算
ベクトルの乗算と言ったとき, 通常はベクトルの __スケーリング__ を意味します.  
ベクトルに掛けるのは別のベクトルではありません. スカラー値, つまり単一の値であることに注意してください.

```mathematica
w→ = u→ * n
```

これは, 次のように書くことができます.

```mathematica
wx = ux * n  
wy = uy * n  
```

```processing
void mult(float n) {
  x = x * n;
  y = y * n;
}
```

```processing
PVector u = new PVector(-3, 7);
u.mult(3);
```

除算の考え方は乗算とほぼ同じです.
単に乗算記号を除算記号に置き換えるだけです.

```processing
void div (float n) {
  x = x / n;
  y = y / n;
}

PVector u = new PVector(8, -4);
u.div(2);
```

> __ベクトルのその他の特性__  
> 加算と同じく, ベクトルには基本的な乗算の代数規則が当てはまります.  
> 結合法則: `(n * m) * v→ = n * (m * v→)`  
> 分配法則(2個のスカラーと1個のベクトル): `(n * m) * v→ = n * v→ + m * v→`  
> 分配法則(2個のベクトルと1個のスカラー): `(u→ + v→) * n = u→ * n + v→ + n`  

## <a id="section-1_5"></a>1.5 ベクトルの大きさ

ピタゴラスの定理は, __a__ の2乗と __b__ の2乗を足すと __c__ の2乗になる, というものです.

```mathematica
‖v→‖ = √vx * vx + vy * vy
```
つまり, PVector で次のようになります.

```processing
float msg() {
  return sqrt(x * x + y * y);
}
```

```processing
// Example 1.5: ベクトルの大きさ

void setup() {
  size(640, 360);
}

void draw() {
  PVector mouse = new PVector(mouseX, mouseY);
  PVector center = new PVector(width / 2, height / 2);
  mouse.sub(center);
  
  // ベクトルの大きさ(長さ)を得るには mag() 関数を使う.
  // ここでは, ウィンドウの上部に描画された長方形の幅として使用.
  float m = mouse.mag();
  fill(0);
  rect(0, 0, m, 10);
  
  translate(width / 2, height / 2);
  line(0, 0, mouse.x, mouse.y);
}
```

## <a id="section-1_6"></a> 1.6 ベクトルの正規化
ベクトルの場合, 長さが1であるものを標準ベクトルと仮定します.
ベクトルを正規化するには, 任意の長さのベクトルを受け取り, 方向を変えずにその長さを1に変更します.
このように変換したものを __単位ベクトル__ と呼びます.

任意ベクトル `u→` があるとき, その単位ベクトル(`u^`)は次のように求められます.

```mathematica
u^ = u→ ÷ ‖u→‖
```

ベクトルを正規化するときは, 各要素をベクトルで除算します.
例えばベクトルの長さが5であるとします. 5を5で割ると1になりますね.
つまり, 正三角形の斜辺を5で割ってこれを縮小する必要があるということです.
このとき, 隣辺もやはり5で割って縮小されます.

```processing
void normalize() {
  float m = mag();
  div(m);
}
```

ベクトルの大きさが0の場合は, どうすればよいでしょうか?
0で割ることはできません!

```processing
void normalize() {
  float m = mag();
  if (m != 0) {
    div(m);
  }
}
```


```processing
// Example 1.6: ベクトルの正規化

void draw() {
  background(255);
  
  PVector mouse = new PVector(mouseX, mouseY);
  PVector center = new PVector(width / 2, height / 2);
  mouse.sub(center);
  
  // この例では, ベクトルを正規化した後, 画面上で見えるように50を掛けている. 
  // 正規化により, マウスカーソルがどこにある場合でもベクトルの長さは同じ(50)
  mouse.normalize(); 
  mouse.mult(50);
  translate(width / 2, height / 2);
  line(0, 0, mouse.x, mouse.y);
}
```

## <a id="section-1_7"></a> 1.7 ベクトル運動: 速度


## <a id="section-1_8"></a> 1.8
## <a id="section-1_9"></a> 1.9
## <a id="section-1_10"></a> 1.10
