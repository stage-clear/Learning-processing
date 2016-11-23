# 反応
## 繰り返される draw と一度だけの setup
`draw()` は Stop ボタンを押すかウィンドウを閉じるまで繰り返し実行されます。
デフォルトでは1秒間に60フレームで、この値は変更可能です。

```java
// draw 関数
void draw() {
  // フレームカウントをコンソール表示
  println("I'm drawing");
  println(frameCount);
}
```

- [frameCount](https://processing.org/reference/frameCount.html)

`setup()` はプログラムが動き始めたときに、1回だけ実行されます。
```java
// setup 関数
void setup() {
  println("I'm starting");
}

void draw() {
  println("I'm running");
}
```

Processing がコードを実行する順番を整理すると、次のとおりです。

1. `setup()` と　`draw()` の外側で宣言された変数を作成
2. `setup()` 内のコードを一度だけ実行
3. `draw()` 内のコードを繰り返し実行

```java
// setup() と draw()
int x = 280;
int y = -100;
int diameter = 380;

void setup() {
  size(480, 120);
  fill(102);
}

void draw() {
  background(204);
  ellipse(x, y, diameter, diameter);
}
```

## 追いかける
`mouseX` はX座標、`mouseY` はy座標を保持しています

```java
// マウスを追跡
void setup() {
  size(480, 120);
  fill(0, 102);
  noStroke();
}

void draw() {
  ellipse(mouseX, mouseY, 9, 9);
}
```

- [mouseX](https://processing.org/reference/mouseX.html) - マウスのX座標
- [mouseY](https://processing.org/reference/mouseY.html) - マウスのY座標

```java
// 追ってくる点
void setup() {
  size(480, 120);
  fill(0, 102);
  noStroke();
}

void draw() {
  background(204); // 画面をリフレッシュします
  ellipse(mouseX, mouseY, 9, 9);
}
```

```java
// 連続的に描く
void setup() {
  size(480, 120);
  strokeWeight(4);
  stroke(0, 102);
}

void draw() {
  line(mouseX, mouseY, pmouseX, pmouseY);
}
```

- [pmouseX](https://processing.org/reference/pmouseX.html) - 1つ前のフレームにおけるマウスのX座標
- [pmouseY](https://processing.org/reference/pmouseY.html) - 1つ前のフレームにおけるマウスのY座標

`pmouseX` と `pmouseY` はマウスのスピードの計算にも使えます
```java
// 太さを変えながら描く
void setup() {
  size(480, 120);
  stroke(0, 102);
}

void draw() {
  float weight = dist(mouseX, mouseY, pmouseX, pmouseY);
  strokeWeight(weight);
  line(mouseX, mouseY, pmouseY, pmouseX);
}
```

- [dist()](https://processing.org/reference/dist_.html)


より滑らかなモーションを作り出すために、反応を遅らせてみましょう。
このテクニックはイージング（easing）と呼ばれます。

```java
// ゆっくり行こう
float x;
float easing = 0.01;

void setup() {
  size(220, 120);
}

void draw() {
  float targetX = mouseX;
  x += (targetX - x) * easing;
  ellipse(x, 40, 12, 12);
  println(targetX + " : " + x);
}
```

```java
// イージングで線を滑らかに
float x;
float y;
float px;
flaot py;
float easing = 0.05;

void setup() {
  size(480, 120);
  stroke(0, 102);
}

void draw() {
  float targetX = mouseX;
  x += (targetX - x) * easing;
  float targetY = mouseY;
  y += (targetY - y) * easing;
  float weight = dist(x, y, px, py);
  strokeWeight(weight);
  line(x, y, px, py);
  py = y;
  px = x;
}
```

## クリック
ボタンが押されると `mousePressed` 変数が変化します。
取り得る値は `true` か `false` です。

```java
// マウスをクリック
void setup() {
  size(240, 120);
  strokeWeight(30);
}

void draw() {
  background(204);
  stroke(102);
  line(40, 0, 70, height);
  if (mousePressed == true) {
    stroke(0);
  }
  line(0, 70, width, 50);
}
```
- [mousePressed](https://processing.org/reference/mousePressed.html)
- [height](https://processing.org/reference/height.html)
- [width](https://processing.org/reference/width.html)

```java
// クリックされていないことを検出する
void setup() {
  size(240, 120);
  strokeWeight(30);
}

void draw() {
  background(204);
  stroke(102);
  line(40, 0, 70, height);
  if (mousePressed) {
    stroke(0);
  } else {
    stroke(255);
  }
  line(0, 70, width, 50);
}
```

```java
// 複数のマウスボタン
void setup() {
  size(120, 120);
  strokeWeight(30);
}

void draw() {
  background(204);
  stroke(102);
  line(40, 0, 70, height);
  if (mousePressed) {
    if (mouseButton == LEFT) {
      stroke(255);
    } else {
      stroke(0);
    }
  }
  line(0, 70, width, 50);
}
```

```java
// if - else の構造はいくつも増やすことができます
if (test) {
 statements
}

if (test) {
  statements 1
} else {
  statements 2
}

if (test 1) {
  statements 1
} else if (test 2) {
  statements 2
}
```

## カーソルの位置
```java
// カーソルを探せ
float x;
int offset = 10;

void setup() {
  size(240, 120);
  x = width / 2;
}

void draw() {
  background(204);
  if (mouseX > x) {
    x += 0.5;
    offset = -10;
  }
  
  if (mouseX < x) {
    x -= 0.5;
    offset = 10;
  }
  
  line(x, 0, x, height);
  line(mouseX, mouseY, mouseX + offset, mouseY - 10);
  line(mouseX, mouseY, mouseX + offset, mouseY + 10);
  line(mouseX, mouseY, mouseX + offset * 3, mouseY);
}
```

```java
// 円の境界
int x = 120;
int y = 60;
int radius = 12;

void setup() {
  size(240, 120);
  ellipseMode(RADIUS);
}

void draw() {
  background(204);
  float d = dist(mouseX, mouseY, x, y);
  if (d < radius) {
    radius++;
    fill(0);
  } eles {
    fill(255);
  }
  ellipse(x, y, radius, radius);
}
```

```java
// 長方形の境界
int x = 80;
int y = 30;
int w = 80;
int h = 60;

void setup() {
  size(240, 120);
}

void draw() {
  background(204);
  if ((mouseX > x) && (mouseX < x + w) &&
    (mouseY > y) && (mouseY < y + h)) {
    fill(0);
  } else {
    fill(255);
  }
  rect(x, y, w, h);
}
```

## キーボードからの入力
```java
// キーを叩く
void setup() {
  size(240, 120);
}

void draw() {
  background(204);
  line(20, 20, 220, 100);
  if (keyPressed) {
    line(220, 20, 20, 100);
  }
}
```

押されたキーがどれかは、`key` 変数を見るとわかります。
`key` のデータ型は `char` です。char型は英数字を1文字だけ格納できます。
文字列はダブルクオートで囲って表記しますが、char型は __シングルクオート__ です。

```java
void setup() {
  size(120, 120);
  textSize(64);
  textAlign(CENTER);
}

void draw() {
  background(0);
  text(key, 60, 80);
}
```

- [textSize()](https://processing.org/reference/textSize_.html) - 文字の大きさを指定します
- [textAlign()](https://processing.org/reference/textAlign_.html) - テキストの水平位置を指定します

```java
// 特定のキーに反応する
void setup() {
  size(120, 120);
}

void draw() {
  background(204);
  if (keyPressed) {
    if ((key == 'h') || (key == 'H')) {
      line(30, 60, 90, 60);
    }
    if ((key == 'n') || (key == 'N')) {
      line(30, 20, 90, 100);
    }
    line(30, 20, 30, 100);
    line(90, 20, 90, 100);
  }
}
```

- [keyCode](https://processing.org/reference/keyCode.html)

```java
// カーソルキーで動かす
int x = 215;

void setup() {
  size(480, 120);
}

void draw() {
  if (keyPressed && (key == CODED)) { // コードかされたキーか
    if (keyCode == LEFT) { // 左方向キーか
      x--;
    } else if (keyCode == RIGHT) { // 右方向キーか
      x++;
    }
  }
  rect(x, 45, 50, 50);
}
```

## マッピング
```java
// 値の範囲を変更
void setup() {
  size(240, 120);
  strokeWeight(12);
}

void draw() {
  background(204);
  stroke(102);
  line(mouseX, 0, mouseX, height); // 灰色の線
  stroke(0);
  float mx = mouseX / 2 + 60;
  line(mx, 0, mx, height); // 黒い線
}
```

```java
// map() 関数でマッピング
void setup() {
  size(240, 120);
  strokeWeight(12);
}

void draw() {
  background(204);
  stroke(102);
  line(mouseX, 0, mouseX, height); // 灰色の線
  stroke(0);
  
  float mx = map(mouseX, 0, width, 60, 180);
  // 入力値(mouseX)を元の範囲(0 ~ width) から (60 ~ 180)の範囲にコンバートする

  line(mx, 0, mx, height);
}
```
- [map()](https://processing.org/reference/map_.html)

## Robot 3: Response

```java
float x = 60;
float y = 440;
int radius = 45;
int bodyHeight = 160;
int neckHeight = 70;

float easing = 0.04;

void setup() {
  size(360, 480);
  ellipseMode(RADIUS);
}

void draw() {
  strokeWeight(2);
  
  int targetX = mouseX;
  x += (targetX - x) * easing;
  
  if (mousePressed) {
    neckHeight = 16;
    bodyHeight = 90;
  } else {
    neckHeight = 70;
    bodyHeight = 160;
  }
  
  float neckY = y - bodyHeight - neckHeight - radius;
  background(0, 153, 204);
  
  // Neck
  stroke(255);
  line(x + 12, y - bodyHeight, x + 12, neckY);
  
  // Antena
  line(x + 12, neckY, x - 18, neckY - 43);
  line(x + 12, neckY, x + 42, neckY - 99);
  line(x + 12, neckY, x + 78, neckY + 15);
  
  // Body
  noStroke();
  fill(255, 204, 0);
  ellipse(x, y - 33, 33, 33);
  fill(0);
  rect(x - 45, y - bodyHeight, 90, bodyHeight - 33);
  
  // Head
  fill(0);
  ellipse(x + 12, neckY, radius, radius);
  fill(255);
  ellipse(x + 24, neckY - 6, 14, 14);
  fill(0);
  ellipse(x + 24, neckY - 6, 3, 3);
}
```
