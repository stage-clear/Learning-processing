# メディア

メディアファイルの追加
1. 新しいスケッチを作成
2. Sketch メニューの Add File を実行しファイルを選択

または、Processing ウィンドウのエディタ領域へ追加したいファイルをドラッグ&ドロップする方法もあります。

## 画像

```java
// 画像を読み込む
PImage img;

void setup() {
  size(480, 120);
  img = loadImage("lunar.jpg");
}

void draw() {
  image(img, 0, 0);
}
```

- [PImage](https://processing.org/reference/PImage.html)

```java
// 複数の画像を読み込む
PImage img1;
PImage img2;

void setup() {
  size(480, 120);
  img1 = loadImage("lunar.jpg");
  img2 = loadImage("capsule.jpg");
}

void draw() {
  image(img1, -120, 0);
  image(img1, 130, 0, 240, 120);
  image(img2, 300, 0, 240, 120);
}
```

```java
// 画像をマウスで動かす
PImage img;

void setup() {
  size(480, 120);
  img = loadImage("lunar.jpg");
}

void draw() {
  background(0);
  image(img, 0, 0, mouseX * 2, mouseY * 2);
}
```

```java
// 透明なGIF
PImage img;

void setup() {
  size(480, 120);
  img = loadImage("clouds.gif");
}

void draw() {
  background(255);
  image(img, 0, 0);
  image(img, 0, mouseY * -1);
}
```

```java
// 透明なPNG
PImage img;

void setup() {
  size(480, 120);
  img = loadImage("clouds.png");
}

void draw() {
  background(204);
  image(img, 0, 0);
  image(img, 0, mouseY * - 1);
}
```

## フォント
Processing は TrueType フォント(.ttf) または OpenTypeフォント(.otf) を使ってテキストを表示することができます。

- [Google Fonts](http://www.google.com/fonts)
- [The Open Font Library](https://fontlibrary.org)
- [The League of Moveable Type](https://www.theleagueofmoveabletype.com)

1. フォントを dataフォルダに追加
2. フォントを格納する PFont 変数を作成
3. `createFont()` を使ってフォントを変数に割り当てる。この処理でフォントファイルを読み込み、Processing が必要とするサイズのフォントを作成
4. `textFont()` 関数を使って使用フォントを変更

```java
// フォントを使って描く
PFont font;

void setup() {
  size(480, 120);
  font = createFont("SourceCodePro-Regular.ttf", 32);
  textFont(font);
}

void draw() {
  background(102);
  textSize(32);
  text("That's one small step for man...", 25, 60);
  textSize(16);
  text("That's one small step for man...", 27, 90);
}
```

- [createFont()](https://processing.org/reference/createFont_.html)
- [textFont()](https://processing.org/reference/textFont_.html)
- [textSize()](https://processing.org/reference/textSize_.html)
- [text()](https://processing.org/reference/text_.html)

```java
// 箱の中にテキストを描く
PFont font;

void setup() {
  size(480, 120);
  font = createFont("SourceCodePro-Regular.ttf", 24);
  textFont(font);
}

void draw() {
  background(102);
  text("That's one small step for man...", 26, 24, 240, 100);
}
```

```java
// テキストを String 変数に記憶する
PFont font;
String quote = "That's one small step for man...";

void setup() {
  size(480, 120);
  font = createFont("SourceCodePro-Regular.ttf", 24);
  textFont(font);
}

void draw() {
  background(102);
  text(quote, 26, 24, 240, 100);
}
```

## ベクタ画像

1. SVGファイルを data フォルダへ追加
2. ベクタデータを格納する PShape 変数を作成
3. loadShape() でデータを変数に読み込む

```java
// ベクタ画像を描く
PShape network;

void setup() {
  size(480, 120);
  network = loadShape("network.svg");
}

void draw() {
  background(0);
  shape(network, 30, 10);
  shape(network, 180, 10, 280, 280);
}
```

```java
// ベクタ画像の拡大縮小
PShape network;

void setup() {
  size(240, 120);
  shapeMode(CENTER);
  network = loadShape("network.svg");
}

void draw() {
  background(0);
  float diameter = map(mouseX, 0, width, 10, 800);
  shape(network, 120, 60, diameter, diameter);
}
```

> Processing の SVGサポートは完全ではありません。

- [PShape](https://processing.org/reference/PShape.html)

```java
// 新しい形を作る
PShape dino;

void setup() {
  size(480, 120);
  dino = createShape();
  dino.beginShape();
  dino.fill(153, 176, 180);
  dino.vertex(50, 120);
  dino.vertex(100, 90);
  dino.vertex(110, 60);
  dino.vertex(80, 20);
  dino.vertex(210, 60);
  dino.vertex(160, 80);
  dino.vertex(200, 90);
  dino.vertex(140, 100);
  dino.vertex(130, 120);
  dino.endShape();
}

void draw() {
  background(204);
  translate(mouseX - 120, 0);
  shape(dino, 0, 0);
}
```
- [createShape()](https://processing.org/reference/createShape_.html)

## Robot5: Media

```java
PShape bot1;
PShape bot2;
PShape bot3;
PImage: landscape;

float easing = 0.05;
float offset = 0;

void setup() {
  size(720, 480);
  bot1 = loadShape("robot1.svg");
  bot2 = loadShape("robot2.svg");
  bot3 = loadShape("robot3.svg");
  landscape = loadImage("alpine.png");
}

void draw() {
  // "landscape" を背景にします
  // この画像はウィンドウと同じ大きさにする必要があります
  background(landscape);
  
  // 左右の間隔を設定し、イージングによって滑らかに移動させます
  flaot targetOffset = map(mouseY, 0, height, -40, 40);
  offset += (targetOffset - offset) * easing;
  
  // 左のロボットを描きます
  shape(bot1, 85 + offset, 65);
  
  // 右のロボットは少し小さく描き、オフセットも少なくします
  float smallerOffset = offset * 0.7;
  shape(bot2, 510 + smallerOffset, 140, 78, 248);
  
  // 一番小さいロボットを描きます。オフセットは最小です
  smallerOffset += -0.5;
  shape(bot3, 410 + smallerOffset, 225, 39, 124);
}
```
