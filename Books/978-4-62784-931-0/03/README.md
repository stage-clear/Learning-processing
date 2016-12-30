# 変数を使う
## 変数

```processing
// 変数を使って描く
void setup() {
  size(480, 120);
  int a = 80;
  int b = 40;
  rect(60, 20, a, b);
  rect(180, 20, b, a);
  rect(260, 20, a, a);
  rect(380, 20, b, b);
}
```

## 変数の種類と定義の方法
### 種類

1. `int` 型には, `0, 1, 2, 3, -1, -2` などのような整数を格納できます
2. `float` 型には, `3.14159, 2.6, -169.3` 等のように少数を含む数を格納できます
3. `boolean` 型には true, false を格納できます
4. `char` 型には `'A', 'B', 'a', 'b'` 等の1文字を格納できます
5. `String` 型には `"ABC", "abc"` 等の文字列を格納できます
6. `color` 型には, 色の情報を格納できます
7. `PImage` 型には, `.gif, .jpg, .tga, .png` 等の画像を格納できます

### 定義の方法
```processing
int x;
x = 12;
```

```procsssing
int x = 12;
```

## 演算子
```processing
y = a + b;
z = 1 + 3;
```

```processing
int x = 6 + 4 * 3;
```

```processing
int a = 6;
int b = 4;
int c = 3;

int x = a + b * c;
```

```processing
x = (6 + 4) * 3;
```

```processing
x = x + 10;
```

```processing
x += 10;
```

```processing
x++;
```

```processing
// Error
String s = 3.6;
char c = "abc"
```

```processing
int m = 3.1419526; 
// > 3 
// The floating number is converted to integer
```

## Processing 変数
Processing には特別な変数が用意されています. たとえば, `width` や `height` です。[

## for ループ
```processing
void setup() {
  size(480, 120);
  strokeWeight(10);
  line( 40, 20,  40, 100);
  line( 90, 20,  90, 100);
  line(140, 20, 140, 100);
  line(190, 20, 190, 100);
  line(240, 20, 240, 100);
  line(290, 20, 290, 100);
  line(340, 20, 340, 100);
  line(390, 20, 390, 100);
  line(440, 20, 440, 100);
}
```

```processing
void setup() {
  size(480, 120);
  strokeWeight(10);
  for (int i = 40; i <= 440; i += 50) {
    line(i, 20, i, 100);
  }
}
```

```processing
// for
for (init; test; update) {
  statement;
}
```

## 二重の for ループ
```processing
void setup() {
  size(480, 120);
  smooth();
  noStroke();
  fill(120);
  for (int y = 0; y <= height; y += 40) {
    for (int x = 0; x <= width; x += 40) {
      ellipse(x, y, 30, 30);
    }
  }
}
```

## 配列
```processing
float[] beam; // <-

void setup() {
  size(480, 120);
  strokeWeight(6);
  beam = new float[60]; // <-
  for (int i = 0; i < 60; i++) {
    beam[i] = random(0, 120); // <-
  }
  for (int i = 0; i < 60; i++) {
    line(i * 8, beam[i], i * 8, 120);
  }
}
```

配列の定義の方法にはいくつかあります.
前の例のように, `new` キーワードを使って定義し、各要素に後からデータを保存する方法や、
以下のように定義と同時に要素を格納する方法などです.
```processing
int[] score = {90, 85, 60, 75, 100};
```

`int` をはじめ, `float`, `boolean`, `String`, `PImage` などすべての型の変数に対して配列を作ることができます.

```processing
float[] distance = new float(100);
```

```processing
distance[0] = 210.5;
```

```processing
distance[99] = 333.5;
```
