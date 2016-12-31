# 相互作用から生まれる貝殻の模様
## 貝殻の模様
周囲の状況を判断して一定のルールで振る舞うことを「局所的なルールに基づく相互作用」という言葉で表現します.

## セルオートマトン

## 配列の準備
一列に並んだセルの左端と右端で計算が破綻しないように, 左右に一つずつ仮装のセルにある1次元のセル空間を考える必要があります.[

```processing
// 実際のセルが100個だとすると要素の数は計102個です.
int[] Cells = new int[102];     // 現在のセル
int[] newCells = new int[102];  // 次のセル
int[] rule = { 0, 1, 1, 1, 1, 0, 0, 0 } // ルール
```

## 初期化 - `initialize()`

```processing
Cells[i] = int(random(0, 1) + 0.5);
// random(0,1) は0から1までの実数をランダムに生成しますから,
// たとえば 0.1 や 0.7 といった値になります. これらに 0.5 を加えると
// それぞれ 0.6, 1.2 となり, これを `int()` で切り捨てて整数かすれば,
// それぞれ 0, 1 となります.
```

```processing
for (int i = 1; i <= 100; i++) {
  Cells[i] = int(random(0, 1) + 0.5);
}
// 仮装セルの設定
// 周期境界条件を設定するため左の仮装セルは [100], 
// 右の仮装セルは [1] と同じ値になるようにします
Cells[0] = Cells[100];
Cells[101] = Cells[1]
```

## 更新 - `evolve()`
`Cells` から `newCells` への変化を計算します.

```processing
// 左右のセルを調べてルール表に適用します
int p = Cells[i - 1] * 4 + Cells[i] * 2 + Cells[i + 1];
newCells[i] = rule[p];
```
`i = 1` から `100` までのすべてに対してこれを実行します.
```processing
for (int i = 1; i <= 100; i++) {
  int p = Cells[i - 1] * 4 + Cells[i] * 2 + Cells[i + 1];
  newCells[i] = rule[p];
}
```

新しいセルの状態が全て決まったら, 元の `Cells` にコピーしましょう.
```processing
for (int i = 1; i <= 100; i++) {
  Cells[i] = newCells[i];
}
```

## 表示 - `dsplay()`

```processing
if (Cells[i] == 1) {
  fill(0);
} else {
  fill(255);
}
```

```processing
rect((i - 1) * 4, (stin - 1) * 4, 4, 4);
// stin はステップ番号を意味しています
```

```processing
for (int i = 1; i <= 100; i++) {
  if (Cells[i] == 1) {
    fill(0);
  } else {
    fill(255);
  }
  rect((i - 1) * 4, (stin - 1) * 4, 4, 4);
}
```

`initialize()` は, はじめの一回だけ実行しますから `setup()` の中で呼び出します.
```processing
void setup() {
  size(400, 480);
  noStroke();
  frameRate(1);
  initalize();
}
```

`display()` `evolve()` は `draw()` の中に書いて120会ずつ呼び出します

```processing
void draw() {
  for (int step = 1; step <= 120; step++) {
    display(step);
    evolve();
  }
}
```

```processing
// 最終的なコード
int[] Cells = new int[102];
int[] newCells = new int[102];
int[] rule = { 0, 1, 1, 1, 1, 0, 0, 0 };

void setup() {
  size(400, 480);
  noStroke();
  frameRate(1);
  initalize();
}

void draw() {
  for (int step = 1; step <= 120; step++) {
    display(step);
    evolve();
  }
}

void initalize() {
  for (int i = 1; i <= 100; i++) {
    Cells[i] = int(random(0, 1) + 0.5);
  }
  Cells[0] = Cells[100];
  Cells[101] = Cells[1];
}

void evolve() {
  for (int i = 1; i <= 100; i++) {
    int p = Cells[i - 1] * 4 + Cells[i] * 2 + Cells[i + 1];
    newCells[i] = rule[p];
  }
  for (int i = 1; i <= 100; i++) {
    Cells[i] = newCells[i];
  }
  Cells[0] = Cells[100];
  Cells[101] = Cells[1];
}

void display(int stin) {
  for (int i = 1; i <= 100; i++) {
    if (Cells[i] == 1) {
      fill(0);
    } else {
      fill(255);
    }
    rect((i - 1) * 4, (stin - 1) * 4, 4, 4);
  }
}
```
