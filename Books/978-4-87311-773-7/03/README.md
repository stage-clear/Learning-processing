# 描く
## ウィンドウを開く
```java
// ウィンドウを描く
size(800, 600);
```

```java
// 点を描く
size(480, 120);
point(240, 60);
```

## 基本的な図形
```java
// 線を描く
size(480, 120);
line(20, 50, 420, 110);
```

```java
// 基本的な図形を描く
size(480, 120);
quad(158, 55, 199, 14, 392, 351, 107);
triangle(347, 54, 392, 9, 392, 66);
triangle(158, 55, 290, 91, 290, 112);
```

```java
// 長方形を描く
size(480, 120);
rect(180, 60, 220, 40);
```

```java
size(480, 120);
ellipse(278, -100, 400, 400);
ellipse(120, 100, 110, 110);
ellipse(412, 60, 18, 18);
```

```java
// 円の一部を描く
size(480, 120);
arc(90, 60, 80, 80, 0, HALF_PI);
arc(190, 60, 80, 80, 0 PI + HALF_PI);
arc(290, 60, 80, 80, PI, TWO_PI + HALF_PI);
arc(390, 60, 80, 80, QUARTER_PI,  IP + QUARTER_PI);
```

```java 
// 度を使って描く
size(480, 120);
arc(90, 60, 80, 80, 0, radians(90));
arc(190, 60, 80, 80, 0, radians(270));
arc(290, 60, 80, 80, radians(180), radians(450));
arc(390, 60, 80, 80, radians(45), radians(225));
```

## 描画の順序

```java
// 描画の順序を意識する
size(480, 120);
ellipse(140, 0, 190, 190);
// 長方形は円のあとに描かれるので円の上に現れます
rect(160, 30, 260, 20);
```

```java
// 順序を逆にする
size(480, 120);
rect(160, 30, 260, 20);
// 長方形を先に描くよう変更したので円が上に現れます
ellipse(140, 0, 190, 190);
```

## 図形の性質

```java
// 線の太さを変える `strokeWeight()`
size(480, 120);
ellipse(75, 60, 90, 90);
strokeWeight(8); // 線の太さを 8px に
ellipse(175, 60, 90, 90);
ellipse(279, 60, 90, 90);
strokeWeight(20); // 線の太さを 20px に
ellipse(389, 60, 90, 90);
```

```java
// 線の両端の形を変える `strokeCap()`
size(480, 120);
strokeWeight(24);
line(60, 25, 130, 95);
strokeCap(SQUARE); // 直角の端
line(160, 25, 230, 95);;
strokeCap(PROJECT); // 突き出た端
line(260, 25, 330, 95);
strokeCap(ROUND); // 丸い端
line(360, 25, 430, 95);
```

```java
// 角の形状を変える `strokeJoin()`
size(480, 120);
strokeWeight(12);
rect(60, 25, 70, 70);
stokeJoin(ROUND); // 丸い角
rect(160, 25, 70, 70);
strokeJoin(BEVEL); // 斜めの角
rect(260, 25, 70, 70);
strokeJoin(MITER); // 直角
rect(360, 25, 70, 70);
```

## 描画モード
`mode` が付いている関数は描画時の基準点を変更します。

```java
size(480, 120);
rect(120, 60, 80, 80);
ellipse(120, 60, 80, 80);
ellipseMode(CORNER);
rect(280, 20, 80, 80);
elipse(280, 20, 80, 80);
```

- [ellipseMode()](https://processing.org/reference/ellipseMode_.html)

## 色
`background()` `fill()` `stroke()`

```java
// グレーを塗る
size(480, 120);
background(0); // 背景を黒に
fill(204);     // 明灰色を選択
ellipse(132, 82, 200, 200); // 明灰色の円
fill(153);     // 灰色を選択
ellipse(228, -16, 200, 200); // 灰色の円
fill(102); // 暗灰色
ellipse(268, 118, 200, 200); // 暗灰色の円
```

`noFill()` を実行したあとは、図形の内部を塗りつぶしません。 `noStroke()` は線の描画をオフにします。

```java
// 塗りと線の変更
size(480, 120);
fill(153);
ellipse(132, 82, 200, 200);
noFill();
ellipse(228, -16, 200, 200);
noStroke();
ellipse(268, 118, 200, 200);
```

```java
// 色付きの図形を描く
size(480, 120);
noStroke();
background(0, 26, 51);
fill(255, 0, 0);
ellipse(132, 82, 200, 200);
fill(0, 255, 0);
ellipse(228, -16, 200, 200);
fill(0, 0, 255)
ellipse(268, 118, 200, 200);
```

```java
// 透明度の設定
size(480, 120);
noStroke();
background(204, 226, 225);
fill(255, 0, 0, 160);
ellipse(132, 82, 200, 200);
fill(0, 255, 0, 160);
ellipse(268, -16, 200, 200);
fill(0, 0, 255, 160);
ellipse(268, 118, 200, 200);
```

## 形を作る
複数の点をつなぎ合わせて、新しい形を定義してみましょう

```java
// 矢印を描く
size(480, 120);
beginShape();
vertex(180, 82);
vertex(207, 36);
vertex(214, 63);
vertex(407, 11);
vertex(412, 30);
vertex(219, 82);
vertex(226, 109);
endShape();
```

`endShape()` に `CLOSE` を付け加えるとパスが閉じます
```java
// 隙間を閉じる
endShape(CLOSE);
```

```java
// 生物の創造
size(480, 120);

// 左の生き物
fill(153, 176, 180);
beginShape();
vertex(50, 120);
vertex(100, 90);
vertex(110, 60);
vertex(80, 20);
vertex(210, 60);
vertex(160, 80);
vertex(200, 90);
vertex(140, 100);
vertex(130, 120);
endShape();
fill(0);
ellipse(155, 60, 8, 8);

// 右の生き物
fill(176, 186, 163);
beginShape();
vertex(370, 120);
vertex(360, 90);
vertex(290, 80);
vertex(340, 70);
vertex(280, 50);
vertex(420, 10);
vertex(390, 50);
vertex(410, 90);
vertex(460, 120);
endShape();
fill(0);
ellipse(345, 50, 10, 10);
```

## コメント

```java
// ダブルスラッシュの後ろに描かれたテキストは実行時に無視されます
```

