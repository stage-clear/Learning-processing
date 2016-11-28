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

