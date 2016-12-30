# 図形を描く
## 基本図形を描く
```processing
// 点 - point
size(120, 120);
point(60, 60);
```

```processing
// 線 - line
size(120, 120);
line(20, 100, 100, 20);
```

```processing
// 三角形 - triangle
size(120, 120);
triangle(20, 20, 90, 50, 60, 100);
```

```processing
// 四角形 - quad
size(120, 120);
quad(30, 20, 100, 50, 70, 100, 20, 80);
```

```processing
// 長方形 - rect
size(120, 120);
rect(20, 40, 80, 40);
```

```processing
// 楕円 - ellipse
size(120, 120);
ellipse(60, 60, 80, 40);
```

```processing
// 扇型
size(120, 120);
arc(60, 60, 110, 110, PI / 4, 7 * PI / 4);
```

## 描く順序
上から順に1行ずつ実行していきます

```processing
// 長方形の上に円
size(120, 120);
rect(60, 20, 230, 60);
ellipse(380, 70, 80, 80);
```

```processing
// 円の上に長方形
size(480, 120);
ellipse(380, 70, 80, 80);
rect(60, 20, 320, 60);
```

## 属性の変更

- `smooth()` - 図形の外形線 (edge) を滑らかに表現します。
- `noSmooth()` - 滑らかな表示から通常の表示に戻します。

```processing
// 滑らかな線で描く
size(480, 120);
noSmooth();
ellipse(160, 60, 100, 100);
smooth();
ellipse(300, 60, 100, 100);
```

```processing
// 線の太さ
size(480, 120);
smooth();
strokeWeight(1);
rect(40, 30, 70, 70);
strokeWeight(2);
rect(118, 30, 70, 70);
strokeWeight(4);
rect(198, 30, 70, 70);
strokeWeight(8);
rect(280, 30, 70, 70);
strokeWeight(12);
rect(365, 30, 70, 70);
```

- `strokeJoin()` - 角の形状を指定することができます
- `strokeCap()` - 線の始点と終点の形状を指定することができます

```processing
// 線の種類
size(480, 120);
smooth();
strokeWeight(12);
strokeJoin(ROUND);
rect(60, 30, 60, 60);
strokeJoin(BAVEL);
rect(160, 30, 60, 60);
strokeCap(ROUND);
line(270, 30, 420, 30);
strokeCap(SQUARE);
line(270, 60, 420, 60);
strokeCap(PROJECT);
line(270, 90, 420, 90);
```

## 色で描く
- `background()` - ウィンドウの背景色
- `fill()` - 図形の色
- `stroke()` - 図形の外形線

```processing
// 塗りつぶしと背景線
size(480, 120);
smooth();
background(255);
fill(200);
rect(20, 10, 140, 100);
noFill();
rect(170, 10, 140, 100);
noStroke();
fill(100);
rect(320, 10, 140, 100);
```

```processing
// 色で描く
size(480, 120);
smooth();
background(0, 100, 200);  // light blue
fill(255, 0, 0);          // red
rect(25, 10, 100, 100);
fill(0, 255, 0);          // green
rect(135, 10, 100, 100);
fill(0, 0, 255);          // blue
rect(245, 10, 100, 100);
fill(100, 100, 100);      // gray
rect(355, 10, 100, 100);
```

```processing
// 透明度を指定する
size(480, 120);
smooth();
background(255);
fill(0, 255, 0);
rect(15, 40, 450, 40);
fill(255, 0, 0, 255);
rect(25, 10, 100, 100);
fill(255, 0, 0, 128);
rect(135, 10, 100, 100);
fill(255, 0, 0, 64);
rect(245, 10, 100, 100);
fill(255, 0, 0, 0);
rect(355, 10, 100, 100);
```

## setup と draw
- `setup()` - プログラムが起動されたとき先頭から順に一回だけ実行されます
- `draw()` - プログラムが停止するまでずっと繰り返し実行され続けます

```processing
// setup 関数の動作
void setup() {
  println("setup");
}
```

```processing
// draw() 関数の動作
void draw() {
  println(frameCount);
}
```

```processing
// マウスの動きに応じて縦線が描かれる
void setup() {
  size(480, 120);
  smooth();
}

void draw() {
  line(mouseX, 0, mouseX, 120);
}
```

## 関数
