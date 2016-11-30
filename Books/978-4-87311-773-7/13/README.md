# 拡張 _Extend_

Processing には標準のライブラリに加えて、100以上の寄稿されたライビラリがあります。
- [Libraries / Processing](https://processing.org/reference/libraries/)
寄稿されたライブラリを使うときは、Sketch メニューで選ぶ前に管理機能 (Contribution Manager) を使って追加する必要があります。

## サウンド

```java
// サウンドを再生する
import processing.sound.*;

SoundFile blip;
int radius = 120;
float x = 0;
float speed = 1.0;
int direction = 1;

void setup() {
  size(440, 440);
  ellipseMode(RADIUS);
  blip = new SoundFile(this, "blip.wav");
  x = width / 2; // 中央からスタート
}

void draw() {
  background(0);
  x += speed * direction;
  if ((x > width - radius) || (x < radius)) {
    direction = -direction; // 侵攻方向
    blip.play();
  }
  
  if (direction == 1) {
    arc(x, 220, radius, radius, 0.52, 5.76); // 右向き
  } else {
    arc(x, 220, radius, radius, 3.67, 8.9); // 左向き
  }
}
```

```java
// マイクの音を聴く
import processing.sound.*;

AudioIn mic;
Amplitude amp;

void setup() {
  size(440, 440);
  background(0);
  // オーディオ入力を有効化
  mic = new AudioIn(this, 0);
  mic.start();
  // 振幅（音量）を分析するクラスをマイクに接続
  amp = new Amplitude(this);
  amp.input(mic);
}

void draw() {
  // 暗い色の背景
  noStroke();
  fill(26, 76, 102, 10);
  rect(0, 0, width, height);
  // analize() メソッドは 0 から 1の値を返すので
  // map() を使ってウィンドウサイズに合った値を変換
  float diameter = map(amp.analyze(), 0, 1, 10, width);
  // 音量を表す円を描く
  fill(255);
  ellipse(width / 2, height / 2, diameter, diameter);
}
```
合成の基礎となる波形には、サイン波、矩形波、三角波などがあり、サイン波はスムースな音、矩形波は不快な音、三角波はその中間的な音です。

```java
// サイン波を生成する
// mouseX の値を基に、サイン波の周波数を決定します
import processing.sound.*;

SinOsc sine;
float freq = 400;

void setup() {
  size(400, 440);
  // サイン波発振器の動作開始
  sine = new SinOsc(this);
  sine.play();
}

void draw() {
  background(176, 204, 176);
  // mouseX の値を周波数(20Hzから440Hz)へ変換
  float hertz = map(mouseX, 0, width, 20.0, 440.0);
  sine.freq(hertz);
  // 現在の周波数を基に波形を表示
  stroke(26, 76, 102)
  for (int x = 0; x < width; x++) {
    float angle = map(x, 0, width, 0, TWO_PI * hertz);
    float sinValue = sin(angle) * 120;
    line(x, 0, x, height / 2 + sinValue);
  }
}
```

## 画像やPDFの保存
デフォルトの画像フォーマットは TIFF です。

```java
saveFrame("output-####.png");
saveFrame("frames/output-####.png");
```

> `draw()` のなかで `saveFrame()` を実行すると、フレームごとに新しいファイルが作成されます。
> 長時間実行すると、スケッチフォルダが数千のファイルで埋め尽くされてしまうので、注意しましょう

```java
// 画像の保存
PShape bot;
float x = 0;

void setup() {
  size(720, 480);
  bot = loadShape("robot1.svg");
  frameRate(30);
}

void draw() {
  translate(x, 0);
  shape(bot, 0, 80);
  saveFrame("frames/SaveExample-####.tif");
  x += 12;
  
  if (frameCount > 60) {
    exit();
  }
}
```

```java
// PDF として描く
// 描画結果は画面に現れず、スケッチフォルダ内のPDFに直接出力されます
import processing.pdf.*;
PShape bot;

void setup() {
  size(600, 800, PDF, "Ex-13-5.pdf");
  bot = loadShape("robot1.svg");
}

void draw() {
  background(0, 153, 204);
  for (int i = 0; i < 100; i++) {
    float rx = random(-bot.width, width);
    float ry = random(-bot.height, height);
    shape(bot, rx, ry);
  }
  exit();
}
```

このほかにもPDF出力のテクニック
