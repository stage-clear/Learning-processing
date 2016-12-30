# マウスとキーボードを使う
## マウスを追いかける
```processing
// マウスに着いてくる円
void setup() {
  size(480, 120);
  smooth();
  fill(0, 100);
  noStroke();
}

void draw() {
  ellipse(mouseX, mouseY, 40, 40);
}
```

```processing
// 円を描く前に背景を塗りつぶすので
// 円の跡を残さない
void setup() {
  size(480, 120);
  smooth();
  fill(0, 100);
  noStroke();
}

void draw() {
  background(204);
  ellipse(mouseX, mouseY, 40, 40);
}
```

```processing
// pmouseX と pmouseY を使って
// 現在地と直前の座標の距離を計算します
void setup() {
  size(480, 120);
  smooth();
  fill(0, 100);
  noStroke();
}

void draw() {
  float d = dist(mouseX, mouseY, pmouseX, pmouseY);
  ellipse(mouseX, mouseY, d, d);
}
```

## if ブロック

```processing
if (test) {
  statement
}
```

```processing
// マウスボタンが押されている間は白に、
// 押されていない時は黒に塗りつぶします.
void setup() {
  size(480, 120);
  smooth();
  noStroke();
}

void draw() {
  background(128);
  fill(0);
  if (mousePressed == true) {
    fill(255);
  }
  ellipse(mouseX, mouseY, 40, 40);
}
```

```processing
if (test) {
  statement1
} else {
  statement2
}

if (test1) {
  statement1
} else if (test2) {
  statement2
}
```

## キーボードに反応する

```processing
void setup() {
  size(480, 120);
  smooth();
  noStroke();
}

void draw() {
  background(100);
  color cl = color(128);
  if (keyPressed == true) {
    if (key == 'r') {
      cl = color(255, 0, 0);
    } else 
    if (key == 'g') {
      cl = color(0, 255, 0);
    } else {
      cl = color(0, 0, 255);
    }
  }
  fill(cl);
  ellipse(mouseX, mouseY, 40, 40);
}
```
