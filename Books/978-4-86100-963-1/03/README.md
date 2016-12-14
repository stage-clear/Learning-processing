# 3. 線を引く間違った方法
<sup>_The Wrong Way to Draw a Line_</sup>
## デタラメさとそうでもないこと

```processing
// 20 から 480 までの範囲の値
float randnum = random(460) + 20;

// もしくは
float randnum = random(20, 480);
```

乱数の範囲を指定できる便利な記述方法が必ずしも用意されているとは限りません。  
パラメータを用いずに乱数の値の範囲を表現してみます。
```processing
float randnum = (random(1) * (max - min)) + min;
```

```processing
size(500, 500);
background(255);
strokeWeight(5);
smooth();

stroke(20, 50, 70)
line(20, 50, 480, 50);
```

```processing
stroke(0, 30);
line(20, 50, 480, 50);

stroke(20, 50, 70);
float randx = random(width);
float randy = random(height);
line(20, 50, randx, randy);
```

## 変化の繰り返し

```processing
// まっすぐな線
int step = 10;
float lastx = -999;
float lasty = -999;
float y = 50;
int border = 20;
for (int x = border; x <= width - border; x += step) {
  if (lastx > -999) {
    line(x, y, lastx, lasty);
  }
  
  lastx = x;
  lasty = y;
}
```

```processing
// 1ステップごとに y の値を変える命令を加える
int step = 10;
float lastx = -999;
float lasty = -999;
float y = 50;
int borderx = 20;
int bordery = 10;
for (int x = borderx; x <= width - borderx; x += step) {
  y = bordery + random(height - 2 * bordery); // <-
  if (lastx > -999) {
    line(x, y, lastx, lasty);
  }
  lastx = x;
  lasty = y;
}
```

```processing
// ランダム値を y の値に加算または減算することで、もっと自然な変化を表現します
float xstep = 10;
float ystep = 10;
float lastx = 20;
float lasty = 50;
float y = 50;
for (int x = 20; x <= 480; x += xstep) {
  ystep = random(20) - 10; // range -10 to 10
  y += ystep; // <-
  line(x, y, lastx, lasty);
  lastx = x;
  lasty = y;
}
```

## 自然な変動
### Processing でのパーリンノイズ

```processing
// パーリンノイズ
size(500, 100);
background(255);
strokeWeight(5);
smooth();

stroke(0, 30);
line(20, 50, 480, 50);

stroke(20, 50, 70);
int step = 10;
float lastx = -999;
float lasty = -999;
float ynoise = random(10); // <-
float y;
for (int x = 20; x <= 480; x += step) {
  y = 10 + noise(ynoise) * 80; // <-
  if (lastx > -999) {
    line(x, y, lastx, lasty);
  }
  lastx = x;
  lasty = y;
  ynoise += 0.1;
}
```

### 自分のノイズを作る

```processing
// サインカーブを作る
float step = 1;
float lastx = -999;
float lasty = -999;
float angle = 0;
float y = 50;
for (int x = 20; x <= 480; x += step) {
  float rad = radians(angle);
  y = 50 + (sin(rad) * 40); // <-
  if (lastx > -999) {
    line(x, y, lastx, lasty);
  }
  
  lastx = x;
  lasty = y;
  angle++;
}
```

もしあなたが `sin` 乗したら、どのように見えるでしょう

```processing
y = 50 + (pow(sin(rad), 3) * 30)
```

あるいはノイズを加えてみたらどうでしょう

```processing
y = 50 + (pow(sin(rad), 3) * noise(rad * 2) * 30)
```

### 自分だけのランダム関数
```proessing
float customRandom() {
  float retValue = 1 - pow(random(1), 5);
  return retValue;
}
```

y の位置を計算するときにこの関数を使ってみます

```processing
void setup() {
  size(500, 500);
  
  float step = 1;
  float lastx = -999;
  float lasty = -999;
  float angle = 0;
  float y = 50;
  for (int x = 20; x <= 480; x += step) {
    flaot rad = radians(angle);
    y = 20 + (customRandom() * 60);
    if (lastx > -999) {
      line(x, y, lastx, lasty);
    }
    lastx = x;
    lasty = y;
    angle++
  }
}

float customRandom() {
  float retvalue = 1 - pow(random(1), 5);
  return retValue;
}
```
