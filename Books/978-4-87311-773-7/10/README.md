# オブジェクト _Objects_
## フィールドとメソッド
オブジェクトあ関連しあう変数と関数の集合体です。
オブジェクト指向プログラミングでは、変数はフィールド（またはインスタンス変数）、関数はメソッドと呼ばれます。

## クラスを定義する
クラスはオブジェクトの仕様書です。
建築をたとえに使うと、クラスは家の設計図、オブジェクトは家そのもののことです。  
各オブジェクトはあるクラスのインスタンスであり、各インスタンスはそれぞれ自分のフィールドとメソッドを持っています。

1. ブロックを作成
2. フィールドの追加
3. コンストラクタの作成とフィールドへの代入
4. メソッドの追加

```java
// 1. ブロックを作成
class JitterBug {
  // 2. フィールドの追加
  float x;
  float y;
  int diameter;
  float speed = 0.5;
  
  // 3. コンストラクタの作成とフィールドへの代入
  JitterBug(float tempX, float tempY, int tempDiameter) {
    x = tempX;
    y = tempY;
    diameter = tempDiamter;
  }
  
  // 4. メソッドの追加
  void move() {
    x += random(-speed, speed);
    y += random(-speed, speed);
  }
  
  void display() {
    ellipse(x, y, diameter, diameter);
  }
}
```

## オブジェクトの生成
1. オブジェクト変数を宣言
2. new を使ってオブジェクトを生成（初期化）

```java
// オブジェクトを作る
JitterBug bug; // オブジェクトを宣言

void setup() {
  size(480, 120);
  // オブジェクトを生成し、パラメータを渡す
  bug = new JitterBug(width / 2, height / 2, 20);
}

void draw() {
  bug.move();
  bug.display();
}

class JitterBug {
  float x;
  float y;
  int diameter;
  float speed = 2.5;
  
  JitterBug(float tempX, float tempY, int tempDiameter) {
    x = tempX;
    y = tempY;
    diameter = tempDiameter;
  }
  
  void move() {
    x += random(-speed, speed);
    y += random(-speed, speed);
  }
  
  void display() {
    ellipse(x, y, diameter, diameter);
  }
}
```

```java
// 複数のオブジェクトを作る
JitterBug jit;
JitterBug bug;

void setup() {
  size(480, 120);
  jit = new JitterBug(width * 0.33, height / 2, 50);
  bug = new JitterBug(width * 0.66, height / 2, 10);
}

void draw() {
  jit.move();
  jit.display();
  bug.move();
  bug.display();
}

class JitterBug {
  float x;
  float y;
  int diameter;
  float speed = 2.5;
  
  JitterBug(float tempX, float tempY, int tempDiameter) {
    x = tempX;
    y = tempY;
    diameter = tempDiameter;
  }
  
  void move() {
    x += random(-speed, speed);
    y += random(-speed, speed);
  }
  
  void display() {
    ellipse(x, y, diameter, diameter);
  }
}
```

## タブ機能
クラスごとに新しいタブを使うと長いコードが編集しやすくなり、管理も容易になります。

> スケッチフォルダに `.pde` ファイルが複数ある場合、それらは個別のタブとして表示されます。

## Robot 8: Objects

```java
Robot bot1;
Robot bot2;

void setup() {
  size(720, 480);
  bot1 = new Robot("robot1.svg", 90, 80);
  bot2 = new Robot("robot2.svg", 440, 30);
}

void draw() {
  background(0, 153, 204);
  
  // Robot 1
  bot1.update();
  bot1.display();
  
  // Robot 2
  bot2.update();
  bot2.display();
}

class Robot {
  float xpos;
  float ypos;
  float angle;
  PShape botShape;
  float yoffset = 0.0;
  
  // コンストラクタ
  Robot(String svgName, float tempX, float tempY) {
    botShape = loadShape(svgName);
    xpos = tempX;
    ypos = tempY;
    angle = random(0, TWO_PI);
  }
  
  // フィールドを更新
  void update() {
    angle += 0.05;
    yoffset = sin(angle) * 20;
  }
  
  void display() {
    shape(botShape, xpos, ypos + yoffset);
  }
}

```
