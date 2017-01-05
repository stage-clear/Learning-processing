# はじめに
## ランダムウォーク

## ランダムウォーカークラス
- [Objects \ Processing.org](https://processing.org/tutorials/objects/) - オブジェクト指向プログラミングについて

__クラス__ は, オブジェクトの実際のインスタンスを構築するために使う定型です.
クラスはクッキーの抜き型, オブジェクトは抜き出されたクッキーのようなものだと考えることができます.

```processing
class Walker {
  int x;
  int y;
}
```

すべてのクラスにはコンストラクタが必要です.
```processing
class Walker {
  //..
  Walker() {
    x = width / 2;
    y = height / 2;
  }
}
```

クラスにはデータとともに機能も定義できます.

```processing
class Walker {
  //..
  //..
  void display() {
    stroke(0);
    point(x, y);
  }
  
  void step() {
    int choise = int(random(4)); // 0, 1, 2, 3 のいずれか
    
    if (choise == 0) { // ランダムな選択によってステップの方向を決定
      x++;
    } else if (choise == 1) {
      x--;
    } else if (choise == 2) {
      y++;
    } else {
      y--;
    }
  }
}
```

これでクラスが完成しました.

```processing
Walker w; // Walker オブジェクト
```

[Example I.1: 典型的なランダムウォーク](./NOC_I_1_RandomWalkTraditional/)

```processing
void setup() {
  size(640, 360);
  w = new Walker();
  background(255);
}

void draw() {
  w.step(); // Walker の関数を呼び出す
  w.display();
}
```

このランダムウォーカーにはいくらか改良の余地があります.
1つは, Walker の進行方向が上, 下, 左, 右の4つに限られていることです.
ウィンドウ内のピクセルには隣接するピクセルが8つあり, 同じ場所にとどまるという第9の選択肢もあります.

```processing
// Walker.pde
void step() {
  int stepx = int(random(3) - 1); // -1, 0, 1 のいずれかを生成
  int stepy = int(random(3) - 1);
  x += stepx;
  y += stepy;
}
```

```processing
// Walker.pde
void step() {
  float stepx = random(-1, 1);
  flaot stepy = random(-1, 1);
  x += stepx;
  y += stepy;
}
```

[Example I.2: ランダム値の分布](./NOC_I_2_RandomDistribution/)

```processing
int[] randomCounts;

void setup() {
  size(640, 240);
  randomCounts = new int[20];
}

void draw() {
  background(255);
  
  int index = int(random(randomCounts.length));
  randomCounts[index]++;
  stroke(0);
  fill(175);
  int w = width / randomCounts.length;
  for (int x = 0; x < randomCounts.length; x++) {
    rect(x * w, height - randomCounts[x], w - 1, randomCounts[x]);
  }
}
```

## 確率と非一様分布
`random()` 関数を使ったコード内で事象が起こる確率に偏りを持たせる方法がいくつかあります.
その1つは, 数値の選択肢を配列に入れ, 確率を高くしたい選択肢の要素を複数にしておくというものです.

```processing
int[] stuff = new int[5];
stuff[0] = 1; // 選ばれる確率を高くするために1を配列に2回格納
stuff[1] = 1;
stuff[2] = 2;
stuff[3] = 3;
stuff[4] = 3;
int index = int(random(stuff.length)); // 配列からランダムな要素を選択
```

もう1つの方法として, まずランダム値(ここでは単純に, 0から1までのランダムな浮動小数点値のみ)を求め, このランダム値の範囲に従って事象を発生させることもできます.

```processing
float prob = 0.10;    // 確率10%
float r = random();   // 0から1までのランダムな浮動小数点値
if (r < prob) {       // 取得したランダム値が0.1よりも小さい場合はもう一度
  // もう一度!
}
```
- 0.00~0.60 (60%) → 結果A
- 0.60~0.70 (10%) → 結果B
- 0.70~1.00 (30%) → 結果C

```processing
float num = random(1);

if (num < 0.6) {          // ランダム値が 0.6 未満なら
  println("Outcome A");
} else if (num < 0.7) {   // 0.6 以上 0.7 未満なら
   println("Outcome B");
} else {                  // 0.7 以上なら
  println("Outcome C");
}
```

この方法を使うと, →に移動する傾向があるランダムウォーカーを作成することができます.
次の確率を持った `Walker` を考えてみましょう.

- 上へ移動する確率: 20%
- 下へ移動する確率: 20%
- 左へ移動する確率: 20%
- 右へ移動する確率: 40%

```processing
float num = random(1);

if (num < 0.4) {
  x++;
} else if (num < 0.6) {
  x--;
} else if (num < 0.8) {
  y++;
} else {
  y--;
}
```

## ランダム値の正規分布
平均付近に集中するような値の分布を「正規」分布と呼びます.
またの名を「ガウス(Gaussian)」分布と言い, フランスびいきの方に「ラプラス(Laplacian)」分布と呼ばれることもあります.

- [図1.2: ベル型曲線](Figure_I_2_BellCurve)

ベル型曲線を生成するには, 起こりうるあらゆる値の確率を __平均__ (通常はギリシャ文字 μ <sup>ミュー</sup> で表記)と
__標準偏差__ (ギリシャ文字で σ <sup>シグマ</sup> で表記) の相関的要素として定義する数学関数です.

平均についてはご存知の通りです.  
標準偏差についてはどうでしょう.
標準偏差が非常に低い分布では, 値の大半が平均値の近くに集まります. 標準偏差が高い場合は, 値は平均から均等に広がります.

> __平均と標準偏差の計算__  
> 標準偏差は, 各要素について平均値との差を求めて2乗し, それらの平均を出したものの平方根です.
> つまり, 各個人について平均tonosawomotome, それぞれを2乗します(分散).
> これらの値の平均を求め, その平方根が標準偏差です.

ランダム値の正規分布を Processing スケッチで使用する場合に, これらの計算を自分で行う必要はありません.
`Random` という名前のクラスを利用すればよいのです. このクラスを利用するためには,
コード内で `import java.util.Random` と記述して Java ライブラリをインポートします.

- [JavaDocs](http://docs.oracle.com/javase/6/docs/api/java/util/Random.html)

```processing
import java.util.Random;
Random generator; // 乱数ジェネレーターのようなものを作成するので, 変数名を generator とする

void setup() {
  size(640, 360);
  generator = new Random();
}

void draw() {
  float num = (float) generator.nextGaussian(); // <-
  // ガウスランダム値を要求 
  // (nextGaussian() は double値を返すため, float値への変換が必要)
}
```

`nextGaussian()` 関数は, ランダム値の正規分布を返す際のパラメータとして, __平均値0__ と __標準偏差1__ を使用します.
例えば平均を320px, 標準偏差を60pxとしましょう.

[Example I.4: ガウス分布](./NOC_I_4_Gaussian/)

```processing
void draw() {
  float num = (float) generator.nextGaussian(); // `nextGaussian()` double値を返す
  float sd = 60;
  float mean = 320;

  flaot x = sd * num + mean; // 標準偏差を乗算し平均を加算

  noStroke();
  fill(255, 10);
  ellipse(x, 180, 16, 16);
}
```

## ランダム値のカスタム分布
ランダム値を一様分布にもガウス分布にもしたくない場合があります.  
お気付きのように, ランダムウォーカーは既に訪れた場所に何度も戻ってきます（これを __オーバーサンプリング__ と言います）.

このような問題を避けるための戦略の1つが, ときどきステップサイズをかなり大きくするという方法です.
そうすればランダムウォーカーは特定の場所をランダムに探し回りながらも定期的に大きくジャンプするので, オーバーサンプリングの量を減らすことができます.
このランダムウォークのバリエーション（ __レヴィフライト__ と呼ばれます）には, あらかじめ準備した確率ひとそろいが必要です.

```processing
float r = random(1);
if (r < 0.01) { // 長距離の確率は1%
  xstep = random(-100, 100);
  ystep = random(-100, 100);
} else {
  xstep = random(-1, 1);
  ystep = random(-1, 1);
}
```

しかしこうすると, 特定数のオプションの確率が減ります. より汎用的なルールを作りたい場合, つまり大きい数ほど選ばれやすくするにはどうすればよいでしょうか?
3.145は3.144よりも, ほんの少しではありますが, より選ばれやすくしたいのです. 
言い換えると, xがランダムな値である場合に, y = x として可能性をy軸にマップしたいのです.

方法の1つとして, ランダム値を1tudehanaku2つ選択する方法が考えられます.
1つ目のランダム値は単なるランダム値です. 2つ目のランダム値は, 言わば「ランダム値の判定値」です.
2つ目のランダム値を使って, 1つ目のランダム値を使用するか, あるいはこれを破棄して別のランダム値を選択するかを判定します.
判定されやすい値ほど選ばれる頻度を高く, 判定されにくい値ほど選ばれる頻度を低くします.
手順は次の通りです(ここでは, ランダム値の範囲を0~1のみとします).

1. ランダム値(R1)を選びます
2. R1を使用するかどうかを判定する確率Pを計算します. P=R1 としましょう
3. 別のランダム値(R2)を選びます.
4. R2がPよりも小さい場合, 使用する値はR1で決定です.
5. R2がP以上である場合, 手順1に戻ってもう1度やり直す

ここでは, 1つのランダム値が実際に使用される値として判定される確率は, ランダム値そのものと同じです.
R1に0.1を選んだとしましょう. R1が実際に使用される値として判定される可能性は10%です.
R1に0.83を選んだ場合, R1が実際に使用される値として判定される可能性は83%です. 数値が大きいほど, その値が実際に使用される可能性は高くなります.

```processing
// 
float montecarlo() {
  while(true) { // 使用するランダム値が見つかるまで「永遠に」これを実行
    float r1 = random(); // ランダム値を選択
    float probability = r1; // 確率を割り当て
    float r2 = random(); // 2つ目のランダム値を選択
    
    if (r2 < probability) {
      return r1;
    }
  }
}
```

## パーリンノイズ（よりスムーズな手法）
- [図 1.5: ノイズ](./Figure_I_5_Noise1DGraph/)
- [図 1.6: ランダム](./Figure_I_6_RandomGraph/)

Processing ウィンドウのランダムなx軸に円を描くという処理について考えてみましょう.

```processing
float x = random(0, width); // ランダムなx軸
ellipse(x, 180, 16, 16);
```

1次元のパーリンノイズは, 一定の時間における値の一次元シーケンスであると考えることができます.

|時間|ノイズ値|
|:--:|:--:|
|0|0.365|
|1|0.363|
|2|0.363|
|3|0.364|
|4|0.366|

Processing で特定のノイズ値にアクセスするためには, 特定の「時間」を `noise()` 関数に渡す必要があります.

```processing
float n = noise(3);
```

`noise(3)` は, 時間3におけるノイズ値におけるノイズ値0.364を返します.
これをもう少し発展させて, 時間の指定に変数を使い, `draw()` で継続的にノイズ値を求めてみましょう.

```processing
float t = 3;

void draw() {
  flaot n = noise(t); // 特定の時間のノイズ値が必要
  println(n);
}
```

上のコードでは, 何度も同じ値が出力されます.
これは, `noise()` 関数に同じ時間における結果を何度も求めているからです.
時間の変数 `t` をインクリメントしましょう.

```processing
flaot t = 0; // 通常は時間 = 0 から開始するがこれは任意
void draw() {
  float n = noise(t);
  println(t);
  t += 0.01; // ここで時間を進める!
}
```

`t` をインクリメントするスピードもノイズのスムーズさに影響します.
時間の進め方が大きいほど間隔が長くなるため, 値はよりランダムになります.

## ノイズのマッピング
0~1の範囲を持つノイズ値を得られるので, この範囲を使いたい値の範囲にマッピングします.
その最も簡単な方法は, Processing の `map()` 関数を使うことです.

```processing
float t = 0;

void setup() {
  size(300, 360);
}

void draw() {
  float n = noise(t);
  float x = map(n, 0, 1, 0, width); // <- map() を利用してパーリンノイズの範囲をカスタマイズ
  ellipse(x, 180, 16, 16);
  
  t += 0.01;
}
```

- [パーリンノイズウォーカー](./RandomWalkNoise/) - Ecercise 1.7

```processing
class Walker {
  float x, y;
  float tx, ty;;
  
  Walker() {
    tx = 0;
    ty = 10000;
  }
  
  void step() {
    x = map(noise(tx), 0, 1, 0, width); // <- ノイズカラx位置とy位置をマッピング
    y = map(noise(ty), 0, 1, 0, height); // <-
    
    tx += 0.01; // 時間を進める
    ty += 0.01;
  }
}
```

txの初期値は0, tyの初期値は10000になっています.
これはノイズ関数が決定的関数であり, 特定の時間tに対しては, 毎回同じ結果が返されるからです.

## 2次元のノイズ
1次元のノイズでは, 個々の値がその隣接値と近似している一連の値があります.
2次元のノイズでも, 考え方は全く同じです. 違いは, 1次元の線に沿った値ではなく, グリッド上にある値を使用することです.
値はそのすべての隣接値, 上, 下, 左, 右, および斜めにある値と近いものです.

ノイズのそもそもの目的はこれでした. パラメータを少し調整したり, 色を変えてみたりすることで,
大理石や樹木, その他の有機的なテクスチャにより近い見た目の画像を作ることができます.

```processing
loadPixels();

for (int x = 0; x < width; x++) {
  for (int y = 0; y < height; y++) {
    float bright = random(255); // ランダムな明度
    pixels[x + y * width] = color(bright);
  }
}
updatePixels();
```

`noise()` に準じて各ピクセルに色をつける場合も

```processing
float bright = map(noise(x, y), 0, 1, 0, 255); // パーリンノイズの明度
```

## Examples
- [RandomWalkTraditional2](./RandomWalkTraditional2/) 
- [RandomWalkTraditional3](./RandomWalkTraditional3/)
- [RandomWalk](./RandomWalk/) - Draw rectangle on random position
- [RandomWalkPVector](./RandomWalkPVector/) - Draw rectangle on random position with PVector
- [RandomWalkTrail](./RandomWalkTrail/) - Draw rectangle and tail line
- [RandomWalkTrailCurve](./RandomWalkTrailCurve/) - Draw circle and tail line
- [RandomWalkLevy](./RandomWalkLevy/) - Draw line
- [RandomWalkerNoise](./RandomWalkerNoise/) - Draw line
- [Gaussian2](./Gaussian2/) - Exercise 1.4
