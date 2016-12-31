# 魔法陣とパターンデザイン
## 完全魔法陣
## 配列の準備
4次の魔法陣を `int` 型の変数 `squrare` という名前の2次元配列として格納します.

```processing
int[][] square = {
  { 0, 11, 5, 14 },
  { 7, 12, 2, 9},
  { 10, 1, 15, 4 },
  { 13, 6, 8, 3 }
}
```

## シフト

```processing
// 行のシフトを行う関数 - shiftH()
void shiftH() {
  for (int j = 0; j < 4; j++) {
    buffer[j] = square[0][j];
  }
  for (int i = 1; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      square[i - 1][j] = square[i][j];
    }
  }
  for (int j = 0; j < 4; j++) {
    square[3][j] = buffer[j];
  }
}
```

```processing
// 列のシフトを行う関数 - shiftV()
void shiftV() {
  for (int i = 0; i < 4; i++) {
    buffer[i] 0 square[i][0]
  }
  for (int j = 1; j < 4; j++) {
    for (int i = 0; i < 4; i++) {
      square[i][j - 1] = square[i][j]
    }
  }
  for (int i = 0; i < 4; i++) {
    square[i][3] = buffer[i]
  }
}
```

## 配列と表示
```processing
//
void allocate() {
  for (int l = 0; l < 4; l++) {
    for (int m = 0; m < 4; m++) {
      display();
      shiftV();
      translate(0, 100);
    }
    shiftH();
    translate(100, -400);
  }
}

void display() {
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      float cl = map(square[i][j], 0, 15, 0, 255);
      fill(cl);
      rect(j * 25, i * 25, 25, 25);
    }
  }
}
```

```processing
// キーボードの v を押すと強制的に列のシフトが, 
// h を押すと行のシフトが行われます
void keyPressed() {
  if (key == 'v') {
    shiftV();
  } else if (key == 'h') {
    shiftH();
  }
  redraw();
}
```

```processing
// 最終的なコード
int[][] square = {
  { 0, 11, 5, 14 },
  { 7, 12, 2, 9 },
  { 10, 1, 15, 4 },
  { 13, 6, 8, 3 }
};
int[] buffer = new int[4];

void setup() {
  size(400, 400);
  noLoop(); // draw は自動で繰り返さない
  stroke(255);
}

void draw() {
  allocate(); // 魔法陣を生成して配置する
}

void shiftH() { // 行を入れ替える関数
  for (int j = 0; j < 4; j++) {
    buffer[j] = square[0][j];
  }
  for (int i = 1; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      square[i - 1][j] = square[i][j];
    }
  }
  for (int j = 0; j < 4; j++) {
    square[3][j] = buffer[j];
  }
}

void shiftV() { // 列を入れ替える関数
  for (int i = 0; i < 4; i++) {
    buffer[i] = square[i][0];
  }
  for (int j = 1; j < 4; j++) {
    for (int i = 0; i < 4; i++) {
      square[i][j - 1] = square[i][j];
    }
  }
  for (int i = 0; i < 4; i++) {
    square[i][3] = buffer[i];
  }
}

void allocate() { // 魔法陣を生成して配置する関数
  for (int l = 0; l < 4; l++) {
    for (int m = 0; m < 4; m++) {
      display();
      shiftV();
      translate(0, 100);
    }
    shiftH();
    translate(100, -400);
  }
}

void display() { // 表示する関数
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      float cl = map(square[i][j], 0, 15, 0, 255); // 魔法陣の値0~15を色のデータ0~255に割り当てる
      fill(cl);
      rect(j * 25, i * 25, 25, 25);
    }
  }
}

void keyPressed() {
  if (key == 'v') { // vキーが押されたら, shiftV で列の入れ替え
    shiftV();
  } else if (key == 'h') { // hキーが押されたら, shiftH で行の入れ替え
    shiftH();
  }
  redraw();
}
```

## 画像の利用
```processing
a[0] = loadImage("a0.tif");
a[1] = loadImage("a1.tif");
a[2] = loadImage("a2.tif");
```

```processing
// 魔法陣の数値に応じて三つの画像から一つを選んで表示するように
// display() 関数を変更します
void display() {
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      int k = square[i][j] % 3;
      image(a[k], i * 25, j * 25);
    }
  }
}
```

```processing
// 最終的なコード
int[][] square = {
  { 0, 11, 5, 14 },
  { 7, 12, 2, 9 },
  { 10, 1, 15, 4 },
  { 13, 6, 8, 3 }
};
int[] buffer = new int[4];
PImage[] a = new PImage[16];

void setup() {
  size(400, 400);
  noLoop();
  stroke(255);
  a[0] = loadImage("a0.tif");
  a[1] = loadImage("a1.tif");
  a[2] = loadImage("a2.tif");
}

void draw() {
  allocate();
}

void shiftH() {
  for (int j = 0; j < 4; j++) {
    buffer[j] = square[0][j];
  }
  for (int i = 1; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      square[i - 1][j] = square[i][j];
    }
  }
  for (int j = 0; j < 4; j++) {
    square[3][j] = buffer[j];
  }
}

void shiftV() {
  for (int i = 0; i < 4; i++) {
    buffer[i] = square[i][0];
  }
  for (int j = 1; j < 4; j++) {
    for (int i = 0; i < 4; i++) {
      square[i][j - 1] = square[i][j];
    }
  }
  for (int i = 0; i < 4; i++) {
    square[i][3] = buffer[i];
  }
}

void allocate() {
  for (int l = 0; l < 4; l++) {
    for (int m = 0; m < 4; m++) {
      display();
      shiftV();
      translate(0, 100);
    }
    shiftH();
    translate(100, -400);
  }
}

void display() {
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      int k = square[i][j] % 3;
      image(a[k], j * 25, i * 25);
    }
  }
}

void keyPressed() {
  if (key == 'v') {
    shiftV();
  } else if (key == 'h') {
    shiftH();
  }
  redraw();
}
```
[
