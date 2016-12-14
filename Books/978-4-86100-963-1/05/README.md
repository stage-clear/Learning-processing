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
// さまざまな大きさの正方形で視覚化された、2Dパーリンノイズ
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
// 回転を使って視覚化された、2Dパーリンノイズ
void drawPoint(float x, float y, float noiseFactor) {
  pushMatrix();
  translate(x, y);
  rotate(noiseFactor * radians(360));
  stroke(0, 150);
  line(0, 0, 20, 0);
  popMatrix();
}
```

setup 関数内の `background(255)` を `background(0)` に変えて、sosite `drawPoint` を書き直せば、
同じノイズファクターを使って、回転、サイズ、色、アルファを変えることができます

```processing
void drawPoint(float x, float y, float noiseFactor) {
  pushMatrix();
  translate(x, y);
  rotate(noiseFactor * radians(540));
    float edgeSize = noiseFactor * 35;
    float grey = 150 + (noiseFactor * 120);
    float alph = 150 + (noiseFactor * 120);
  noStroke();
    fill(grey, alph);
    ellipse(0, 0, edgeSize, edgeSize / 2);
  popMatrix();
}
```

> __translate__ を使う
> あなたが片手にペンを持ち、もう一方で1枚の紙を押さえていると想像してください。
> あなたが、`line(20, 30, 120, 130)` のようなコマンドを使う時、左上の原点 (0, 0) ポイントと相対して
> ペンがどこからどこまで動くかという座標を特定しているわけです。
> `translate(20, 30)` を使う時、あなたはペンを操っているのではなく、代わりに紙の方を動かし、ペン先を (20, 30) ポイントにもってきています。
> (20, 30) ポイントは、描画を始める新しい原点となります。

## ノイズ・アニメーション
```processing
// 5.3 ノイズグリッドふたたび。フレームループ上で描く
float xstart; // <-
float xnoise;
float ystart; // <-
float ynoise;

void setup() {
  size(300, 300);
  
  smooth();
  background(0);
  frameRate(24); // <- フレームレートを設定
  
  xstart = random(10); // <-
  ystart = random(10); // <-
}

void draw() {
  background(0); // <- 全てのフレームでバックグラウンドをクリア
  
  xstart += 0.01; // <- x/y のノイズのスタート値を増やす
  ystart += 0.01;
  
  xnoise = xstart; // <-
  ynoise = ystart;
  
  for (int y = 0; y <= height; y += 5) {
    ynoise += 0.1;
    xnoise = xstart;
    for (int x = 0; x <= width; x += 5) {
      xnoise += 0.1;
      drawPoint(x, y, noise(xnoise, ynoise));
    }
  }
}

void drawPoint(float x, float y, float noiseFactor) {
  pushMatrix();
  translate(x, y);
  rotate(noiseFactor * radians(540));
  noStroke();
  float edgeSize = noiseFactor * 25;
  float grey = 150 + (noiseFactor * 120);
  float alph = 150 + (noiseFactor * 120);
  fill(grey, alph);
  ellipse(0, 0, edgeSize, edgeSize / 2);
  popMatrix();
}
```

```processing
// 5.4 動きにノイズが加わったノイズグリッド
float xstart;
float xnoise;
float ystart;
float ynoise;
float xstartNoise; // <-
float ystartNoise; // <-

void setup() {
  size(300, 300);
  smooth();
  background(255);
  frameRate(24);
  
  xstartNoise = random(20);
  ystartNoise = random(20);
  xstart = random(10);
  ystart = random(10);
}

void draw() {
  background(255);
  
  xstartNoise += 0.01;
  ystartNoise += 0.01;
  xstart += (noise(xstartNoise) * 0.5) - 0.25;
  ystart += (noise(ystartNoise) * 0.5) - 0.25;
  
  xnoise = xstart;
  ynoise = ystart;
  
  for (int y = 0; y <= height; y += 5) {
    ynoise += 0.1;
    xnoise = xstart;
    for (int x = 0; x <= width; x += 5) {
      xnoise += 0.1;
      drawPoint(x, y, noise(xnoise, ynoise));
    }
  }
}

void drawPoint(float x, float y, float noiseFactor) {
  pushMatrix();
  translate(x, y);
  rotate(noiseFactor * radians(360));
  stroke(0, 150);
  line(0, 0, 20, 0);
  popMatrix();
}
```

## 3次元
```processing
size(幅, 高さ, MODE);
```

- JAVA2D デフォルト最高品質の2Dレンダラー
- P2D(Processing2D) - より速い2Dレンダラー
- P3D(Processing3D) - 高速な3Dレンダラー。速度とファイルサイズを質よりも優先します
- OPENGL - より良い高速3Dレンダラー
- PDF - スクリーンでなく、直接PDFファイルに書き込むレンダラー

### 3次元空間で描く
```processing
import processing.opengl.*;

void setup() {
  size(500, 300, OPENGL);
  sphereDetail(40);
}

void draw() {
  background(255);
  
  translate(width / 2, height / 2, 0);
  sphere(100);
}
```

### 3次元ノイズ
```processing
// 5.5 3Dの遠近法による2Dノイズ
import processing.opengl.*;

float xstart;
float xnoise;
float ystart;
float ynoise;

void setup() {
  size(500, 300, OPENGL); // <-
  background(0);
  sphereDetail(8);
  noStroke();
  
  xstart = random(10);
  ystart = random(10);
}

void draw() {
  background(0);
  
  xstart += 0.01;
  ystart += 0.01;
  
  xnoise = xstart;
  ynoise = ystart;
  
  for (int y = 0; y <= height; y += 5) {
    ynoise += 0.1;
    xnoise = xstart;
    for (int x = 0; x <= width; x += 5) {
      xnoise += 0.1;
      drawPoint(x, y, noise(xnoise, ynoise));
    }
  }
}

void drawPoint(float x, float y, float noiseFactor) {
  pushMatrix();
  translate(x, 250 - y, -y);
  float sphereSize = noiseFactor * 35;
  float grey = 150 + (noiseFactor * 120);
  float alph = 150 + (noiseFactor * 120);
  fill(grey, alph);
  sphere(sphereSize);
  popMatrix();
}
```

```processing
// 5.6 3次元ノイズの立方体を作る
float xstart;
float ystart;
float zstart;

float xnoise;
float ynoise;
float znoise;

int sideLength = 200;
int spacing = 5;

void setup() {
  size(500, 300, P3D); // <- レンダラーを P3D に変える
  background(0);
  noStroke();
  
  xstart = random(10);
  ystart = random(10);
  zstart = random(10);
}

void draw() {
  background(0);
  
  xstart += 0.01;
  ystart += 0.01;
  zstart += 0.01;
  
  xnoise = xstart;
  ynoise = ystart;
  znoise = zstart;
  
  translate(150, 20, -150);
  rotateZ(frameCount * 0.1);
  rotateY(frameCount * 0.1);
  
  for (int z = 0; z <= sideLength; z += spacing) {
    znoise += 0.1;
    ynoise = ystart;
    for (int y = 0; y <= sideLength; y += spacing) {
      ynoise += 0.1;
      xnoise = xstart;
      for (int x = 0; x <= sideLength; x += spacing) {
        xnoise += 0.1;
        drawPoint(x, y, z, noise(xnoise, ynoise, znoise));
      }
    }
  }
}

void drawPoint(float x, float y, float z, float noiseFactor) {
  pushMatrix();
  translate(x, y, z);
  float grey = noiseFactor * 255;
  fill(grey, 10);
  box(spacing, spacing, spacing);
  popMatrix();
}
```

- [Haunted Fistank](http://abandonedart.org/?p=449) このセクションで開発したシステムとよく似ています

### 球を描く間違った方法
以下は、球の表面上に点を描くという、あまり魔法っぽくない公式です
```processing
x = centerX + (radius * cos(s) * sin(t));
y = centerY + (radius * sin(s) * siin(t));
z = centerZ + (radius * cos(t));
```

```processing
// 5.7 球のまわりのらせん
import processing.opengl.*;

int radius = 100;

void setup() {
  size(500, 300, OPENGL);
  background(255);
  stroke(0);
}

void draw() {
  background(255);
  
  translate(width / 2, height / 2, 0);
  rotateY(frameCount * 0.03);
  rotateX(frameCount * 0.04);
  
  float s = 0;
  float t = 0;
  flaot lastx = 0;
  float lasty = 0;
  float lastz = 0;
  
  while(t < 180) {
    s += 18;
    t += 1;
    float radianS = radians(s);
    float radianT = radians(t); // <- 三角関数に角度をラジアンに変換
    
    float thisx = 0 + (radius * cos(radianS) * sin(radianT));
    float thisy = 0 + (radius * sin(radianS) * sin(radianT));
    float thisz = 0 + (radius * cos(radianT));
    
    if (lastx != 0) {
      line(thisx, thisy, thisz, lastx, lasty, lastz);
    }
    
    lastx = thisx;
    lasty = thisy;
    lastz = thisz;
  }
}
```

## まとめ
