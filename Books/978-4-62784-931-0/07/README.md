# シミュレーションで描くボールの動き
## 動くボール

1. 水平方向にだけ移動し, 壁に衝突したら向きを変える.
2. あらゆる方向に移動でき, 壁に衝突したら光のようにはね返る.
3. 前途の二つに加えて, ボールどうしの衝突も考える.

## ただ一つのボール
```processing
float radi, posx, posy, speed;
color clr;

void setup() {
  size(480, 120);
  smooth();
  noStroke();
  frameRate(30);
  radi = 20;
  posx = 240;
  posy = 60;
  speed = 4;
  clr = 255;
}
```

### 水平移動

```processing
posx = posx + speed;

// same code
posx += speed;
```

### はね返り

```processing
if (posx + radi > with) {
  speed = -speed;
  posx = width - radi;
}

if (posx - radi < 0) {
  speed = -speed;
  posx = radi;
}
```

```processing
fill(clr);
ellipse(posx, posy, redi * 2, radi * 2);
```

```processing
// full code
float radi, posx, posy, speed;
color clr;

void setup() {
  size(480, 120);
  smooth();
  noStroke();
  frameRate(30);
  radi = 20;
  posx = 240;
  posy = 60;
  speed = 4;
  clr = 255;
}

void draw() {
  background(128);
  posx += speed;
  if (posx + radi > width) {
    speed = -speed;
    posx = width - radi;
  }
  if (posx - radi < 0) {
    speed = -speed;
    posx = radi;
  }
  fill(clr);
  ellipse(posx, posy, radi * 2, radi * 2);
}
```

## オブジェクト

```processing
Ball b1, b2; // Ball 型オブジェクト b1, b2 を用意する

void setup() {
  size(480, 120);
  smooth();
  noStroke();
  frameRate(30);
  b1 = new Ball(20, 240, 20, 255, 4);
  b2 = new Ball(40,  40, 80, 0,   2);
}

void draw() {
  background(128);
  b1.update();
  b2.update();
}

class Ball {
  float radi, posx, posy, speed;
  color clr;
  
  Ball(float r, float x, float y, color c, float s) {
    radi = r;
    posx = x;
    posy = y;
    clr = c;
    speed = s;
  }
  
  void update() {
    posx += speed;
    if (posx + radi > width) {
      speed = -speed;
      posx = width - radi;
    }
    if (posx - radi < 0) {
      speed = -speed;
      posx = radi;
    }
    fill(clr);
    ellipse(posx, posy, radi * 2, radi * 2);
  }
}
```

### クラス
```processing
class Ball {

}
```

### コンストラクタ
オブジェクトを生成するときの初期値を設定することを目的としています。
```processing
class Ball {
  Ball( ) {
  
  }
}
```

### メソッド
### 生成

## 300個のボール
```processing
Ball[] balls = new Ball[300];

void setup() {
  size(480, 120);
  smooth();
  noStroke();
  frameRate(30);
  for (int i = 0; i < 300; i++) {
    balls[i] = new Ball(
      random(5, 10), 
      random(0, width), 
      random(0, height), 
      color(random(0, 255)),
      random(-5, 5)
    );
  }
}

void draw() {
  background(204);
  for (int i = 0; i < 300; i++) {
    balls[i].update();
  }
}

class Ball {
  float radi, posx, posy, speed;
  color clr;
  
  Ball(float r, float x, float y, int c, float s) {
    radi = r;
    posx = x;
    posy = y;
    clr = c;
    speed = s;
  }
  
  void update() {
    posx += speed;
    if (posx + radi > width) {
      speed = -speed;
      posx = width - radi;
    }
    if (posx - radi < 0) {
      speed = -speed;
      posx = radi;
    }
    fill(clr);
    ellipse(posx, posy, radi * 2, radi * 2);
  }
}
```

## 自由に動くボール
```processing
int nn = 200;
Ball[] balls = new Ball[nn];

void setup() {
  size(480, 120);
  smooth();
  noStroke();
  frameRate(30);
  for (int i = 0; i < nn; i++) {
    balls[i] = new Ball(
      random(4, 15),
      random(0, width),
      random(0, height),
      color(random(0, 255)),
      random(-3, 3),
      random(-3, 3)
    );
  }
}

void draw() {
  background(204);
  for (int i = 0; i < nn; i++) {
    balls[i].update();
  }
}

class Ball {
  float radi, posx, posy, speedx, speedy;
  color clr;
  
  Ball(float r, float x, float y, color c, float sx, float sy) {
    radi = r;
    posx = x;
    posy = y;
    clr = c;
    speedx = sx;
    speedy = sy;
  }
  
  void update() {
    posx += speedx;
    posy += speedy;
    
    if (posy + radi > height) {
      speedy = -speedy;
      posy = height - radi;
    }
    
    if (posy - radi < 0) {
      speedy = -speedy;
      posy = radi;
    }
    
    if (posx + radi > width) {
      speedx = -speedx;
      posx = width - radi;
    }
    
    if (posx - radi < 0) {
      speedx = -speedx;
      posx = radi;
    }

    fill(clr);
    ellipse(posx, posy, radi * 2, radi * 2);
  }
}
```

## 衝突するボール

```processing
int numBalls;             // ボールの数を数える
Ball[] balls = new Ball[1000];
float spring = 100;       // 反発係数
float reduction = 0.99;   // 減衰係数
float gravity = 0.1;      // 重力加速度

void setup() {
  size(480, 360);
  smooth();
  frameRate(30);
}

void draw() {
  background(0);
  for (int i = 0; i < numBalls; i++) {
    balls[i].display();   // 表示
    balls[i].move();      // 移動
    balls[i].bound();     // 反発
    balls[i].collide();   // 衝突
  }
}

class Ball {
  float posx, posy;
  float radi;
  float speedx, speedy;
  color clr;
  int idno;
  float mass;
  Ball[] others;
  
  Ball(float x, float y, float r, float sx, float sy,
    int id, color c, Ball[] o) {
    posx = x;
    posy = y;
    radi = r;
    speedx = sx;
    speedy = sy;
    clr = c;
    idno = id;
    mass = radi * radi;
    others = o;
  }
  
  void move() {
    speedx *= reduction;  // 空気抵抗などの影響
    speedy *= reduction;  // 空気抵抗などの影響
    posx += speedx;
    posy += speedy;
    speedy += gravity;    // 重力加速度
  }
  
  void bound() { // 壁に衝突したときの処理
    if (posx + radi >= width) {
      speedx = -speedx;
      posx = width - radi;
    }
    
    if (posx - radi <= 0) {
      speedx = -speedx;
      posx = radi;
    }
    
    if (posy + radi >= height) {
      speedy = -speedy;
      posy = height - radi;
    }
    
    if (posy - radi <= 0) {
      speedy = -speedy;
      posy = radi;
    }
  }
  
  void collide() { // ボール相互の衝突による速度の変化
    for (int i = idno + 1; i < numBalls; i++) {
      float dx = others[i].posx - posx;
      float dy = others[i].posy - posy;
      float distance = sqrt(dx * dx + dy * dy);
      float critical = others[i].radi + radi;
      if (distance < critical) {
        float force = spring * (critical - distance); // はね返りの強さ (f = kx)
        float theta = atan2(dy, dx);
        float ax = -force * cos(theta) / mass; // (質量 × 加速度 = 力) -f * cosθ / m
        float ay = -force * sin(theta) / mass; //                     -f * sinθ / m
        speedx += ax;
        speedy += ay;
        ax = force * cos(theta) / others[i].mass;
        ay = force * sin(theta) / others[i].mass;
        others[i].speedx += ax;
        others[i].speedy += ay;
      }
    }
  }

  void display() {
    fill(clr);
    ellipse(posx, posy, radi * 2, radi * 2);
  }
}

void mousePressed() {
  float x = mouseX;
  float y = mouseY;
  float d = random(10, 20);
  float sx = random(-10, 10);
  float sy = random(-10, 10);
  color c = color(random(128, 255), random(64, 128));
  balls[numBalls] = new Ball(x, y, d, sx, sy, numBalls, c, balls);
  numBalls = numBalls + 1;
}
```
