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
// 円をらせんに変えるために必要なコード
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
  y = centy + (radius * sin(rad));
  if (lastx > -999) {
    line(x, y, lastx, lasty);
  }
  lastx = x;
  lasty = y;
}
```

```processing
// らせんにノイズを加える
radius = 10;
float x, y;
float lastx = -999;
float lasty = -999;
float radiusNoise = random(10); // <-
for (float ang = 0; ang <= 1440; ang += 5) {
  radiusNoise += 0.05; // <- 
  radius += 0.5;
  float thisRadius = radius + (noise(radiusNoise) * 200) - 100; // <-
  float rad = radians(ang);
  x = centx + (thisRadius * cos(rad));
  y = centy + (thisRadius * sin(rad));
  if (lastx > -999) {
    line(x, y, lastx, lasty);
  }
  lastx = x;
  lasty = y;
}
```

```processing
// ノイズを加えた100のらせん
size(500, 300);
background(255);
strokeWeight(0.5); // <- より洗練された線
smooth();

int centx = 250;
int centy = 150;

float x, y;
for (int i = 0; i < 100; i++) { // <- 100 のらせんを描く
  float lastx = -999;
  float lasty = -999;
  float radiusNoise = random(10);
  float radius = 10;
  stroke(random(20), random(50), random(70), 80); // らせんの要素をランダムにする
  
  int startangle = int(random(360));
  int endangle = 1440 + int(random(1440));
  int anglestep = 5 + int(random(3));
  for (float ang = startangle; ang <= endangle; ang += anglestep) {
    radiusNoise += 0.05;
    radius += 0.5;
    float thisRadius = radius + (noise(radiusNoise) * 200) - 100;
    float rad = radians(ang);
    x = centx + (thisRadius * cos(rad));
    y = centy + (thisRadius * sin(rad));
    if (lastx > -999) {
      line(x, y, lastx, lasty);
    }
    lastx = x;
    lasty = y;
  }
}
```

### 自分のノイズを作る。ふたたび

- 関数ブロックの中に円の描画部分を書き直す
- customNoise 関数を加える

```processing
void setup() {
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
  strokeWeight(1);
  
  float x, y;
  float noiseval = random(0); // 開始点をランダムにします
  float radVariance, thisRadius, rad; // <-
  beginShape(); // <- beginShape と endShape で閉じられたエリアを描きます
  fill(20, 50, 70, 50);
  for (float ang = 0; ang <= 360; ang += 1) {
    noiseval += 0.1; // <-
    radVariance = 30 * customNoise(noiseval);
    
    thisRadius = radius + radVariance;
    rad = radians(ang);
    x = centx + (thisRadius * cos(rad));
    y = centy + (thisRadius * sin(rad));
    
    curveVertex(x, y); // <-
  }
  endShape(); // <-
}

float customNoise(float value) {
  float retValue = pow(sin(value), 3); // サインの3乗を返す
  return retValue;
}
```

サインのべき乗をパラメータとして、そのべき乗の値を返す関数を作ってみます

```processing
float customNoise(float value) {
  int count = int((value % 12));
  float retValue = pow(sin(value), count);
  return retValue;
}
```
