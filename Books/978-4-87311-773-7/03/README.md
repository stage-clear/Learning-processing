# 描く
## ウィンドウを開く
```processing
// ウィンドウを描く
size(800, 600);
```

```processing
// 点を描く
size(480, 120);
point(240, 60);
```

## 基本的な図形
```processing
// 線を描く
size(480, 120);
line(20, 50, 420, 110);
```

```processing
// 基本的な図形を描く
size(480, 120);
quad(158, 55, 199, 14, 392, 351, 107);
triangle(347, 54, 392, 9, 392, 66);
triangle(158, 55, 290, 91, 290, 112);
```

```processing
// 長方形を描く
size(480, 120);
rect(180, 60, 220, 40);
```

```processing
size(480, 120);
ellipse(278, -100, 400, 400);
ellipse(120, 100, 110, 110);
ellipse(412, 60, 18, 18);
```

```processing
// 円の一部を描く
size(480, 120);
arc(90, 60, 80, 80, 0, HALF_PI);
arc(190, 60, 80, 80, 0 PI + HALF_PI);
arc(290, 60, 80, 80, PI, TWO_PI + HALF_PI);
arc(390, 60, 80, 80, QUARTER_PI,  IP + QUARTER_PI);
```

```processing 
// 度を使って描く
size(480, 120);
arc(90, 60, 80, 80, 0, radians(90));
arc(190, 60, 80, 80, 0, radians(270));
arc(290, 60, 80, 80, radians(180), radians(450));
arc(390, 60, 80, 80, radians(45), radians(225));
```

## 描画の順序

```processing
// 描画の順序を意識する
size(480, 120);
ellipse(140, 0, 190, 190);
// 長方形は円のあとに描かれるので円の上に現れます
rect(160, 30, 260, 20);
```

```processing
// 順序を逆にする
size(480, 120);
rect(160, 30, 260, 20);
// 長方形を先に描くよう変更したので円が上に現れます
ellipse(140, 0, 190, 190);
```

## 図形の性質
