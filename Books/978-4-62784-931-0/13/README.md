# 反応と拡散が作る生物の模様
## 動物の表皮
> 動物の表皮にはさまざまな模様があります. この模様についてチューリングは
> 「化学反応の組み合わせが波を発生させ, それが模様のもとになる」という仮説をたてました.

## 反応拡散方程式
(書籍のP107を参照)

## 変数の準備
セルの領域の大きさは `n x n` 個とし, 100を設定します.
セル1個のサイズは `m x m` とし, 4と設定します.

```processing
int n = 100, m = 4;
```
活性因子u を変数 `u` とします.
また, 周囲に仮想のセルが必要なので、 `(n+2) x (n+2)` 個だけ用意します.
抑制因子 `v` についても同様です.

```processing
float[][] u = new float[n + 2][n + 2];
float[][] v = new float[n + 2][n + 2];
```

これらに今現在の状態を保存するなら, 次の時刻の状態を保存するにも
同じような変数を用意する必要があります.

```processing
flaot[][] u1 = new float[n + 2][n + 2];
float[][] v2 = new float[n + 2][n + 2];
```

時間間隔 `dt`, セルの間隔 `h`, 反応項にある `a, b`, 拡散項にある `Cu, Cv` も
それぞれ float 型の変数 `dt, h, a, b, cu, cv` とします.

```processing
float dt = 0.5, h = 0.1, h2 = h * h;
float a = 0.024, b = 0.078;
flaot cu = 0.002, cv = 0.001;
```

## 表示
`clear()` 関数は, `u` の値をすべて1に `v` の値をすべて0に設定します.
この場合, `f(u,v) = g(u,v) = 0` となります.
また, すべてが1または0ですから `Δu = Δv = 0` となります.
すると濃度変化の速度 `au/at =  av/at = 0` となり, 状態に変化がしょうじないということになります.

```processing
u[i][j] = 1;
v[i][j] = 0;
```

`display()` 関数は, セルの状態 `u` と `v` を色に換算して正方形を描くための関数です.
`u` の値を255倍して赤の成分の強さを, また `v` の値を255倍して緑の成分の強さを計算し, 大きさ `m x m` の正方形を描きます.
青の成分は0のままです.

```processing
fill(u[i][j] * 255, v[i][j] * 255, 0);
rect((i - 1) * m, (j - 1) * m, m, m);
```

## 境界処理
`boundry()` 関数は, 領域の端部でも微分を近似できるように境界処理をする関数です.
セルオートマトンのところで考えたように周期境界条件を設定します.
`u` に対して上下つながった, また左右もつながった円筒のような状況を考え

```processing
u[i][0] = u[i][n];
u[i][n + 1] = u[i][1];
u[0][i] = u[n][i];
u[n + 1][i] = u[1][i];
```

## 更新
`update` 関数は, 今現在の `u, v` の値をもとにして次の時刻の値 `u1, v1` を計算します.

```processing
u1[i][j] = u[i][j] * (cu * Du + f) * dt;
v1[i][j] = v[i][j] * (cv * Dv + g) * dt;
```

`Δu` の項を `Du`, `Δv` の項を `Dv`, `𝑓(u,v)` の項を `f`, `g(u,v)` の項を `g` としています.

```processing
float Du = (u[i + 1][j] + u[i][j + 1] + u[i - 1][j] + u[i][j - 1] - 4 * u[i][j]) / h2;
float Dv = (v[i + 1][j] + v[i][j + 1] + v[i - 1][j] + v[i][j - 1] - 4 * v[i][j]) / h2;
```

すべてのせるに対して `u1, v1` が計算できたら, これらを `u, v` にコピーします.
```processing
u[i][j] = u1[i][j];
v[i][j] = v1[i][j];
```

## マウス
画面上のマウス位置を示す `mouseX, mouseY` をセルのサイズ `m` で割り1を加えると,
どのセルをクリックしたかがわかります.
そのセルを中心として半径8以内の領域にたいして, `u` の値をほぼ0.6に, `v` の値をほぼ 0.2 に設定しています.
「ほぼ」というところが大事です.

```processing
u[i][j] = 0.6 + random(-0.06, 0.06);
v[i][j] = 0.2 + random(-0.02, 0.02);
```

## キーボード
c が押されたら `clear()` 関数で初期化が行われるように, 
n が押されると `noLoop()` 関数が呼び出されて `draw()` の実行が停止するように,
y が押されると `loop()` 関数が呼び出されて `draw()` の実行が再開されるように,
s が押されると `saveFrame()` 関数によって画面に描かれた映像がファイルに保存されるように if ブロックを使ってプログラムします.

```processing
// 最終的なコード
int n = 100, m = 4;
float[][] u = new float[n + 2][n + 2];
float[][] v = new float[n + 2][n + 2];
float[][] u1 = new float[n + 2][n + 2];
float[][] v1 = new float[n + 2][n + 2];
float dt = 0.5, h = 0.1, h2 = h * h;
float a = 0.024, b = 0.078;
float cu = 0.002, cv = 0.001;

void setup() {
  size(m * n, m * n);
  noStroke();
  clear();
}

void draw() {
  display();
  boundary();
  update();
}

void display() {
  for (int i = 1; i <= n; i++) {
    for (int j = 1; j <= n; j++) {
      fill(u[i][j] * 255, v[i][j] * 255, 0); // 色を設定する
      rect((i - 1) * m, (j - 1) * m, m, m); // 描画する
    }
  }
}

void update() {
  for (int i = 1; i <= n; i++) {
    for (int j = 1; j <= n; j++) {
      // Du, Dv を準備する
      float Du = (u[i + 1][j] + u[i][j + 1] + u[i - 1][j] + u[i][j - 1] - 4 * u[i][j]) / h2;
      float Dv = (v[i + 1][j] + v[i][j + 1] + v[i - 1][j] + v[i][j - 1] - 4 * v[i][j]) / h2;
      // f, g を計算する
      float f = -u[i][j] * sq(v[i][j]) + a * (1 - u[i][j]);
      float g = u[i][j] * sq(v[i][j]) - b * v[i][j];
      // u1, v1 を計算する
      u1[i][j] = u[i][j] + (cu * Du + f) * dt;
      v1[i][j] = v[i][j] + (cv * Dv + g) * dt;
    }
  }
  for (int i = 1; i <= n; i++) {
    for (int j = 1; j <= n; j++) {
      u[i][j] = u1[i][j];
      v[i][j] = v1[i][j];
    }
  }
}

void boundary() {
  for (int i = 1; i <= n; i++) {
    // u 周期境界条件を設定する
    u[i][0] = u[i][n];
    u[i][n + 1] = u[i][1];
    u[0][i] = u[n][i];
    u[n + 1][i] = u[1][i];
    
    // v 周期境界条件を設定する
    v[i][0] = v[i][n];
    v[i][n + 1] = v[i][1];
    v[0][i] = v[n][i];
    v[n + 1][i] = v[1][i];
  }
}

void clear() {
  for (int i = 1; i <= n; i++) {
    for (int j = 1; j <= n; j++) {
      u[i][j] = 1;
      v[i][j] = 0;
    }
  }
}

void mouseClicked() {
  int x, y;
  x = mouseX / m + 1;
  y = mouseY / m + 1;
  for (int i = 1; i <= n; i++) {
    for (int j = 1; j <= n; j++) {
      float r = sqrt((x - i) * (x - i) + (y - j) * (y - j));
      if (r < 8) {
        u[i][j] = 0.6 + random(-0.06, 0.06);
        v[i][j] = 0.2 + random(-0.02, 0.02);
      }
    }
  }
  redraw();
}

void keyPressed() {
  if (key == 'c') {
    clear();
  } else if (key == 'y') {
    loop();
  } else if (key == 'n') {
    noLoop();
  } else if (key == 's') {
    saveFrame("turing.tif");
  }
}
```
