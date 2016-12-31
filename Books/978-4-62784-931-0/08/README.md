# フラクタル図形を描く
## シェルピンスキーのギャスケット
## 三角形を一つ描画
左の頂点Aの座標が (x, y) の正三角形の場合, 点A, B, C の座標はそれぞれ
`(x, y)`, `(x + a, y)`, `(x + a / 2, √3a / 2)` となります.

```processing
triangle(x, y, x + a, y, x + a / 2, sqrt(3) / 2 * a)
```

```processing
void gasket(float x, float y, float a) {
  triangle(x, y, x + a, y, x + a / 2, sqrt(3) / 2 * a);
}
```

## 三角形の分割
- 三角形1 `gasket(x, y, a / 2)`
- 三角形2 `gasket(x + a / 2, y, a /2)`
- 三角形3 `gasket(x + a / 4, y + sqrt(3) * a / 4, a / 2)`

```processing
float X = 0, Y = 0, A = 480;

void setup() {
  size(480, 420);
  smooth();
  noLoop();
}

void draw() {
  gasket(X, Y, A);
  gasket(X, Y, A / 2);
  gasket(X + A / 2, Y, A / 2);
  gasket(X + A / 4, Y + sqrt(3) * A / 4, A / 2);
}

void gasket(float x, float y, float a) {
  triangle(x, y, x + a, y, x + a / 2, y + sqrt(3) * a / 2);
}
```

## 再帰
再帰を使って今までのところを書いてみましょう.

```processing
void gasket(float x, float y, float a) {
  triangle(x, y, x + a, y, x + a / 2, y + sqrt(3) * a / 2);
  gasket(x, y, a / 2);
  gasket(x + a / 2, y, a / 2);
  gasket(x + a / 4, y + sqrt(3) / 4 * a, a / 2);
}
```

プログラミングでは「果てしなく」計算が続くことを避けなければなりません.

```processing
void gasket(float x, float y, float a, int num) {
  triangle(x, y, x + a, y, x + a / 2, y + sqrt(3) * a / 2);
  num = num - 1;
  if (num > 0) {
    gasket(x, y, a / 2, num);
    gasket(x + a / 2, y, a / 2, num);
    gasket(x + a / 4, y + sqrt(3) * a / 4, a / 2, num);
  }
}
```

```processing
void setup() {
  size(480, 420);
  smooth();
  noLoop();
}

void draw() {
  gasket(0, 0, 480, 6);
}

void gasket(float x, float y, float a, int num) {
  fill(random(0, 255));
  triangle(x, y, x + a, y, x + a / 2, y + sqrt(3) * a / 2);
  num = num - 1;
  if (num > 0) {
    fill(random(0, 80));
    gasket(x, y, a / 2, num);
    fill(random(81, 160));
    gasket(x + a / 2, y, a / 2, num);
    fill(random(161, 240));
    gasket(x + a / 4, y + sqrt(3) * a / 4, a / 2, num);
  }
}
```

## 長方形の再帰パターン

```processing
void setup() {
  size(480, 480);
  smooth();
  noLoop();
}

void draw() {
  drawRect(0, 0, width, height, 7);
}

void drawRect(float x, float y, float a, float b, int num) {
  fill(random(0, 255));
  rect(x, y, a, b);
  float r = random(0.2, 0.8);
  num = num - 1;
  if (num > 0) {
    drawRect(x, y, r * a, r * b, num);
    drawRect(x + r * a, y, (1 - r) * a, r * b, num);
    drawRect(x, y + r * b, r * a, (1 - r) * b, num);
    drawRect(x + r * a, y + r * b, (1 - r) * a, (1 -r) * b, num);
  }
}
```[
