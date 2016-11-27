# 関数 _Functions_
## 関数の基礎

```java
// サイコロを振る
void setup() {
  println("Ready to roll!");
  rollDice(20);
  rollDice(20);
  rollDice(6);
  println("Finished.");
}

void rollDice(int numSides) {
  int d = 1 + int(random(numSides));
  println("Rolling..." + d);
}
```

- [int()](https://processing.org/reference/intconvert_.html)

```java
// もうひとつの振り方
void setup() {
  println("Ready to roll!");
  int d1 = 1 + int(random(20));
  println("Rolling..." + d1);
  int d2 = 1 + int(random(20));
  println("Rolling..." + d2);
  int d3 = 1 + int(random(6));
  println("Rolling..." + d3);
  println("finished");
}
```

## 関数を作る
```java
// （関数を作らずに）フクロウを描く
void setup() {
  size(480, 120);
}

void draw() {
  background(176, 204, 226);
  translate(110, 110);
  stroke(138, 138, 125);
  strokeWeight(70);
  line(0, -35, 0, -65);
  noStroke();
  fill(255);
  ellipse(-17.5, -65, 35, 35);
  ellipse(17.5, -65, 35, 35);
  arc(0, -65, 70, 60, 0, PI);
  fill(51, 51, 30);
  ellipse(-14, -65, 8, 8);
  ellipse(14, -65, 8, 8);
  quad(0, -58, 4, -51, 0, -44, -4, -51);
}
```

```java
// フクロウ関数
void setup() {
  size(480, 120);
}

void draw() {
  background(176, 204, 226);
  owl(110, 110);
  owl(180, 110);
}

void owl(int x, int y) {
  pushMatrix();
  translate(x, y);
  stroke(138, 138, 125);
  strokeWeight(70);
  line(0, -35, 0, -65);
  noStroke();
  fill(255);
  ellipse(-17.5, -65, 35, 35);
  ellipse( 17.5, -65, 35, 35);
  arc(0, -65, 70, 70, 0, PI);
  fill(51, 51, 30);
  ellipse(-14, -65, 8, 8);
  ellipse( 14, -65, 8, 8);
  quad(0, -58, 4, -51, 0, -44, -4, -51);
  popMatrix();
}
```

```java
// 人口増加
void setup() {
  size(480, 120);
}

void draw() {
  background(176, 204, 226);
  for (int x = 35; x < width + 70; x += 70) {
    owl(x, 110);
  }
}
```

```java
// いろんな大きさのフクロウたち
void setup() {
  size(480, 120);
}

void draw() {
  background(176, 204, 120);
  randomSeed(0);
  for (int i = 35; i < width + 40; i += 40) {
    int gray = int(random(0, 102));
    float scalar = random(0.25, 1.0);
    owl(i, 110, gray, scalar);
  }
}

void owl(int x, int y, int g, float s) {
  pushMatrix();
  translate(x, y);
  scale(s);
  stroke(138 - g, 138 - g, 125 -g);
  strokeWeight(70);
  line(0, -35, 0, -65);
  noStroke();
  fill(255);
  ellipse(-17.5, -65, 35, 35);
  ellipse( 17.5, -65, 35, 35);
  arc(0, -65, 70, 70, 0, PI);
  fill(51, 51, 30);
  ellipse(-14, -65, 8, 8);
  ellipse( 14, -65, 8, 8);
  quad(0, -58, 4, -51, 0, -44, -4, -51);
  popMatrix();
}
```

## 値を返す

```java
// 値を返す
void setup() {
  float yourWeight = 132;
  float marsWeight = calculateMars(yourWeight);
  println(marsWeight);
}

float calculateMars(flaot w) {
  float newWeight = w * 0.38;
  return newWeight;
}
```

## Eobot 7: Functions
```java
void setup() {
  size(720, 480);
  strokeWeight(2);
  ellipseMode(RADIUS);
}

void draw() {
  background(0, 153, 204);
  drawRobot(120, 420, 110, 140);
  drawRobot(270, 460, 260, 95);
  drawRobot(420, 310, 80, 10);
  drawRobot(570, 390, 180, 40);
}

void drawRobot(int x, int y, int bodyHeight, int neckHeight) {
  int radius = 45;
  int ny = y - bodyHeight - neckHeight - radius;
  
  // Neck
  stroke(255);
  line(x +  2, y - bodyHeight, x +  2, ny);
  line(x + 12, y - bodyHeight, x + 12, ny);
  line(x + 22, y - bodyHeight, x + 22, ny);
  
  // Antena
  line(x + 12, ny, x - 18, ny - 43);
  line(x + 12, ny, x + 42, ny - 99);
  line(x + 12, ny, x + 78, ny + 15);
  
  // Body
  noStroke();
  fill(255, 204, 0);
  ellipse(x, y - 33, 33, 33);
  fill(0);
  rect(x - 45, y - bodyHeight, 90, bodyHeight - 33);
  fill(255, 204, 0);
  rect(x - 45, y - bodyHeight + 17, 90, 6);
  
  // Head
  fill(0);
  ellipse(x + 12, ny, radius, radius);
  fill(255);
  ellipse(x + 24, ny - 6, 14, 14);
  fill(0);
  ellipse(x + 24, ny - 6, 3, 3);
  fill(153, 204, 255);
  ellipse(x, ny - 8, 5, 5);
  ellipse(x + 30, ny - 26, 4, 4);
  ellipse(x + 41, ny + 6, 3, 3);
}
```
