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
