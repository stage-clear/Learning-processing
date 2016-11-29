# 配列 _Arrays_
## 変数から配列へ

```java
// 変数がたくさん
float x1 = -20;
float x2 = 20;

void setup() {
  size(240, 120);
  noStroke();
}

void draw() {
  background(0);
  x1 += 0.5;
  x2 += 0.5;
  arc(x1, 30, 40, 40, 0.52, 5.76);
  arc(x2, 90, 40, 40, 0.52, 5.76);
}
```

```java
// 変数が多すぎる
float x1 = -10;
float x2 = 10;
float x3 = 35;
float x4 = 18;
float x5 = 30;

void setup() {
  size(240, 120);
  noStroke();
}

void draw() {
  background(0);
  x1 += 0.5;
  x2 += 0.5;
  x3 += 0.5;
  x4 += 0.5;
  x5 += 0.5;
  arc(x1, 20, 20, 20, 0.52, 5.76);
  arc(x2, 40, 20, 20, 0.52, 5.76);
  arc(x3, 60, 20, 20, 0.52, 5.76);
  arc(x4, 80, 20, 20, 0.52, 5.76);
  arc(x5, 100, 20, 20, 0.52, 5.76);
}
```

```java
// 変数から配列に
float[] x = new float[3000];

void setup() {
  size(240, 120);
  noStroke();
  fill(255, 200);
  for (int i = 0; i < x.length; i++) {
    x[i] = random(-1000, 200);
  }
}

void draw() {
  background(0);
  for (int i = 0; i < x.length; i++) {
    x[i] += 0.5;
    float y = i * 0.4;
    arc(x[i], y, 12, 12, 0.52, 5.76);
  }
}
```

## 配列の作り方
```java
int[] hears = { 1920, 1972, 1980, 1996, 2010 };
```

```java
// 配列として宣言するときは、データ型の後ろに角カッコを付けます
int[] x;
```

```java
// 次のコードは、2000個の整数からなる配列を作ります
int[] x = new int[2000];
```

Processing のデータ型はどれでも配列にすることができます。
`boolean` `float` `String` `PShape` などはもちろん、ユーザーが定義したクラスも同様です。

```java
// 次のコードは、32個の PImage 変数からなる配列を作ります
PImage[] images = new PImage[32];
```

1. データ型を定義し、配列を宣言
2. new キーワードを使って配列を生成し、長さ（要素数）を定義
3. 各要素に値を代入

> ある配列が格納できるデータ型は1種類だけです。複数のデータ型を混ぜることはできません。そうする必要があるときは、オブジェクトを使います。

```java
// 配列と宣言と代入
int[] x;            // 配列を宣言

void setup() {
  size(200, 200);
  x = new int[2];   // 配列の生成
  x[0] = 12;        // 1つ目の値を代入
  x[1] = 2;         // 2つ目を代入
}
```

```java
// コンパクトな作り方
int[] x = new int[2]; // 配列と宣言と生成

void setup() {
  size(200, 200);
  x[0] = 12;
  x[1] = 2;
}
```

```java
// 一息に作る方法
int[] x = { 12, 2 }; // 宣言、生成、代入

void setup() {
  size(200, 2000);
}
```

> 繰り返し実行される `draw()` のなかで配列を作らないように注意しましょう。動作が遅くなります。

```java
// 配列のおさらい
float[]x = { -20, 20 };

void setup() {
  size(240, 120);
  noStroke();
}

void draw() {
  background(0);
  x[0] += 0.5;    // 1つ目の要素に加算
  x[1] += 0.5;    // 2つ目の要素に加算
  arc(x[0], 30, 40, 40, 0.52, 5.76);
  arc(x[1], 90, 40, 40, 0.52, 5.76);
}
```

## 配列と繰り返し

```java
int[] x = new int[2];     // 配列の宣言と生成
println(x.length);        // 2

int[] y = new int[1972];  // 配列の宣言と生成
println(y.length);        // 1972
```

```java
// for ループで配列に値を渡す
float[] gray;

void setup() {
  size(240, 120);
  gray = new float[width]
  for (int i = 0; i < gray.length; i++) {
    gray[i] = random(0, 255);
  }
}

void draw() {
  for (int i = 0; i < gray.length; i++) {
    stroke(gray[i]);
    line(i, 0, i, height);
  }
}
```

```java
// マウスを追跡する
int num = 60;
int[] x = new int[num];
int[] y = new int[num]

void setup() {
  size(240, 120);
  noStroke();
}

void draw() {
  background(0);
  // 配列の値を前から後ろへコピー
  for (int i = x.length - 1; i > 0; i--) {
    x[i] = x[i-1];
    y[i] = y[i-1];
  }
  x[0] = mouseX;  // 最初の要素にセット
  y[0] = mouseY;
  for (int i = 0; i < x.length; i++) {
    fill(i * 4);
    ellipse(x[i], y[i], 40, 40);
  }
}
```

## オブジェクトの配列
```java
// 多数のオブジェクトを管理
JitterBug[] bugs =  new JitterBug[33];

void setup() {
  size(240, 120);
  for (int i = 0; i < bugs.length; i++) {
    float x = random(width);
    float y = random(height);
    int r = i + 2;
    bugs[i] = new JitterBug(x, y, r);
  }
}

void display() {
  for (int i = 0; i < bugs.length; i++) {
    bugs[i].move();
    bugs[i].display();
  }
}

// class JitterBug {}
```

オブジェクトを配列のように扱うときに便利な「拡張 for ループ」という機能を紹介します

```java
// 新しいオブジェクト管理の方法
JitterBug[] bugs = new JitterBug[33];

void setup() {
  size(240, 120);
  for (int i = 0; i < bugs.length; i++) {
    float x = random(width);
    float y = random(height);
    int r = i + 2;
    bugs[i] = new JitterBug(x, y, r);
  }
}

void draw() {
  for (JitterBug b : bugs) { // <-
    b.move();
    b.display();
  }
}
```

```java
// 画像のシーケンス
int numFrames = 12;
PImage[] images = new PImage[numFrames]; // 配列を作成
int currentFrame = 1;

void setup() {
  size(240, 120);
  for (int i = 0; i < images.length; i++) {
    String imageName = "frame-" + nf(i, 4) + ".png";
    images[i] = loadImage(imageName); // 画像を読み込む
  }
  frameRate(24);
}

void draw() {
  image(images[currentFrame], 0, 0);
  currentFrame++;
  if (currentFrame == images.length) {
    currentFrame = 0;
  }
}
```

- [nf()](https://processing.org/reference/nf_.html) - 数字のフォーマットを変更します (`nf(0, 4)` -> 0001, `nf(11, 4)` => 0011)

Robot 9: Arrays
```java
Robot[] bots;  // Declare array of Robot objects

void setup() {
  size(720, 480);
  PShape robotShape = loadShape("robot2.svg");
  // Robot オブジェクトの配列を用意
  bots = new Robot[20];
  // 各オブジェクトを生成
  for (int i = 0; i < bots.length; i++) {
    // ランダムな x 座標
    float x = random(-40, width - 40);
    // y座標は順番に
    flaot y = map(i, 0, bots.length, -100, height - 200);
    bots[i] = new Robot(robotShape, x, y);
  }
}

void draw() {
  background(0, 153, 204);
  // 配列内のオブジェクトを描画
  for (int i = 0; i < bots.length; i++) {
    bots[i].update();
    bots[i].display();
  }
}

class Robot {
  float xpos;
  float ypos;
  float angle;
  PShape botShape;
  float yoffset = 0.0;
  
  // コンストラクタ
  Robot(PShape shape, float tempX, float tempY) {
    botShape = shape;
    xpos = tempX;
    ypos = tempY;
    angle = random(0, TWO_PI);
  }
  
  // フィールドを更新
  void update() {
    angle += 0.05;
    yoffset = sin(angle) * 20;
  }
  
  // ロボットを画面に表示
  void display() {
    shape(botShape, xpos, ypos + yoffset);
  }
}
```
