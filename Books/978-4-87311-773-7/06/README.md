# 移動、回転、伸縮
## 座標移動の基礎

```java
// 位置の変更
void setup() {
  size(120, 120);
}

void draw() {
  translate(mouseX, mouseY);
  rect(0, 0, 30, 30);
}
```

```java
// 複数回の座標移動
void setup() {
  size(120, 120);
}

void draw() {
  translate(mouseX, mouseY);
  rect(0, 0, 30, 30);
  translate(35, 10);
  rect(0, 0, 15, 15);
}
```

## 回転
```java
// 図形の角を軸に回転
void setup() {
  size(120, 120);
}

void draw() {
  rotate(mouseX / 100.0);
  rect(0, 0, 160, 20);
}
```

```java
// 図形の中心を軸に回転
void setup() {
  size(120, 120);
}

void draw() {
  rotate(mouseX / 100.0);
  rect(-80, -10, 160, 20);
}
```

```java
// 移動してから回転
float angle = 0;

void setup() {
  size(120, 120);
}

void draw() {
  translate(mouseX, mouseY);
  rotate(angle);
  rect(-15, -15, 30, 30);
  angle += 0.1
}
```

```java
// 回転してから移動
float angle = 0;

void setup() {
  size(120, 120);
}

void draw() {
  rotate(angle);
  translate(mouseX, mouseY);
  rect(-15, -15, 30, 30);
  angle += 0.1;
}
```

> 中心点を基準に図形を描きたいときは、`rectMode()` `ellipseMode()` `imageMode()` `shapeMode()` といった関数を利用するとより簡単です。

```java
// 関節のある腕
float angle = 0.0;
float angleDirection = 1;
float speed = 0.005;

void setup() {
  size(120, 120);
}

void draw() {
  background(204);
  translate(20, 25); // スタート地点へ移動
  rotate(angle);
  strokeWeight(12);
  line(0, 0, 40, 0);
  translate(40, 0); // 次の関節へ移動
  rotate(angle * 2.0);
  strokeWeight(6);
  line(0, 0, 30, 0);
  translate(30, 0); // さらに次へ移動
  rotate(angle * 2.5);
  strokeWeight(3);
  line(0, 0, 20, 0);
  
  angle += speed * angleDirection;
  if ((angle > QUARTER_PI) || (angle < 0)) {
    angleDirection = -angleDirection;
  }
}
```

- QUARTER_PI: 約0.79

## 伸縮
```java
// 伸縮
void setup() {
  size(120, 120);
}

void draw() {
  translate(mouseX, mouseY);
  scale(mouseX / 60.0);
  rect(-15, -15, 30, 30);
}
```

```java
// 線の太さを一定に保つ
void setup() {
  size(120, 120);
}

void draw() {
  translate(mouseX, mouseY);
  float scalar = mouseX / 60.0;
  scale(scalar);
  strokeWeight(1.0 / scalar);
  rect(-15, -15, 30, 30);
}
```

## Push to Pop
座標変換の影響が後続のコードへ及ばないようにしたいときがあります。
`pushMatrix()` 関数と `popMatrix()` 関数を使うことで、変更した座標を復元できます
この機能は、図形が複数あるとき、そのうちの一つだけに座標変換の影響を与えたい場合にも使えます。

```java
// 座標系の復元
void setup() {
  size(120, 120);
}

void draw() {
  pushMatrix();
  translate(mouseX, mouseY);
  rect(0, 0, 30, 30);
  popMatrix();
  translate(35, 10);
  rect(0, 0, 15, 15);
}
```

> `pushMatrix()` と `popMatrix()` は常にペアで使います。

## Robot 4: Translate, Rotate, Scale

```java
float x = 60;
float y = 440;
int radius = 45;
int bodyHeight = 180;
int neckHeight = 40;

float easing = 0.04;

void setup() {
  size(360, 480);
  ellipseMode(RADIUS);
}

void draw() {
  strokeWeight(2);
  float neckY = -1 * (bodyHeight + neckHeight + radius);
  background(0, 153, 204);
  translate(mouseX, y); // 全体を(mouseX, y)へ移動
  
  if (mousePressed) {
    scale(1.0);
  } else {
    scale(0.6);
  }
  
  // Body
  noStroke();
  fill(255, 204, 0);
  ellipse(0, -33, 33, 33);
  fill(0);
  rect(-45, -bodyHeight, 90, bodyHeight - 33);
  
  // Neck
  stroke(255);
  line(12, -bodyHeight, 12, neckY);
  
  // Hair
  pushMatrix();
  translate(12, neckY);
  float angle = -PI / 30.0;
  for (int i = 0; i <= 30; i++) {
    line(80, 0, 0, 0);
    rotate(angle);
  }
  popMatrix();
  
  // Head
  noStroke();
  fill(0);
  ellipse(12, neckY, radius, radius);
  fill(255);
  ellipse(24, neckY - 6, 14, 14);
  fill(0);
  ellipse(24, neckY - 6, 3, 3);
}
```
