# 3Dグラフィックス
## 回転する直方体

## 3次元座標系
Processing では, たとえば `size(630, 330, P3D)` のように三つ目のパラメータとしてP3Dを指定すると3次元グラフィックスを表示できるようになります.

## 立方体クラス
```processing
class Cube {
  float x, y; // 位置情報
  flaot a; // x軸まわりの回転角
  float b; // y軸まわりの回転角
  float c; // z軸まわりの回転角
  float w; // 回転のスピード
  
  // パラメータの初期化
  Cube(float xin, float yin, float ain, float bin, float cin, float win) {
    x = xin;
    y = yin;
    a = ain;
    b = bin;
    c = cin;
    w = win;
  }
  
  // 
  void resolve() {
    a += w;
    b += w;
    c += w;
  }
  
  // 直方体を描く
  void drawCube() {
    pushMatrix();
    translate(x, y);
    rotateX(a);
    rotateY(b);
    rotateZ(c);
    box(20, 10, 20);
    popMatrix();
  }
}
```

## 実体の生成
```processing
Cube[][] cubes = new Cube[20][10];
```

`(i + 1) * 30, (j + 1) * 30` で x, y座標が計算できます.
回転角の初期値を `i * j * 0.05` で計算すると位置によって少しずつ角度がことなるようになります.

```processing
void setup() {
  size(630, 330, P3D);
  noStrike();
  smooth();
  for (int i = 0; i < 20; i++) {
    for (int j = 0; j < 10; j++) {
      cubes[i][j] = new Cube(
        (i + 1) * 30,
        (j + 1) * 30,
        i * j * 0.05,
        i * j * 0.05,
        i * j * 0.05, 
        0.05
      );
    }
  }
}
```

`draw()` 関数では背景を塗りつぶした後, 直方体の色を決定し, 
`cubes[i][j].resolve();` で回転させ, `cubes[i][j].drawCube();` で直方体を一つずつ描きます.

```processing
void draw() {
  background(0);
  fill(200);
  for (int i = 0; i < 20; i++) {
    for (int j = 0; j < 10; j++) {
      cubes[i][j].resolve();
      cubes[i][j].drawCube();
    }
  }
}
```

```processing
// 最終的なコード
Cube[][] cubes = new Cube[20][10]; // 20x10個のCubeを確保する

void setup() {
  size(630, 330, P3D); // 3次元のグラフィックウィンドウをP3Dで設定する
  noStroke();
  smooth();
  for (int i = 0; i < 20; i++) {
    for (int j = 0; j < 10; j++) {
      cubes[i][j] = new Cube( // 実体 cubes を作成する
        (i + 1) * 30,
        (j + 1) * 30,
        i * j * 0.05,
        i * j * 0.05,
        i * j * 0.05,
        0.05
      );
    }
  }
}

void draw() { // アニメーションを実現する
  background(0);
  fill(200);
  for (int i = 0; i < 20; i++) {
    for (int j = 0; j < 10; j++) {
      cubes[i][j].revolve();
      cubes[i][j].drawCube();
    }
  }
}

// Cube 型のオブジェクトの設計図
class Cube {
  float x, y, a, b, c;
  float w;
  
  // コンストラクタ
  Cube(float xin, float yin, float ain, float bin, float cin, float win) {
    x = xin;
    y = yin;
    a = ain;
    b = bin;
    c = cin;
    w = win;
  }
  
  void revolve() {
    a += w; // 角度を増加する
    b += w;
    c += w;
  }
  
  void drawCube() {
    pushMatrix();
    translate(x, y);
    rotateX(a);
    rotateY(b);
    rotateZ(c);
    box(20, 10, 20);
    popMatrix();
  }
}
```

## 照明
`draw()` 関数の中に照明と関係する三行を追加します.
`pointLight()` 関数は, はじめの三つのパラメータで光の色を設定し, 後の三つで照明のある位置を設定します.
`ambientLight()` 関数は, 環境光と呼ばれ, 色だけを設定することができます.

```processing
void draw() {
  background(0);
  pointLight( 50, 100, 255, width / 3, height / 2,  100); // <-
  pointLight(255,  40,  60, width / 2, height / 2, -100); // <-
  ambientLight(100, 100, 100); // <-
  fill(200);
  for (int i = 0; i < 20; i++) {
    for (int j = 0; j < 10; j++) {
      cubes[i][j].revolve();
      cubes[i][j].drawCube();
    }
  }
}
```

## カメラ
`draw()` 関数にカメラを追加しましょう.
`camera()` 関数は `eyeX, eyxY, eyeZ` で視点の座標を,
`centerX, centerY, centerZ` で注目している点の座標を設定します.
さらに `upX, upX, upZ` でカメラの傾きを設定します.

```processing
camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
```

```processing
void draw() {
  background(0);
  camera(mouseX, mouseY, 300, width / 2, height / 2, 0, 0, 1, 0); // <-
  pointLight( 50, 100, 255, width / 3, height / 2,  100);
  pointLight(255,  40,  60, width / 2, height / 2, -100);
  ambientLight(100, 100, 100);
  fill(200);
  for (int i = 0; i < 20; i++) {
    for (int j = 0; j < 10; j++) {
      cubes[i][j].revolve();
      cubes[i][j].drawCube();
    }
  }
}
```
