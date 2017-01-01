# セルオートマトンが作る迷路
## ルール

## 配列の準備
```processing
int[][] Cells = new int[102][102];
int[][] newCells = new int[102][102];
int[][] rule = {
  { 0, 0, 0, 1, 0, 0, 0, 0, 0 },
  { 1, 1, 1, 1, 1, 0, 0, 0, 0 }
};
```

## 表示 - `display()`
```processing
if (Cells[i][j] == 1) {
  fill(0);
} else {
  fill(255);
}
rect((i - 1) *  5, (j - 1) * 5, 5, 5);
```

```processing
for (int i = 1; i <= 100; i++) {
  for (int j = 1; j <= 100; j++) {
    if (Cells[i][j] == 1) {
      fill(0);
    } else {
      fill(255);
    }
    rect((i - 1) * 5, (j - 1) * 5, 5, 5);
  }
}
```

`clear()` 関数はすべてのセルを0すなわち白にします.

```processing
for (int i = 0; i <= 101; i++) {
  for (int j = 0; j <= 101; j++) {
    Cells[i][j] = 0;
  }
}
display();
```

## 境界処理 - `boundary()`
外側にある仮装セルの処理を行います.
```processing
Cells[i][0] = Cells[i][100];
Cells[i][101] = Cells[i][1];

// 左右
Cells[0][i] = Cells[100][i];
Cells[101][i] = Cells[1][i];
```

## 更新 - `update()`
内部にあるすべての[, それぞれの近傍にある1すなわち黒のセルの数を調べ, ルールを参照して次の時刻の状態を決定します.

```processing
nei = Cells[i - 1][j -1] + Cells[i][j - a] + Cells[i + 1][j - 1]
    + Cells[i - 1][j] + Cells[i + 1][j]
    + Cells[i - 1][j * 1] + Cells[i][j + 1] + Cells[i + 1][j + 1]
```

```processing
newCells[i][j] = rule[tar][nei];
```

```processing
// 内部のすべてのセルに対して行います
for (int i = 1; i <= 100; i++) {
  for (int j = 1; j <= 100; j++) {
    tar = Cells[i][j];
    nei = Cells[i - 1][j - 1] + Cells[i][j - 1] + Cells[i + 1][j - 1]
        + Cells[i - 1][j] + Cells[i + 1][j]
        + Cells[i - 1][j + 1] + Cells[i][j + 1] + Cells[i + 1][j + 1];
    newCells[i][j] = rule[tar][nei];
  }
}
```

```processing
// セルの状態がすべて決定したら, これらを Cells にコピーします.
for (int i = 1; i <= 100; i++) {
  for (int j = 1; j <= 100; j++) {
    Cells[i][j] = newCells[i][j];
  }
}
```

## マウス
```processing
int i = mouseX / 5 + 1;
int j = mouseY / 5 + 1;
```

```processing
if (Cells[i][j] == 0) {
  Cells[i][j] = 1;
} else {
  Cells[i][j] = 0;
}
```

## `setup()` 関数と `draw()` 関数
```processing
void setup() {
  size(505, 500);
  noStroke();
  frameRate(30);
  clear();
}

void draw() {
  if (keyPressed) {
    if (key == 'e') {
      update();
    }
  }
}
```

```processing
// 最終的なコード
int[][] Cells = new int[102][102];
int[][] newCells = new int[102][102];
int[][] rule = {
  { 0, 0, 0, 1, 0, 0, 0, 0, 0 },
  { 1, 1, 1, 1, 1, 0, 0, 0, 0 }
};

void setup() {
  size(505, 500);
  noStroke();
  frameRate(30);
  clear();
}

void draw() {
  if (keyPressed) {
    if (key == 'e') {
      update();
    }
  }
}

void display() {
  for (int i = 1; i <= 100; i++) {
    for (int j = 1; j <= 100; j++) {
      if (Cells[i][j] == 1) {
        fill(0); // 1なら黒を設定する
      } else {
        fill(255); // 0なら白を設定する
      }
      rect((i - 1) * 5, (j - 1) * 5, 5, 5); // セルを描画する
    }
  }
}

void clear() {
  for (int i = 0; i <= 101; i++) {
    for (int j = 0; j <= 101; j++) {
      Cells[i][j] = 0; // すべて白にする
    }
  }
  display();
}

void boundary() { // 周期境界条件を設定する
  for (int i = 0; i <= 101; i++) {
    Cells[i][0] = Cells[i][100];
    Cells[i][101] = Cells[i][1];
    Cells[101][i] = Cells[100][i];
    Cells[101][i] = Cells[1][i];
  }
}

void update() {
  int tar, nei;
  for (int i = 1; i <= 100; i++) {
    for (int j = 1; j <= 100; j++) {
      tar = Cells[i][j];
      nei = Cells[i - 1][j - 1] + Cells[i][j - 1] + Cells[i + 1][j - 1]
          + Cells[i - 1][j] + Cells[i + 1][j]
          + Cells[i - 1][j + 1] + Cells[i][j + 1] + Cells[i + 1][j + 1];
      newCells[i][j] = rule[tar][nei];
    }
  }
  for (int i = 1; i <= 100; i++) {
    for (int j = 1; j <= 100; j++) {
      Cells[i][j] = newCells[i][j];
    }
  }
  boundary();
  display();
}

void mousePressed() {
  int i = mouseX / 5 + 1; // クリックされたセルの列番号を計算する
  int j = mouseY / 5 + 1; // クリックされたセルの行番号を計算する
  if (Cells[i][j] == 0) {
    Cells[i][j] = 1;
  } else {
    Cells[i][j] = 0;
  }
  boundary();
  display();
}
```[


