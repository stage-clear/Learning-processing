# 動き _Motion_

```java
// フレームレートを見る
void draw() {
  println(frameRate);
}
```

```java
// フレームレートの変更
void setup() {
  frameRate(30);      // 毎秒30フレーム
  // frameRate(12);   // 毎秒12フレーム
  // frameRate(2);    // 毎秒2フレーム
  // frameRate(0.5);  // 2秒ごとに1フレーム
}

void draw() {
  println(frameRate);
}
```

## スピードと方向

```java
// 図形の移動
int radius = 40;
float x = -radius;
float speed = 0.5;

void setup() {
  size(240, 120);
  ellipseMode(RADIUS);
}

void draw() {
  background(0);
  x += speed; // x に加算
  arc(x, 60, radius, radius, 0.52, 5.76);
}
```

```java
// 円筒形を回す
int radius = 40;
float x = -radius;
flaot speed = 0.5;

void setup() {
  size(240, 120);
  ellipseMode(RADIUS);
}

void draw() {
  background(0);
  x += speed;
  if (x > width + radius) {
    x = -radius;
  }
  arc(x, 60, radius, radius, 0.52, 5.76);
}
```

```java
// 壁に当たって跳ね返る
int radius = 40;
float x = 110;
float speed = 0.5;
int direction = 1;

void setup() {
  size(240, 120);
  ellipseMode(RADIUS);
}

void draw() {
  background(0);
  x += speed * direction;
  if ((x > width - radius) || (x < radius)) {
    direction = -direction; // 方向を反転
  }
  if (direction == 1) {
    arc(x, 60, radius, radius, 0.52, 5.76); // 右向き
  } else {
    arc(x, 60, radius, radius, 3.76, 8.9); // 左向き
  }
}
```

## 2点間の移動
```java
// 2点間の経路を計算うる
int startX = 20;    // 始点 x座標
int stopX = 160;    // 終点 x座標
int startY = 30;    // 始点 y座標
int stopY = 80;     // 終点 y座標
float x = startX;   // 今の x座標
float y = startY;   // 今の y座標
float step = 0.005; // ステップごとの移動量(0.0 to 1.0)
float pct = 0.0;    // 移動量 百分率(0.0 to 1.0) パーセント

void setup() {
  size(240, 120);
}

void draw() {
  background(0);
  if (pct < 1.0) {
    x = startX + ((stopX - startX) * pct);
    y = startY + ((stopY - startY) * pct);
    pct += step;
  }
  ellipse(x, y, 20, 20);
}
```

## 乱数
```java
// 乱数の生成
void draw() {
  float r = random(0, mouseX);
  println(r);
}
```

```java
// ランダムに描く
void setup() {
  size(240, 120);
}

void draw() {
  background(204);
  for (int x = 20; x < width; x += 20) {
    float mx = mouseX / 10;
    float offsetA = random(-mx, mx);
    float offsetB = random(-mx, mx);
    line(x + offsetA, 20, x - offsetB, 100);
  }
}
```

```java
// ランダムに動く
float speed = 2.5;
int diameter = 20;
float x;
float y;

void setup() {
  size(240, 120);
  x = width / 2;
  y = height / 2;
}

void draw() {
  x += random(-speed, speed);
  y += random(-speed, speed);
  ellipse(x, y, diameter, diameter);
}
```

x と y の値がウィンドウの境界を越えないよう、`constrain()` 関数による制限を加えます

```java
void draw() {
  x += random(-speed, speed);
  y += random(-speed, speed);
  x = constrain(x, 0, width);
  y = constrain(y, 0, height);
  ellipse(x, y, diameter, diameter);
}
```
- [constrain()](https://processing.org/reference/constrain_.html)

> プログラムを実行するたびに `random()` が同じシーケンスを生成するよう強制したいときは `randomSeed()` を使います
> [randomSeed()](https://processing.org/reference/randomSeed_.html)

## タイマー
Processing はプログラムあスタートしてからの経過時間をカウントしています。
単位はミリ秒で、1秒が経過すると1000、5秒なら5000、1分では60000となります。

- [millis()](https://processing.org/reference/millis_.html)

```java
void draw() {
  int timer = millis();
  println(timer);
}
```

```java
// 時限式のイベント
int time1 = 2000;
int time2 = 4000;

float x = 0;

void setup() {
  size(480, 120);
}

void draw() {
  int currentTime = millis();
  background(204);
  if (currentTime > time2) {
    x -= 0.5
  } else if (currentTime > time1) {
    x += 2;
  }
  ellipse(x, 60, 90, 90);
}
```

## 円運動

```java
// サイン波の値
// sin() の値は -1と1との間を行き来します
// map() 関数によって、変数 sinval の値は0から255の範囲に変換され、
// ウィンドウの背景色に使われます
float angle = 0.0;

void draw() {
  float sinval = sin(angle);
  println(sinval);
  float gray = map(sinval, -1, 1, 0, 255);
  background(gray);
  angle += 0.1;
}
```

```java
// サイン波の動き
float angle = 0.0;
float offset = 60;
float scalar = 40;
float speed = 0.05;

void setup() {
  size(240, 120);
}

void draw() {
  background(0);
  float y1 = offset + sin(angle) * scalar;
  float y2 = offset + sin(angle + 0.4) * scalar;
  float y3 = offset + sin(angle + 0.8) * scalar;
  ellipse( 80, y1, 40, 40);
  ellipse(120, y2, 40, 40);
  ellipse(160, y3, 40, 40);
  angle += speed;
}
```

```java
// 円運動
// sin() と cos() を組み合わせると、円運動を作り出すことができます
// cos() が x座標の、sin() がy座標の基となります
float angle = 0.0;
float offset = 60;
float scalar = 40;
float speed = 0.05;

void setup() {
  size(120, 120);
}

void draw() {
  float x = offset + cos(angle) * scalar;
  float y = offset + sin(angle) * scalar;
  ellipse(x, y, 40, 40);
  angle += speed;
}
```

```java
// らせん
float angle = 0.0;
float offset = 60;
float scalar = 2;
float speed = 0.05;

void setup() {
  size(120, 120);
  fill(0);
}

void draw() {
  float x = offset + cos(angle) * scalar;
  float y = offset + sin(angle) * scalar;
  ellipse(x, y, 2, 2);
  angle += speed;
  scalar += speed;
}
```

## Robot 6: Motion

```java
float x = 180;            // x 座標
float y = 400;            // y 座標
float bodyHeight = 153;   // 胴の高さ
float neckHeight = 56;    // 首の高さ
float radius = 45;        // 頭の半径
float angle = 0.0;        // 動きの角度

void setup() {
  size(360, 480);
  ellipseMode(RADIUS);
  background(0, 153, 204); // 青い背景
}

void draw() {
  // 小さな乱数の蓄積により位置を変える
  x += random(-4, 4);
  y += random(-1, 1);
  
  // 首の長さを変える
  neckHeight = 80 + sin(angle) * 30;
  angle += 0.05;
  
  // 頭の高さを調整
  float ny = y - bodyHeight - neckHeight - radius;
  
  // 首
  stroke(255);
  line(x +  2, y - bodyHeight, x +  2, ny);
  line(x + 12, y - bodyHeight, x + 12, ny);
  line(x + 22, y - bodyHeight, x + 22, ny);
  
  // アンテナ
  line(x + 12, ny, x - 18, ny - 43);
  line(x + 12, ny, x + 42, ny - 99);
  line(x + 12, ny, x + 78, ny + 15);
  
  
  // 胴体
  noStroke();
  fill(255, 204, 0);
  ellipse(x, y - 33, 33, 33);
  fill(0);
  rect(x - 45, y - bodyHeight, 90, bodyHeight - 33);
  fill(255, 204, 0);
  rect(x - 45, y - bodyHeight + 17, 90, 6);
  
  // 頭
  fill(0);
  ellipse(x + 12, ny, radius, radius);
  fill(255);
  ellipse(x + 24, ny - 6, 14, 14);
  fill(0);
  ellipse(x + 24, ny - 6, 3, 3);
}
```
