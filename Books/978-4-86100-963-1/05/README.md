# 次元を加える
## 2次元のノイズ
### ノイズグリッドを作る

```processing
// 5.1 2次元のノイズグリッド
size(300, 300);
smooth();
background(255);
float xstart = random(10); // <-
float xnoise = xstart; // <-
float ynoise = random(10); // <-

for (int y = 0; y <= height; y += 1) {
  ynoise += 0.01; // <-
  xnoise = xstart; // <- 各列の開始点で xnoise をリセット
  for (int x = 0; x <= width; x += 1) {
    xnoise += 0.01; // <-
    int alph = int(noise(xnoise, ynoise) * 255); // ここでのノイズ関数は 2つの値をとる
    stroke(0, alph);
    line(x, y, x + 1, y + 1);
  }
}
```

### ノイズの視覚化

```processing
// 5.2 関数ブロックに書き直したノイズグリッド
float xstart, xnoise, ynoise;

void setup() {
  size(300, 300);
  smooth();
  background(255);
  xstart = random(10);
  xnoise = xstart;
  ynoise = random(10);
  for (int y = 0; y <= height; y += 5) { // <- 間隔の増加。ノイズステップの増加も同様
    ynoise += 0.1; // <-
    xnoise = xstart;
    for (int x = 0; x <= height; x += 5) {
      xnoise += 0.1; // <-
      drawPoint(x, y, noise(xnoise, ynoise)); // <-
    }
  }
}

void drawPoint(float x, float y, float noiseFactor) {
  float len = 10 * noiseFactor;
  rect(x, y, len, len);
}
```

ひとたび関数を定義すれば、さらなる実験のため、この関数を変更していきます。

```processing
void drawPoint(float x, float y, float noiseFactor) {
  pushMatrix();
  translate(x, y);
  rotate(noiseFactor * radians(360));
  stroke(0, 150);
  line(0, 0, 20, 0);
  popMatrix();
}
```
