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

ベル型曲線を生成するには, 起こりうるあらゆる値の確率を __平均__ (通常はギリシャ文字 μ <sup>ミュー</sup> で表記)と
__標準偏差__ (ギリシャ文字で σ <sup>シグマ</sup> で表記) の相関的要素として定義する数学関数です.

平均についてはご存知の通りです.  
標準偏差についてはどうでしょう.
標準偏差が非常に低い分布では, 値の大半が平均値の近くに集まります. 標準偏差が高い場合は, 値は平均から均等に広がります.

> 標準偏差は, 各要素について平均値との差を求めて2乗し, それらの平均を出したものの平方根です.
> つまり, 各個人について平均tonosawomotome, それぞれを2乗します(分散).
> これらの値の平均を求め, その平方根が標準偏差です.

## Example list
- [RandomWalkTraditional2](./RandomWalkTraditional2/) 
- [RandomWalkTraditional3](./RandomWalkTraditional3/)
- [RandomWalk](./RandomWalk/) - Draw rectangle on random position
- [RandomWalkPVector](./RandomWalkPVector/) - Draw rectangle on random position with PVector
- [RandomWalkTrail](./RandomWalkTrail/) - Draw rectangle and tail line
- [RandomWalkTrailCurve](./RandomWalkTrailCurve/) - Draw circle and tail line
- [RandomWalkLevy](./RandomWalkLevy/) - Draw line
- [RandomWalkerNoise](./RandomWalkerNoise/) - Draw line
