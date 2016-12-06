# Processing: アーティストのためのプログラミング言語

## プログラムでお絵描き
### 関数、パラメータ、色値

```processing
// 設定と背景
size(500, 300);
smooth();
background(230, 230, 230);
// 2本の交差した直線を描く
stroke(130, 0, 0);
strokeWeight(4);
line(width / 2 - 70, height / 2 - 70, width / 2 + 70, height / 2 + 70);
line(width / 2 + 70, height / 2 - 70, width / 2 - 70, height / 2 + 70);
// 円を描く
fill(255, 150);
ellipse(width / 2, height / 2, 50, 50);
```

```processing
// キャンバスの大きさを500px x 300px に設定します
size(500, 300);

// スムージングをかけて、描く直線にアンチエイリアスを加え、ガタガタに見えないようにします。
smooth();

// 背景をグレーに設定します
background(230, 230, 230);
```

### 線、スタイル、座標
```processing
stroke(130, 0, 0);
strokeWeight(4);

line(width / 2 - 70, height / 2 - 70, width / 2 + 70, height / 2 + 70);
```

### 変数
```processing
float centX = width / 2;
float centY = height / 2;
line(centX - 70, centY - 70, centX + 70, centY + 70);
line(centX + 70, centY - 70, centX - 70, centY + 70);
```

### 塗りつぶし、アルファ値、描画の順序

```processing
fill(255, 150);
ellipse(width / 2, height / 2, 50, 50);
```

## 構造、論理、アニメーション
### フレームループ
```processing
int diam = 10;
float centX, centY;

void setup() {
  size(500, 500);
  frameRate(24); // 毎秒24フレーム
  smooth();
  background(180);
  centX = width / 2;
  centY = height / 2;
  stroke(0);
  strokeWeight(5);
  fill(255, 50);
}

void draw() {
  if (diam <= 400) {
    background(180); // 背景はすべてのフレームでクリアされます
    ellipse(centX, centY, diam, diam);
    diam += 10; // 次のループのたびに直径を広げます
  }
}
```

多くのプログラマーは混乱しないように、グローバル変数の名前にアンダーバー `_` をつけています
```processing
int _num = 20;

void draw() {
  int inc = 10;
  _num = _num + inc;
}
```

### 自分の関数を書く

```processing
データ型 関数名( [パラメータ] ) {
  // コードをここに記述
}
```

```processing
void setup() {
  int x = AddNumbers(1, 2);
  println(x);
}

int AddNumbers(int a, int b) {
  int returnValue = a + b;
  return returnValue;
}
```

### 演算子
```processing
float a = 45;
float b = 5;
float c = 4;
float sum1 = (a + b) * (b * c);
float sum2 = a / (b + c);
```

- `ceil()` - 最も整数切り上げ
- `floor()` - 最も近い整数まで切り下げ
- `round()` - 最も近い整数まで切り上げ。または切り下げ
- `min()` - 渡された数の中の最小値を返す
- `max()` - 渡された数の中の最大値を返す

切り上げ、切り下げに関わる3つの関数は、少数を整数に変換するときに便利です

```processing
int centX = floor(width / 2);
```

### 条件文
```processing
if (diam < 400) { ... }
```

```processing
// 条件をチェック
if (diam <= 400) {
  // もし diam が <= 400 ならこのコードを実行
} else {
  // もし diam が > 400 ならこのコードを実行
}
```

論理演算子を使って条件をまとめることもできます
```processing
String likeStr;
if ((likeStr == "pina colada") || (likeStr === "getting lost in the rain")) {
  println("come with me escape");
}
```
条件文は、好きなだけ入れ子構造にすることができます

```processing
int man = 5;
int devil = 6;
int god = 7;
if (man == 5) {
  if (devil == 6) {
    if (god == 7) {
      goTOHeaven("monkey");
    }
  }
}
```

次のようにしても同じ結果が得られます
```processing
if ((man == 5) && (devil == 6) && (god == 7)) {
  goToHeaven("monkey")
}
```

## 繰り返し
### while ループ
```processing
int bass = 99;
while(bass > 0) {
  println(bass);
  bass--;
}
println("how low can you go");
```

```processing
int diam = 10;
float centX, centY;

void setup() {
  size(500, 300);
  frameRate(24);
  
  smooth();
  background(180);
  centX = width / 2;
  centY = height / 2;
  stroke(0);
  strokeWeight(5);
  fill(255, 50);
}

void draw() {
  if (diam <= 400) {
    background(180);
    
    strokeWeight(5);
    fill(255, 50);
    int tempdiam = diam;
    while(tempdiam > 10) {
      ellipse(centX, centY, tempdiam, tempdiam);
      tempdiam -= 10;
    }
    
    diam += 10;
  }
}
```

### 痕跡を残す
```processing
int diam = 10;
float centX, centY;

void setup() {
  size(500, 300);
  frameRate(24);
  smooth();
  background(180);
  centX = width / 2;
  centY = height / 2;
  stroke(0);
  strokeWeight(1);
  noFill();
  // fill(255, 25);
}

void draw() {
  if (diam <= 400) {
    // background(180); // この行をコメントアウト
    ellipse(centX, centY, diam, diam);
    diam += 10;
  }
}
```

### for ループ
```processing
for ([最初の状態]; [終了条件]; [回数]) {
  // 実行したいコード
}
```

```processing
void setup() {
  size(500, 300);
  background(180);
  strokeWeight(4);
  strokeCap(SQUARE); // 線の末端をスクエアに
  for (int h = 10; h <= (height - 15); h += 10) {
    stroke(0, 255 - h);
    line(10, h, width - 20, h);
    stroke(255, h);
    line(10, h + 4, width, h + 4);
  }
}
```
