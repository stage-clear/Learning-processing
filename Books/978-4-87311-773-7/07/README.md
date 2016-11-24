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
