# 座標変換を使う
## 座標系
左上のコーナーに原点があり、右方向に x 座標の正の軸, 下方向に y 座標の正の軸が設定されています.

## 平行移動
```processing
// 平行移動
void setup() {
  size(120, 120);
  smooth();
}

void draw() {
  translate(10, 20);
  rect(0, 0, 60, 20);
}
```

```processing
// 平行移動
void setup() {
  size(120, 120);
  smooth();
}

void draw() {
  translate(60, 80);
  rect(0, 0, 60, 20);
}
```

## 回転

```processing
// 時計回りに π / 6 (30°)
void setup() {
  size(120, 120);
  smooth();
}

void draw() {
  rotate(PI / 6);
  rect(50, 20, 60, 20);
}
```

```processing
// 反時計回り π / 8
void setup() {
  size(120, 120);
  smooth();
}

void draw() {
  rotate(-PI / 8);
  rect(10, 40, 60, 20);
}
```

## 遮断
```processing
// 二度の平行移動
void setup() {
  size(120, 120);
  smooth();
}

void draw() {
  translate(10, 30);
  rect(0, 0, 60, 20); // 小さい長方形
  translate(10, 30);
  rect(0, 0, 80, 40); // 大きい長方形
}
```

```processing
void setup() {
  size(120, 120);
  smooth();
}

void draw() {
  pushMatrix();
  rotate(PI/6);
  translate(10, 30);
  rect(30, 0, 100, 20);
  popMatrix();
  rect(30, 0, 50, 40);
}
```

## 拡大縮小
```processing
void setup() {
  size(120, 120);
  smooth();
  noLoop();
}

void draw() {
  rect(10, 40, 40, 10);
  scale(2);
  rect(10, 40, 40, 10);
}
```
