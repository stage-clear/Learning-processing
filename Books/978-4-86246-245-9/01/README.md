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

- ベクトル: `u→`
- スカラー: `x`

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
float mag() {
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
画面上のオブジェクトには位置<sup>(任意の瞬間にオブジェクトがいる場所)</sup>と速度<sup>(ある瞬間から次の瞬間までに移動する距離)</sup>があります.
次のように速度を位置に加算します.

```processing
location.add(velocity);
```
そしてオブジェクトをその位置に描画します.

```processing
ellipse(location.x, location.y, 16, 16);
```

これが「Motion 101」（運動の基礎）です:
1. 位置に速度を加算
2. 位置にオブジェクトを描画

ここでは, 画面上を動くオブジェクトを記述する汎用的なMoverクラスを作成していきます.
ここで, 次の2つの疑問について考える必要があります.

1. Mover(移動オブジェクト)が持つデータは何か?
2. Moverが持つ機能は何か?

Moverオブジェクトは, いずれも `PVector` オブジェクトである `location` と `velocoty` を持ちます.

```processing
class Mover {
  PVector location;
  PVector velocity;
}
```
機能は単純です. Mover は動く必要があり, 表示される必要が有ります.

```processing
class Mover {
  // ...
  void update() {
    location.add(velocity);
  }
  
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x, location.y, 16, 16);
  }
}
```

1つ重要なことを忘れいていました. オブジェクトの __コンストラクタ__ です.

```processing
Mover m = new Mover();

class Mover {
  Mover() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(random(-2, 2), random(-2, 2));
  }
}
```

さて, ウィンドウの端に達したときのオブジェクトの動作を定義する関数を組み込んで, Mover クラスを完成させましょう.
ここでは, 単純に反対側に回り込ませます.

```processing
class Mover {
  // ...
  void checkEdge() {
    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }
    
    if (location.y > height) {
      location.y = 0;
    } else if (location.y < 0) {
      location.y = height;
    }
  }
}
```

これで, Moverクラスは完成です.

```processing
// Example 1.7: Motion 101 (速度)

Mover mover;

void setup() {
  size(640, 360);
  mover = new Mover();
}

void draw() {
  background(255);
  
  mover.update();
  mover.checkEdge();
  mover.display();
}

class Mover {
  PVector location;
  PVector velocity;

  Mover() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(random(-2, 2), random(-2, 2));
  }
  
  void update() {
    location.add(velocity);
  }
  
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x, location.y, 16, 16);
  }
  
  void checkEdge() {
    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }
    
    if (location.y > height) {
      location.y = 0;
    } else if (location.y < 0) {
      location.y = height;
    }
  }
}
```

## <a id="section-1_8"></a> 1.8 ベクトル運動: 加速度
現実世界で見られるような動きにするため, Mover クラスに `acceleration` という `PVector` を追加しましょう.

ここで使用する __加速度__ という言葉の厳密な定義は, __速度の変化の割合__ です.
速度とは, __場所の変化の割合__ でした. ここで作ろうとしているのは, 本質的には「トリクルダウン」の効果です.
__つまり加速度が速度に作用し, 速度が位置に作用します__ 
(この考え方は, 力が加速度に作用し, 加速度が速度に作用し, 速度が位置に影響するという効果を見ていくときにさらに重要になります).

```processing
velocity.add(acceleration);
location.add(velocity);
```

練習として, ここからは私たちが使う「公式」を作っていきましょう.
この後すべてのコード例では, 速度と位置に触れる必要がなくなります(初期化は除きます).
言い換えると, 「加速度を計算し, トリクルダウンの効果を生み出すためのアルゴリズムを考えること」が, 私たちの運動のプログラミングにおける目下の目標です.
加速度を計算する方法を考えていきましょう.

### 加速度の各種アルゴリズム
1. 等加速度
2. 完全にランダムな加速度
3. マウスに向かう加速度

加速度(acceleration)のアルゴリズム #1 の __等加速度__ は, 特に面白みはありません.

```processing
class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration; // <- 加速度で使う新しいPVctor
}
```

`update()` 関数に加速度を組み込みます.

```processing
void update() {
  velocity.add(acceleration); // 運動アルゴリズムが2行に
  location.add(velocity);
}
```

```processing
location = new PVector(width / 2, height / 2);
velocity = new PVector(0, 0);
acceleration = new PVector(-0.001, 0.01);
```

速度ベクトルの大きさを妥当な範囲にしておくには, 加速度の値をごく小さいものにする必要があります.
また, 速度ベクトルの大きさをコントロールするために, PVector の関数 `limit()` 関数も使います.

```processing
velocity.limit(10); // <- limit() 関数でベクトルの大きさを抑制
```

このコードはこういう意味です.

> 速度の大きさは? 10よりも小さければ, そのままでOK. でも10より大きければ, 減らして10にするんだ!

- [x] Exercise 1.4 PVector クラスで使う `limit()` 関数を完成させてください

```processing
void limit(float max) {
  if (mag() > max) {
    normalize();
    mult(max);
  }
}
```

```processing
// Example 1.8: Motion 101(速度と等加速度)
class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration; // <- 加速度がミソ!
  float topspeed; // <- 変数topspeedで速度の大きさを制御
  
  Mover() {
    location = new PVector(width / 2, height / 2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(-0.001, 0.001);
    topspeed = 10;
  }
  
  void update () {
    velocity.add(acceleration); // 速度は加速度によって変化し, topspeed によって制御される
    velocity.limit(topspeed); 
    location.add(velocity);
  }
  
  void display () {}
  void checkEdge() {}
}
```

- [ ] Exercise 1.5 上矢印を押すと加速し, 下矢印を押すとブレーキがかかる車(またはランナー)のシミュレーションを作ってみましょう

次は, 加速度のアルゴリズム #2 の __完全にランダムな加速度__ です.
今度は, オブジェクトのコンストラクタで加速度を初期化するのではなく, サイクルごとに, つまり `update()` が呼び出される度に, 新しい加速度を取得します.

```processing
// Example 1.9: Motion 101 (速度とランダムな加速度)
void update() {
  acceleration = PVector.random2D(); // `random2d()` 関数は, ランダムな方向を指す長さ1のPVectorを返す
  
  velocity.add(acceleration);
  velocity.limit(limit);
  location.add(velocity);
}
```

ランダムなベクトルは正規化されているので, 次のようにスケーリングします.

(a) 加速度を定数値にスケーリング

```processing
acceleration = PVector.random2D();
acceleration.mult(0.5); // <- 等加速度:
```

(b) 加速度をランダムにスケーリング

```processing
acceleration = PVector.random2D();
acceleration.mult(random(2)); // <- ランダムな加速度:
```
- [ ] Exercise 1.6 「はじめに」を参照し, パーリンノイズに準じた加速度を実装してください:

```processing
class Mover {
  float latestAcceleration;
  
  Mover() {
    // ...
    latestAcceleration = random(2);
  }
  
  void update() {
    // ...
    float a = noise(latestAcceleration);
    acceration.mult(noise(a));
    latestAcceleration = a;
    // ...
  }
}
```

## <a id="section-1_9"></a> 1.9 static 関数と非 static 関数
PVector クラスの使用についてもう一つ理解しておくべきことがあります.
__static__ (静的) メソッドと __非static__ メソッドの使用の違いです.

次のコードを見てください.

```processing
float x = 0;
float y = 5;

x = x + y;
```
PVector で同じようなコードを書くのも簡単です.

```processing
PVector v = new PVector(0, 0);
PVector u = new PVector(4, 5);
v.add(u);
```

```processing
float x = 0;
float y = 5;
float z = x + y;
```
PVector での算術演算となると少し複雑です.

```processing
PVector v = new PVector(0, 0);
PVector u = new PVector(4, 5);

PVector w = v.add(u); // 気をつけて! これは間違い!
```

このコードでは目的を果たせないことがわかります.
2つのPVectorオブジェクトを加算し, その結果を新しいPVectorとして返すためには, static な `add()` 関数を使用しなくてはなりません.

クラス名自体で呼び出す関数を, __static関数__ と呼びます.

```processing
PVector.add(v, u);  // <- static    : クラスで呼び出し
v.add(u);           // <- 非static  : オブジェクトインスタンスでの呼び出し
```

Processing で static関数を作成できないので, 初めて見たという方もいるでしょう.
static 関数を使うと, 入力したPVector の値を変更することなく, PVector オブジェクトに対して汎用的な算術演算を行うことができます.
さて, `add()` の static バージョンを作成するとしたら, どのように書けばよいのでしょうか.

```processing
// add の static バージョンでは, 2つのPVector が加算され, 新しい PVector に結果が代入される.
// 下のPVector (vとu) の値は変わらない
static PVector add(PVector v1, PVector v2) {
  PVector v3 = new PVector(v1.x + v2.x, v1.y + v2.y);
  return v3;
}
```

以下のような違いがあります:

- 関数に __static__ のラベルが付いています
- 関数は void 型の戻り値を持たず, PVector を返します
- 関数は v1 と v2 の要素を合計し, 新しく作成した PVector(v3) に割り当て, 戻り値とします

```processing
PVector v = new PVector(0, 0);
PVector u = new PVector(4, 5);
PVector w = v.add(u); // <- これは間違い!
PVector w = PVector.add(v, u);
```

PVector クラスには `add()` `sub()` `mult()` `div()` の static バージョンが用意されています.

- [ ] Exercise 1.7 以下の疑似コードを static 関数または非 static 関数を使用して完成させましょう:
 - PVector v は (1,5) に等しい
 - PVector u は v に 2を掛けたものに等しい
 - PVector w は v から u を引いたものに等しい
 - PVector w を 3で割る

```proccesing
PVector v = new PVector(1, 5);
PVector u = PVector.mult(v, 2);
PVector w = PVector.sub(v, u);
w.div(3);
```

## <a id="section-1_10"></a> 1.10 加速度の対話的処理
加速度のアルゴリズム #3 「__マウスに向かう加速度__」に記述された原則に従って, オブジェクトの加速度を動的に計算します.

何らかの原則や公式に基づいてベクトルを求めたい場合は, 必ず __大きさ__ と __方向__ (direction) の2つを計算します.
ベクトル `(dx, dy)` を求めるには, オブジェクトの位置をマウスの位置から減算するばよいことがわかります

- `dx = mouseX - x`
- `dy = mouseY - y`

これを PVector 構文を使って書き直してみましょう.

```processing
PVector mouse = new PVector(mouseX, mouseY);
PVector dir = PVector.sub(mouse, location);
// 注目! ある点から別の点を指す新しい PVector 
// を求めるため, `sub()` に対する静的参照を使用:
```

これで Mover の位置からマウスの位置までの PVector が得られました.
このベクトルを使って実際にオブジェクトを加速:すると, オブジェクトがマウスの位置に瞬間移動したように見えます.
もちろん, これではよいアニメーションになりません. オブジェクトがマウスに向かってどのくらいすばやく加速するかを決める必要があります.

加速度 PVector の大きさを設定するには, その大きさに関わらず, まずその方向ベクトルを __正規化__ しなくてはなりません.

```processing
float anything = ?????
dir.normalize();
dir.mult(anything);
```

まとめると, 手順は以下のようになります:

- オブジェクトからターゲット位置(マウス)を指すベクトルを計算します.
- このベクトルを正規化します.
- このベクトルを適切な値にスケーリングします(特定の値を掛けます)
- このベクトルを加速度に代入します.

`update()` 関数は以下のようになります.

```processing
// Example 1.10: マウスに向かう加速度

void update() {
  PVector mouse = new PVector(mouseX, mluseY);
  PVector dir = PVector.sub(mouse, location);   // 手順1: 方向を計算
  
  dir.normalize();                              // 手順2: 正規化
  dir.mult(0.5);                                // 手順3: スケーリング
  
  velocity.add(acceleration);                   // 手順4: 加速
  velocity.limit(topspeed);
  location.add(velocity);
}
```

ターゲットに到達しても円が停止しないのはなぜでしょうか?
このオブジェクトは, 目的地で止まるということを知りません.
オブジェクトが知っているのは目的地だけであり, なるべく急いでそこに行こうとしているだけなのです.
あまりにも急いでいるために行き過ぎてしまい, 戻らなくてはなりません.
戻るときにもなるべく急いで目的地に行こうとするため, また行き過ぎてしまい, という繰り返しです.

この例は重力の概念によく似ています(オブジェクトがマウスの位置に引かれています).
ただし, ここでは重力の強さ(加速度の大きさ)が距離に反比例するという点, つまりオブジェクトがマウスに近づくにつれて加速度が増すという点が考慮されていません.:

- [ ] Exercise 1.8 近づいたり遠ざかったりするにつれて強くなる可変の大きさに加速度を, 上の例に組み込んでください

ここまでは1つの Mover を使っていましたが, いくつもの Mover を使うとどうなるでしょうか.

```processing
// Example 1.11: マウスに向かって加速する Mover の一群
Mover[] movers = new Mover[20]; // オブジェクトの配列

void setup() {
  size(640, 360);
  background(255);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(); // 配列内の各オブジェクトを初期化
  }
}

void draw() {
  background(255);
  
  for (int i = 0; i < movers.length; i++) {
    // 配列内のすべてのオブジェクトに対して関数を呼び出し
    movers[i].update();
    movers[i].checkEdge();
    movers[i].display();
  }
}

class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  
  Mover() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
    topspeed = 4;
  }
  
  void update() {
    // 加速度の計算アルゴリズム
    // マウスを指すベクトルを求める
    PVector mouse = new PVector(mouseX, mouseY);
    PVector dir = PVector.sub(mouse, location);
    dir.normalize();  // 正規化
    dir.mult(0.5); // スケーリング
    acceleration = dir; // 加速度に設定
    
    velocity.add(acceleration); // Motion 101 速度は加速度によって変化し:
    velocity.limit(topspeed);   // 位置は速度によって変化する
    location.add(velocity); 
  }
  
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x, location.y, 16, 16);
  }
  
  void checkEdge() {
    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }
    
    if (location.y > height) {
      location.y = 0;
    } else if (location.y < 0) {
      location.y = height;
    }
  }
}
```
