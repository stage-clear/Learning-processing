# 円を描く間違った方法
## 回転するドローイング
### 初めて円を描く

```processing
ellipse(中心のx座標, 中心のy座標, 幅, 高さ)
```

sin x = opp / hyp (対辺/斜辺) と cos x = adj/hyp (隣辺/斜辺)

```processing
x = centerx + (radius * cos(angle));
y = centery + (radius * sin(angle));
```

> __ラジアンと度__
> 三角関数で使われる角度は「度」ではなく「ラジアン」です。1ラジアンは 180/π と等しく、円をフル回転（360度）すろと 2π ラジアンとなります。
> もしラジアンが苦手なら、普段は角度を使って、三角関数を呼び出す際に変換してもよいです。
> 変換の公式は、ラジアン = 角度 * (180 / π) 。
> とはいえ、Processing には、既に組み込みの2つの便利な変換関数（__degree__ と __radian__） があります。

```processing
size(500, 300);
background(255);
strokeWeight(5);
smooth();

float radius = 100;
int centx = 250;
int centy = 150;

stroke(0, 30);
noFill();
ellipse(centx, centy, radius * 2, radius * 2);

stroke(20, 50, 70);
float x, y;
float lastx = -999;
float lasty = -999;

for (float ang = 0; ang <= 360; ang += 5) {
  float rad = radians(ang);
  x = centx + (radius * cos(rad));
  y = centy + (radius * sin(rad));
  point(x, y);
}
```

### 円をらせんに変える

```processing
size(500, 300);
background(255);
strokeWeight(5);
smooth();

float radius = 100;
int centx = 250;
int centy = 150;

stroke(0, 30);
noFill();
ellipse(centx, centy, radius * 2, radius * 2);

radius = 10;
float x, y;
float lastx = -999;
float lasty = -999;
for (float ang = 0; ang <= 1440; ang += 5) {
  radius += 0.5;
  float rad = radians(ang);
  x = centx + (radius * cos(rad));
  y = centy + (radius + sin(rad));
  if (lastx > -999) {
    line(x, y, lastx, lasty);
  }
  lastx = x;
  lasty = y;
}
```
