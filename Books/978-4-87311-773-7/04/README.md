# 変数
## 最初の変数

```java
// 同じ値の再利用
size(480, 120);
int y = 60;
int d = 80;
ellipse(75, y, d, d);
ellipse(175, y, d, d);
ellipse(275, y, d, d);
```

```java
// 値の変更
size(480, 120);
int y = 100;
int d = 130;
ellipse(75, y, d, d);
ellipse(175, y, d, d);
ellipse(275, y, d, d);
```

## 変数の作成

```java
int x;  // x を int 型変数として宣言
x = 12; // x に値を割り当てる

int x = 12; / x を int 型として宣言し、値を割り当てる

// エラー: 
int x;
int x = 12; // エラー！ x という名前の変数を2度作ろうとした

int x = 12.2; // エラー！ 小数点のある数を int 型に代入しようとしました

float x = 12; // 12 から 12.0 へ自動的に変換される
```

## 変数の処理
```java
// ウィンドウサイズに合わせる
size(480, 120);
line(0, 0, width, height);
line(width, 0, 0, height);
ellipse(width / 2, height / 2, 60, 60);
```

## 変数と計算
```java
// 基本的な計算
size(480, 120);
int x = 25;
int h = 20;
int y = 25;
rect(x, y, 300, h);
x = x + 100;
rect(x, y + h, 300, h);
x = x - 250;
rect(x, y + h * 2, 300, h);
```

## 繰り返し
```java
// 何度も同じことを繰り返す
size(480, 120);
strokeWeight(8);
line(20, 40, 80, 80);
line(80, 40, 140, 80);
line(140, 40, 200, 80);
line(200, 40, 260, 80);
line(260, 40, 320, 80);
line(320, 40, 380, 80);
line(380, 40, 440, 80);
```

```java
// for ループを使う
size(480, 120);
strokeWeight(8);
for (int i = 20; i < 400; i += 60) {
  line(i, 40, i + 60, 80);
}
```

```java
for (init; test; update) {
  statements
  // 繰り返し実行されるコード
}
```

```java
// for ループで柔軟体操
size(480, 120);
strokeWeight(2);
for (int i = 20; i < 400; i += 8) {
  line(i, 40, i + 60, 80);
}
```

```java
// 扇状に広がるライン
size(480, 120);
strokeWeight(2);
for (int i = 20; i < 400; i += 20) {
  line(i, 0, i + i / 2, 80);
}
```

```java
// よじれるライン
size(480, 120);
strokeWeight(2);
for (int i = 20; i < 400; i += 20) {
  line(i, 0, i + i / 2, 80);
  line(i + i / 2, 80, i * 1.2, 120);
}
```

```java
// ループにループを埋め込む
size(480, 120);
background(0);
noStroke();
for (int y = 0; y <= height; y += 40) {
  for (int x = 0; x <= width; x += 40) {
    fill(255, 140);
    ellipse(x, y, 40, 40);
  }
}
```

```java
// 横と縦の列
size(480, 120);
background(0);
noStroke();
for (int y = 0; y < height + 45; y += 40) {
  fill(255, 140);
  ellipse(0, y, 40, 40);
}
for (int x = 0; x < width + 45; x += 40) {
  fill(255, 140);
  ellipse(x, 0, 40, 40);
}
```

```java
// ピンと線
size(480, 120);
background(0);
fill(255);
stroke(102);
for (int y = 20; y <= height - 20; y += 10) {
  for (int x = 20; x <= width - 20; x += 10) {
    ellipse(x, y, 4, 4);
    line(x, y, 240, 60);
  }
}
```


```java
// 網点
size(480, 120);
background(0);
for (int y = 32; y <= height; y += 8) {
  for (int x = 12; x <= width; x += 15) {
    ellipse(x + y, y, 16 - y / 10.0, 16 - y / 10.0);
  }
}
```

## Robot 2: Variables
