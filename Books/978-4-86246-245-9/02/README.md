# Chapter 2. 力

1. [力とニュートンの運動の法則](#section-2_1)
2. [力と Processing - 関数としてのニュートンの第２の法則](#section-2_2)
3. [力の積算](#section-2_3)
4. [質量](#section-2_4)
5. [力の作成](#section-2_5)
6. [地球と重力と力のシミュレーション](#section-2_6)
7. [摩擦](#section-2_7)
8. [空気抵抗と流体抵抗](#section-2_8)
9. [重力](#section-2_9)
10. [相互引力と反発](#section-2_10)

## <a id="section-2_1"></a>2.1 力とニュートンの運動の法則
> __力とは__, 質量を持った物体に加速を生じさせる__ベクトルである__

### ニュートンの運動の第1法則
> 静止している物体は静止状態を続け, 運動している物体は運動を続ける

ただし, これには力に関する重要な要素が不足しています.

> 静止している物体は静止状態を続け, 運動している物体は, 不平衡力の影響を受けない限り, 一定の速さで一定の方向に運動を続ける

Processing の世界では, ニュートンの運動の第1法則を次のように言い換えることができます.

> オブジェクトの PVector の速度は, オブジェクトが釣り合った状態にある場合には一定のままである.

### ニュートンの運動の第3法則
> すべての作用には, 大きさが同じで向きが反対の反作用がある

第3法則の記述をもう少しうまく言うと, 次のようになるでしょう.

> 力は必ず対になって発生する. 2つの力の強さは等しく, 向きは反対である

### ニュートンの第３法則 （Processing の観点から）
> オブジェクトAのオブジェクトBに対する力 `PVector f` を計算する場合, 
> オブジェクトAに対するオブジェクトBの力(`PVector.mult(f, -1)`) も適用する必要がある

ただし, Procssing プログラミングの世界では, 常にこの法則通りである必要はありません  
私たちは単に自然世界の物理にヒントを得ているだけであり, すべてを精密にシミュレーションしようというわけではないのです.

## <a id="section-2_2"></a>2.2 力と Processing - 関数としてのニュートンの第2法則
### ニュートンの運動の第2法則
> 質量に加速度（acceleration）を掛けると力になる

すなわち:

```mathematica
F→ = M * A→
```

これが私たちにとって最も重要な法則であるのはなぜでしょうか?
ちょっと書き方を変えてみましょう.

```mathematica
A→ = F→ / M
```

加速度は力に比例し, 質量は反比例します.
つまり, あなたが押された場合, その力が強いほど早く動く（加速する）ということです.
そして, あなたが大きいほど, ゆっくり動きます.

> __重量と質量__
> - 物体の__質量__は, 物体内の物質の量を表します.  
> - __重量__はよく質量と混同されますが, 厳密には物体にかかる重力です.
    ニュートンの第2法則から, 重量は質量 × 重力加速度(w = m * g)として求めることができます.
    重量の単位はニュートン(N)です
> - __密度__は, 単位体積あたりの質量です.  
> 地球上で1キログラムの質量を持つ物体は, 月でも1キログラムの質量を持ちます.
> しかし,その重量は6分の1になります.

Processing の世界で言う質量とはなんでしょうか?
ここでは単純化して, 私たちの仮想のピクセル世界では, すべての物体の質量が1であるとしましょう.
`F / 1 = F` です. つまり:

```mathematica
A→ = F→
```

となり, オブジェクトの加速度は力と等しいということになります.

ここからは, すべての始まりが__力__であることを見ていきます.

位置, 速度, 加速度を持った Mover クラスを使いましょう.

```processing
class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
}
```

ここでの目標は, この物体に力を加えることです.
例えば, 次のようにします.

```processing
mover.applyForce(wind);
```

または,

```processing
mover.applyForce(gravity);
```

`wind` と `gravity` は `PVector` です. ニュートンの第2法則により, この関数は次のように実装することができます.

```processing
void applyForce(PVector force) {
  acceleration = force; // 最も単純な形のニュートンの第2法則
}
```

## <a id="section-2_3"></a>2.3 力の積算
`acceleration = force` は, ニュートンの第2法則をそのまま変形したものです（質量を考慮していません）.
しかし, これには大きな問題があります. 私たちの目的を思い出してください.
風と重力に反応する, 画面上を動くオブジェクトを作ることです.

```processing
mover.applyForce(wind);
mover.applyForce(gravity);
mover.update();
mover.display();
```

ここに大きな問題が! 速度に加算されるときの, 加速度の値はなんでしょうか?
`gravity` と同じです. 風が無視されています! `applyForce()` を何回か呼び出すと, 前回の呼び出しが上書きされてしまうのです.
複数の力を扱うにはどうしたらよいでしょうか?

実を言うと, 先ほどのニュートンの第2法則は単純化したものでした.
正確には以下のようになります.

> 質量に加速度を掛けると合力 (net force) になる

つまり, 加速度は__すべての力の合計__を質量で割ったものに等しいということです.  
これを実装するためには, __力の積算__を行います. これはとても単純で, すべての力を合計するだけです.
ある瞬間に存在する力は, 1個かもしれませんし, 2個かもしれません, 6個, 12個, もしくは303個かもしれません.
オブジェクトがこれらの積算方法を認識している限り, 何個の力がはたらいても構いません

```processing
void applyForce(PVector force) {
  acceleration.add(force); // ニュートンの第2法則. ただし力の積算を行うすべての力を加速度に1つずつ加算
}
```

まだ終わりではありません. 力を積算する場合には, もう1つするべきことがあります.
ある瞬間におけるにおけるすべての力を合計しているため, `update()` を呼び出す前に毎回, 加速度をクリアする必要があります.

```processing
if (mousePressed) {
  PVector wind = new PVector(0.5, 0);
  mover.applyForce(wind);
}
```

各フレームで加速をクリアするためには, `update()` の最後で `PVector` に0を掛けると簡単です.

```processing
void update() {
  velocity.add(acceleration);
  location.add(velocity);
  acceleration.mult(0);
}
```

- [ ] __Exercise 2.1__ 
 - 力を使って, ヘリウムが入った風船が浮かび上がり, ウィンドウの上部でバウンドするところをシミュレートしてください.
   パーリンノイズなどを使って, 時間とともに変化する風力を追加してみましょう.

## <a id="section-2_4"></a>2.4 質量
ニュートンの第2法則が `A→ = F→` ではなくて, 実際には `F→ = M * A→` であるということは分かりました.
質量を（_mass_）を組み込むのは簡単で, クラスにインスタンス変数を追加するだけです.

```processing
class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass; // <- 質量を浮動小数点として追加
}
```

> __計測単位__  
> 現実世界では, 何かを計測するときには特定の単位を使います.  
> 例えば, 2つの物体の距離は3メートルだ, 今の球速は90マイルだ, このボーリングの球の重さは6キログラムだ, などと言います.
> 私たちの計測単位はピクセルと, アニメーションフレームです. 質量については, 使用する計測単位が存在しません.

質量は物体内の物質の量を示す1つの数値にすぎず, ベクトルではなくスカラーです.
ここでは, 例えばシェイプの面積を質量として扱うこともできますが, もっと簡単に, 
「このオブジェクトの質量は?うーん...10にしておくか!」というところから始めます.

```processing
Mover() {
  location = new PVector(random(width), random(height));
  velocity = new PVector(0, 0);
  acceleration = new PVector(0, 0);
  mass = 10.0;
}
```

それほど面白みはありませんが, はじめのうちは仕方ありませんね.
質量はどこで登場するのでしょうか?
オブジェクトにニュートンの第2法則を適用するところです.

```processing
void applyForce(PVector force) {
  force.div(mass); // ニュートンの第2法則(力の積算と質量を考慮):
  acceleration.add(force);
}
```

これでもよさそうですが, ここにもまた大きな問題があります.
2つのMoverオブジェクトがあり, どちらも風の力で吹き飛ばされる, という設定について考えてみましょう

```processing
Mover m1 = new Mover();
Mover m2 = new Mover();

PVector wind = new PVector(1, 0);

m1.applyForce(wind);
m2.applyForce(wind);
```

オブジェクトの使用に関して, 「オブジェクト（ここでは `PVector`）を関数に渡すとき, 実際に渡しているのはそのオブジェクトの参照である」という格言があります.

```processing
void applyForce(PVector force) {
  PVector f = force.get(); // <- 使用する前に PVector のコピーを作成
  f.div(mass)
  acceleration.add(f);
}
```

static メソッド `div()` を使ってこの関数を使用する方法もあります.

- [x] __Exercise 2.2__ `applyForce()` メソッドを, `get()` の代わりに static メソッド `div()` を使って書き換えてください

```processing
void applyForce(PVector force) {
  PVector f = PVector.div(force, mass)
  acceleration.add(f);
}
```

## <a id="section-2_5"></a>2.5 力の作成
これまでの成果を振り返ってみましょう.
力の正体（ベクトル）がわかりました.
オブジェクトに力を適用する方法（質量で除算し, オブジェクトの加速度ベクトルに加算する）も分かりました.
足りないものは何でしょうか? そう, そもそもの力はどうやって得たらよいかがまだ分かっていません. 力はどこからやって来るのでしょう?

Processing の世界で力を作るための2つの方法を紹介します.

1. __力を作り出す__: プログラマーであるあなたが創造主です. 力を作り出してそれを適用してはいけない理由はありません.
2. __力をシミュレートする__: そう, 力は現実の世界に存在し, 物理の教科書には力の公式が書かれています. その公式をソースコードに組み込めば, Processing で現実世界の力を模倣することができます.

力を作るための最も簡単な方法は, 数値を選ぶというものです.
```processing
// 右向きのかなり弱い風をシミュレートすることを考える
PVector wind = new PVector(0.01, 0);
m.applyForce(wind);
```

風と重力のように, 2つの力が必要な場合には, 次のように書くことができます.

```processing
// Example 2.1: 力
PVector wind = new PVector(0.01, 0);
PVector gravity = new PVector(0, 0.1);
m.applyForce(wind);
m.applyForce(gravity);
```

次に, 質量がそれぞれ違う異なるたくさんのオブジェクトを追加して, この例をもう少し面白くしていきましょう.

```processing
class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass; // <- オブジェクトは質量を持つ!
 
  Mover() {
    mass = 1; // <- 単純化するため質量を1に設定
    location = new PVector(30, 30);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }
 
  void applyForce(PVector force) { // <- ニュートンの第2法則:
    PVector f = PVector.div(force, mass); // 力を受け取って質量で除算し, 加速度に加算
    acceleration.add(f);
  }
 
  void update() {
    velocity.add(acceleration);     // Motion 101
    location.add(velocity);
    acceleration.mult(0);           // 加速を毎回クリアする処理を追加!
  }
 
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x, location.y, mass * 16, mass * 16);
    // 質量に応じてサイズをスケーリング
  }
 
  void checkEdges() {
    // ウィンドウの端にぶつかったオブジェクトのバウンドを若干恣意的に決定
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      location.x = 0;
      velocity.x *= -1;
    }

    if (location.y > height) {
      // 位置と速度には直接触れないと述べたが, 一部例外あり.
      // ここでは, 端に達したオブジェクトの方向を簡単に反転させるため,
      // 位置と速度を直接操作
      location.y = height;
      velocity.y *= -1;
    }
  }
}
```

配列を使って `Mover` オブジェクトを100個作りましょう.

```processing
Mover[] movers = new Mover[100];
```

そして `setup()` でループを使って100個の `Mover` オブジェクトを初期化します

```processing
void setup() {
  for (int i = 0; i < mover.length; i++) {
    movers[i] = new Mover();
  }
}
```

ここでちょっと問題があります.
`Mover` オブジェクトのコンストラクタを見直してみましょう.

```processing
Mover() {
  mass = 1; // すべてのオブジェクトの質量が1に, 位置が(30,30) になる:
  location = new PVector(30, 30);
  // ...
}
```

さまざまな質量の `Mover` オブジェクトを, さまざまな位置に生成するためには,
引数を追加して, コンストラクタの洗練度を上げる必要があります.

```processing
Mover(float m, float x, float y) {
  // 引数を使ってこれらの変数を設定
  mass = m;
  location = new PVector(x, y);
}
```

```processing
void setup() {
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0, 1.5), 0, 0);
  }
}
```

```processing
// Example 2.2: 多数のオブジェクトに作用する力
void draw() {
  background(255);
 
  PVector wind = new PVector(0.01, 0);
  PVector gravity = new PVector(0, 0.1); // 2つの力を作成
 
  for (int i = 0; i < movers.length; i++) {
    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);
    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
}
```
この実行結果では, 小さい円の方が, 大きい円よりも早くウィンドウの右に到達していることに注目してください.
これは, 運動の第2法則, __加速度 = 力 / 質量__によるものです. 質量が大きいほど加速度は小さくなります.

- [ ] __Exercise 2.3__ 
 - オブジェクトが壁の端で跳ね返るのではなく, 見えない力がはたらいてウィンドウから出ないように押し戻されるという例を作成してください.
   例えば, 端に近づくほど力が強くなるなど, 端から距離に準じて力に重みを付けてみましょう.

## <a id="section-2_6"></a>2.6 地球の重力と力のシミュレーション
重力はオブジェクトの質量に比例して計算されます. オブジェクトが大きいほど, 力は強くなるのです.
このため, 質量に従って力をスケーリングすると, 加速度を質量で割ったときに相殺されます.
これをスケッチに組み込むには, 求められた重力に質量を掛けます

```processing
// Example 2.3: 重力を質量でスケーリング

for (int i = 0; i < movers.length; i++) {
  PVector wind = new PVector(0.001, 0);
  float m = movers[i].mass;
  PVector gravity = new PVector(0, 0.1*m); // より正確にするため 重力を質量でスケーリング
  movers[i].applyForce(wind);
  movers[i].applyForce(gravity);

  movers[i].update();
  movers[i].display();
  movers[i].checkEdges();
}
```

オブジェクトの落下速度は等しくなりましたが, 風力の強さは質量とは無関係であるため, オブジェクトが右に向かう時の加速は小さいものほど速いままです.

高校の物理の教科書を開けば, そこに重力, 電磁気, 摩擦, 張力, 弾性など, さまざまな力を説明する図や公式が載っています.
今後の処理に生かすための事例として, この2つの力については以下の点を考慮しながら見ていきましょう

- 力の背後にある概念を理解する
- 力の公式を次の2つに分けて考える
  - 力の方向をどう計算するか?
  - 力の大きさをどう計算するか?
- これらの公式を `PVector` を計算する Processing コードとして記述し, この `PVector` を `Mover` の `applyForce()` 関数を通じて適用する

> __公式に扱い方__  
> - __右辺を評価し, 左辺に代入します__
> - __ベクトルかスカラーか?__
> - __記号と記号が隣り合っている場合, これらは乗算されることを意味します__

## <a id="section-2_7"></a>2.7 摩擦
まずは摩擦(Friction)から見ていきましょう.

摩擦は__散逸力__（非保存力）です. 散逸力がはたらいている場合, 物体が動いていると, システムの総エネルギーが減少します.  
摩擦を完全なモデルで考えると, 静止摩擦<sup>（表面に対して停止している物体）</sup>と動摩擦<sup>（表面に対して動いている物体）</sup>の
2種類に分けられますが, ここでは目的に合わせて動摩擦だけを見ていきます.

```mathematica
摩擦 = -1 * μ * N * v^:
```

__摩擦は速度の反対方向を指している__ことが `-1 * v^` で分かります.
Processing では速度ベクトルを取得し, これを正規化して, -1を掛けます.

```processing
PVector friction = velocity.get();
friction.normalize();
friction.mult(-1);
// 摩擦力の方向を求める（速度の反対方向の単位ベクトル）
```

公式によると, 大きさは `μ * N` です. μ はギリシャ文字で__mu__（_ミュー_）で, ここでは__摩擦係数__を表します.
摩擦係数は, 特定の表面における摩擦力の強さを決定します. 
この係数が大きいほど摩擦は強くなり, 小さいほど弱くなります.

私たちは仮想的な Processing の世界にいるので, どの程度の摩擦をシミュレートしたいかによって恣意的に摩擦係数を設定することができます.

```processing
float c = 0.01;
```

次は2つ目の要素, __N__です. __N__は＿＿垂直抗力__(_normal force_)を表します.
これは, 表面上を動く物体の運動に直交する力です.
ニュートンの第3法則によれば, 道路も車を押し返します. これが垂直抗力です.
重力が大きくなるほど垂直抗力も大きくなります.

これらを使わなくても Processing では「十分な」シミュレーションを作成することができます.
例えば, 垂直効力の大きさが常に1であると仮定して摩擦を機能させることができます.
ここでは次のようにしておきましょう.

```processing
float normal = 1;
```

これで摩擦の大きさと方向が分かりました. これを次のようにまとめましょう.

```processing
float c = 0.01;
float normal = 1;
float frictionMag = c * normal; // <- 摩擦の大きさ（ここでは任意の定数）を求める

PVector friction = velocity.get();
friction.mult(-1);
friction.normalize();

friction.mult(frictionMag); // <- 単位ベクトルを取得し, これに大きさを掛けて力のベクトルを求める
```

これを「力」の例に追加します.

```processing
void draw() {
  background(255);
 
  PVector wind = new PVector(0.001, 0);
  PVector gravity = new PVector(0, 0.1); // <- より正確にするために質量でスケーリング
 
  for (int i = 0; i < movers.length; i++) {
    float c = 0.01;
  
    PVector friction = movers[i].velocity.get();
    friction.mult(-1);
    friction.normalize();
    friction.mult(c);
  
    movers[i].applyForce(friction); // <- 摩擦力のベクトルをオブジェクトに適用
    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);
    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
}
```

- [ ] __Exercise 2.4__ 
 - Processing スケッチに摩擦地帯をいくつか作成し, 物体が摩擦地帯を通過するときにだけ摩擦がかかるようにしてください.
   摩擦地帯ごとに強さ（摩擦係数）を変えるとどうなるでしょうか? また一部の摩擦地帯には逆方向の摩擦を付けて, その摩擦地帯に入ると高速化するようにしてみましょう.

## <a id="section-2_8"></a>2.8 空気抵抗と流体抵抗
物体が液体や気体を通り抜けるときにも摩擦がはたらきます.
この力は__粘性力__(_viscous force_), __抗力__(_drag force_), __流体抵抗__(_fluid resistance_)など, さまざまな名前で呼ばれることがありますが, すべて同じことを意味ます.
引き起こされる結果は摩擦の例と同じですが, 抗力の計算方法が少し異なります.:

```mathematica 
// 大きさは速度の2乗 * 抗力係数:
Fd = -1/2ρv2ACdv^
```

- `Fd` は__抗力__を表します - これが最終的に求めて `applyForce()` に渡したいベクトルです.
- `-1/2`は定数`-0.5`です. 私たちが構築している Processing の世界では, その他の定数の値は何らかの形で調整しているので, この値のままでは適切ではありません. ただし, これが負の値であるという事実は重要です(力の向き速度と反対であることが分かります.)
- ρ はギリシャ文字の__rho__（ロー）で, 流体の密度を示します. これは考慮する必要のない場合もあります. 単純化するため, ここでは定数1と見なしましょう
- v は物体が移動する速さを表します. これは, お分かりですね! 物体の速さは速度ベクトルの大きさ, つまり `velocity.magnitude()` です. また `v2` は単に `v` の2乗, つまり `v * v` を意味します.
- A は, 液体（または気体）を押して進む物体の全面の面積を表します. 私たちが行おうとしている基本的なシミュレーションでは, オブジェクトを球であると見なし, この要素は無視します.
- Cd は抗力係数で, 摩擦係数(ρ)と全く同じです. 抗力係数は, 作り出そうとしている抗力の強弱に基づいて私たちが決定します.
- v^ については見覚えがありますか? それもそのはず, これは速度の単位ベクトル, つまり `velocity.normalize()` を表します. 摩擦と同じように, 抗力は速度の反対方向を指す力です.

```mathematica
Fd = ‖v‖2 * cd * v * -1
```

コードにすると次のようになります.

```processing
float c = 0.1;
float speed = v.mag();
float dragMagnitude = c * speed * speed; // <- 公式の前半部分（大きさ）: Cd * v2
PVector drag = velocity.get();
drag.mult(-1);                           // <- 公式の後半部分(向き): -1 * 速度
drag.normalize();
drag.mult(dragMagnitude);                // 大きさと向きを結合
```
それでは, Mover クラスに1追加してこの力を組み込みましょう.
摩擦の例を作成したとき, 摩擦の力は常に存在していました. 物体が動いている場合, 摩擦によって必ず速度が低下します.
さて, ここで環境に要素「液体（Liquid）」を追加しましょう.

```processing
class Liquid {
  flaot x, y, w, h; // Liquid オブジェクトには, 抗力係数を定義する変数が含まれる:
  float c;
 
  Liquid(float x_, float y_, float w_, float h_, float c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }
  
  void display() {
    noStroke();
    fill(175);
    rect(x, y, w, h);
  }
}
```

メインプログラムには, __Liquid__オブジェクトの参照と, そのオブジェクトを初期化する1行のコードを追加します.

```processing
Liquid liquid;

void setup() {
  liquid = new Liquid(0, height/2, width, height/2, 0.1);
  // Liquid オブジェクトを初期化. 係数が小さい(0.1)ことに注目
  // こうしないとオブジェクトは, かなり早い時点で停止してしまう.
  // (そのような効果が必要な場合もある)
}
```

`Mover` オブジェクトどうやって `Liquid` オブジェクトと対話させるのでしょうか? 
ここで私たちがシミュレートしたいことは次の通りです

> Mover オブジェクトが液体を通り抜けるとき, 抗力がかかる

オブジェクト指向で表現すると次のようになります.

```processing
if (liquid.contains(movers[i])) {
  PVector dragForce = liquid.drag(movers[i]); // <- 抗力を計算
  movers[i].applyForce(dragForce);            // Mover に抗力を適用
}
```

このコードから `Mover` クラスに2つクラスを追加する必要があることが分かります.
`Mover` オブジェクトが `Liquid` オブジェクト内にあるかどうかを判定する関数と, `Mover` オブジェクトに適用する抗力です.

1つ目の関数は簡単です. 位置ベクトルga `liquid` によって定義された長方形の中にあるかどうかを, 単に条件文を使って判定します.

```processing
boolean contains() {
  PVector l = m.location;
  return l.x > x && l.x < x + w && l.y > y && l.y < y + h;
  // PVector の位置が Liquid クラスによって
  // 定義された長方形の中にあるかどうかを判定
}
```

抗力は, __抗力係数に Mover の速さの2乗を掛けて, 向きを速度の反対にしたものと同じ__です.

```processing
PVector drag(Mover m) {
  float speed = m.velocity.mag();
  float dragMagnitude = c * speed * speed; // 力の大きさ: 抗力係数 * 速さの2乗
 
  PVector dragForce = m.velocity.get();
  dragForce.mult(-1);                      // 力の向き: -1 * 速度
 
  dragForce.normalize();
  dragForce.mult(dragMagnitude);           // 力の最終決定: 大きさと向きをまとめる
  return dragForce;
}
```

この2つの関数を Mover クラスに追加したら, メインタブでひとまとめにします.

```processing
// Example 2.5: 流体抵抗
Mover[] movers = new Mover[9];

Liquid liquid;

void setup() {
  size(640, 360);
  reset();
  liquid = new Liquid(0, height / 2, width, height / 2, 0.1); 
}

void draw() {
  background(255);
  
  liquid.display();
  
  for (int i = 0; i < movers.length; i++) {
    if (liquid.contains(movers[i])) {             // Mover は Liquid 内にあるか?
      PVector dragForce = liquid.drag(movers[i]); // 抗力を計算
      movers[i].applyForce(dragForce);            // Mover 抗力を適用
    }
    
    PVector gravity = new PVector(0, 0.1 * movers[i].mass); // 質量に準じて重力をスケーリング
    movers[i].applyForce(gravity);                // 重力を適用
    
    movers[i].update();                           // 表示を更新
    movers[i].display();
    movers[i].checkEdges();
  }
}
```

- [ ] __Exercise 2.5__
  - もう一度, 簡略化した抗力の公式を見てください. __抗力 = 係数 * 速さ * 速さ__です.
    オブジェクトの移動速度が遅いほど, それに対する抗力も大きくなります. 実際, 水中で静止しているオブジェクトに抗力が全くかかりません.
    この例を応用して, 異なる高さからボールを落としてみましょう. 高さが異なることで, ボールが水に衝突したときの抗力にどのような影響がありますか?
- [ ] __Exercise 2.6__
  - 抗力の公式には, 表面も含まれていました. 水に当たる辺の長さに準じた抗力を考慮して, 箱を水に落とした場合のシミュレーションを作成してください.
- [ ] __Exercise 2.7__
  - 流体抵抗は速度ベクトルの反対方向だけでなく, 速度ベクトルの垂直方向にもはたらきます.
    これは「誘導抗力」と呼ばれ, 角度の付いた翼を持った飛行機が上昇するのはこのためです. 上昇のシミュレーションを作成してみましょう.

## <a id="section-2_9"></a>2.9 重力
以下は, これらの力の強さを計算するための公式です.
<img src="https://userscontent2.emaze.com/images/7dd09fd6-ad38-470a-8c7c-dd15425571a8/959ab801-b554-49e1-9346-3203d578eedc.jpg" width="200" height="auto">
<sup>(書籍の図では最後に `r^` を掛けています)</sup>

- F は重力を表します. これは, 私たちが最終的に求めて `applyForce()` に渡したいベクトルです.
- G は__万有引力定数__です. これは私たちの世界では 6.67428×10<sup>-11</sup>立方メートル毎キログラム毎秒毎秒です.
  しかし, Processingプログラマーにとっては重要な数値ではありません. これも, 私たちが作り出す世界の力の強弱を決めるために使用する定数です.
  これを1にしたり, 無視したりするのも悪くない選択です.
- m1とm2は物体1と物体2の質量です. ニュートンの第2法則(`F→ = M × A→`)で見たように, 質量はやはり無視しても構わないものです.
  しかし, これらの値を持っていることで, 小さい物体よりも「大きい」物体にかかる重力の方が強いという, 面白みのあるシミュレーションを作成することができます.
- r<sup>^</sup>は, 物体1から物体2への単位ベクトルを表します. この後見ていきますが, この方向ベクトルは, 1つの物体からもう1つの物体の位置を減算することによって求めることができます.
- r<sup>2</sup>は, 2つの物体間の距離を2乗したものを表します.  
  この公式上のすべて, つまり G, m1, m2 において、値が大きいほど力が強くなります.
  質量が大きいと, 力が大きい. Gが大きいと, 力が大きい. ただし, 何かで割ったときは逆になります.
  力の強さは, 距離の2乗に反比例します. オブジェクトが__遠い__ほど力が__弱く__なり, __近い__ほど__強く__なります.:

Processing コードで表す方法を考えていきましょう.

物体が2つあり:

1. それぞれの位置を持ちます : `PVector location1` と `PVector location2`
2. それぞれに質量を持ちます : `float mass1` と `float mass2`
3. 万有引力定数を表す変数を `float G` とします

これらを前提として, 重力 `PVector force` を計算したいのです.
その処理は2つに分けて行います. 前半部分で力 `r^` の向きを計算します.
後半部分では, 質量と距離に準じた力の強さを計算します.

ベクトルは2点間の差です. ベクトルを作成するには, 単純に1つの点からもう1つの点を減算します.

```processing
PVector dir = PVector.sub(location1, location2);
dir.normalize();
```

求めたいのは方向だけを示す単位ベクトルであるため, 位置を減算した後にベクトルを__正規化__する必要があります.

これで向きが求められました. 続いて大きさを計算し, それに応じてベクトルをスケーリングします.

```processing
float m = (G * mass1 * mass2) / (distance * distance);
dir.mult(m);
```

残る問題はただ1つ. 距離がわからないことです.
G, mass1, mass2 はすべて与えられていますが, 上のコードを機能させるためには, 実際に距離を計算する必要あります.
つい先ほど, 1つの位置から1つの位置を指すベクトルを作りませんでしたっけ?
そのベクトルの長さは, 2つの物体の間の距離ですよね.

そう, 正規化する前にたった1行を追加し, そのベクトルの大きさを取得しておけば距離がわかるのです.

```processing
PVector force = PVector.sub(location1, location2); // 1つの物体からもう1つの物体を指すベクトル
float distance = force.magnitude(); // <- このベクトルの長さ（大きさ）が2つのオブジェクト間の距離
float m = (G * mass1 * mass2) / (distance * distance); // 重力の公式を使って力の強さを求める

force.normalize(); // 力ベクトルを正規化して適切な大きさにスケーリング
force.mult(m);
```

最終的には, はじめに使った `PVector` こそがずっと求めていた実際の力のベクトルになるのです.

Prcessing スケッチの適所に当てはめていきます.

- `Mover` オブジェクト - `Attractor` オブジェクトに向かう引力が作用します.
- `Attractor` オブジェクト

```processing
class Attractor {
  float mass; // Attractor は移動しない単純なオブジェクト. 必要なのは質量と位置のみ
  PVector location;
  
  Attractor() {
    location = new PVector(width / 2, height / 2);
    mass = 20;
  }
  
  void display() {
    stroke(0);
    fill(175, 200);
    ellipse(location.x, location.y, mass * 2, mass * 2);
  }
}
```

メインプログラムに `Attractor` クラスのインスタンスを追加します.

```processing
Mover m;
Attractor a;

void setup() {
  size(640, 360);
  m = new Mover();
  a = new Attractor(); // Attractor オブジェクトを初期化
}

void draw() {
  background(255);
  
  a.display(); // Attractor オブジェクトを描画
  
  m.update();
  m.display();
}
```

このパズルを完成するための最後のピースは, 一方のオブジェクトにもう一方のオブジェクトを引き付けさせる方法です.
これにはいくつかの方法があります.

- `Attractor`と`Mover`の両方を受け取る関数 - `attraction(a, m)`
- `Mover`を受け取る`Attractor`クラスの関数 - `a.attract(m)`
- `Attractor`を受け取る`Mover`クラスの関数 - `m.attractedTo(a)`
- `Mover`を受け取って`PVector`（引力）を返す`Attractor`クラスの関数. この引力を`Mover`の`applyForce()`関数に渡します. - `PVector f = a.attract(m); m.applyForce(f)`

つまり, 以前は次のように処理していたところを:

```processing
PVector f = new PVector(0.1, 0); // 力の作成
m.applyForce(f);
```

次のようにします.

```processing
PVector f = a.attract(m); // 2つのオブジェクト間の引力
m.applyForce(f);
```

このため, `draw()` 関数は以下のようになります.

```processing
void draw() {
  background(255);
  
  PVector f = a.attract(m); // 引力を計算して適用
  m.applyForce(f);
  
  m.update();
  
  a.display();
  m.display();
}
```

`attract()` 関数を `Attractor` クラス内に置くことにしたため, 実際にこの関数を書く必要があります.

```processing
PVector attract(Mover m) {

}
```

さて, この関数の中に何を記述しますか? 重力について解き明かした, あの素晴らしい式です!

```processing
PVector attract(Mover m) {
  PVector force = PVector.sub(location, m.location); // 力の向きは?
  float distance = force.mag();
  force.normalize();
  float strength = (G * mass* m.mass) / (distance * distance); // 力の大きさは?
  force.mult(strength);
  
  return force; // 適用できるよう, 力を返す!
}
```

ちょっとした問題が1つあります. 
除算の記号を見たら必ず自分に問いかける必要があります.
もしこの値がひどく小さい値だったら, または（もっと悪いことに）ゼロだったら, 一体どうなるだろうか, と.

数値をゼロで割れないということはよろしいですね.
さらに, 例えば 0.0001 で割るということは, 10,000 を掛けるのと同じです.

このため, この公式を使うときは, `distance` の可能な範囲を制限するのが妥当です.

```processing
distance = constrain(distance, 5, 25);
```

最小距離を制限する必要があるのと同じ理由で, 最大距離も制限すると有効です.
例えば `Attractor` オブジェクトから500px以上離れたりすると(ありえないことではありません), 力を25,000で割ることになります.
この力は最終的に非常に弱くなり, まったく適用していないのと変わりません.

```processing
// Example 2.6: 引力
Mover m;
Attractor a;

void setup() {
  size(640, 360);
  m = new Mover();
  a = new Attractor();
}

void draw() {
  background(255);
  
  PVector force = a.attract(m);
  m.applyForce(force);
  m.update();
  
  a.display();
  m.display();
}

class Attractor {
  float mass;
  PVector location;
  float G;
  
  Attractor() {
    location = new PVector(width / 2, height / 2);
    mass = 20;
    G = 0.4;
  }
  
  PVector attract(Mover m) {
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    distance = constrain(distance, 5.0, 25.0); // 円が制御不能にならないよう, 距離を制御
    force.normalize();
    float strength = (G * mass * m.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }
  
  void display() {
    stroke(0);
    fill(175, 200);
    ellipse(location.x, location.y, mass * 2, mass * 2);
  }
}
```

```processing
// Example 2.7: 引力(多数のMoverがある場合):
Mover[] movers = new Mover[10]; // Mover を10倍に!

Attractor a;

void setup() {
  size(400, 400);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.1, 2), random(width), random(height));
  }
  a = new Attractor();  
}

void draw() {
  background(255);
  
  a.display();
  
  for (int i = 0; i < movers.length; i++) {
    PVector force = a.attract(movers[i]); // 各 Moverオブジェクトについて引力を計算
    movers[i].applyForce(force);
    
    movers[i].update();
    movers[i].display();
  }
}
```

- [ ] __Exercise 2.8__ :
  - 上の例には, `Mover`オブジェクトのシステム(配列)と1つの`Attractor`オブジェクトがあります.
    `Mover`オブジェクトと`Attractor`オブジェクトの両方のシステムがある例を作成してください.
    `Attractor`オブジェクトを見えなくするとどうなるでしょう? `Attractor`オブジェクトの周りを動くオブジェクトの軌跡から, パターン/デザインを作成してみてください.
    「[Metropop Denim project by Clayton Cubitt and Tom Carden](https://processing.org/exhibition/works/metropop/)」を参考にしてください.
- [ ]: __Exercise 2.9__:
  - 重力をモデルとして, 独自の力を作り出すこともできます.
    この章では, 重力を利用したスケッチの作成だけを勧めているわけではありません. 
    むしろ, 物体の動作を操るオリジナルの法則を生み出す方法を工夫してみるべきです.
    例えば, 近づくほど弱く, 遠ざかるほど強くなる力をデザインするとどうなるでしょうか?
    または, 遠くにあるオブジェクトを引き寄せ, 近くにあるオブジェクトを遠ざけるような `Attractor` オブジェクトをデザインしてみたらどうでしょう?
  
## <a id="section-2_10"></a>2.10 相互引力と反発
