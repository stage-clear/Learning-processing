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

