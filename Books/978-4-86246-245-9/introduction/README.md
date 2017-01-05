# はじめに
## ランダムウォーク

## ランダムウォーカークラス
- [Objects \ Processing.org](https://processing.org/tutorials/objects/) - オブジェクト指向プログラミングについて

__クラス__ は, オブジェクトの実際のインスタンスを構築するために使う定型です.
クラスはクッキーの抜き型, オブジェクトは抜き出されたクッキーのようなものだと考えることができます.

```processing
class Walker {
  int x;
  int y;
}
```

すべてのクラスにはコンストラクタが必要です.
```processing
class Walker {
  //..
  Walker() {
    x = width / 2;
    y = height / 2;
  }
}
```

クラスにはデータとともに機能も定義できます.

```processing
class Walker {
  //..
  //..
  void display() {
    stroke(0);
    point(x, y);
  }
  
  void step() {
    int choise = int(random(4)); // 0, 1, 2, 3 のいずれか
    
    if (choise == 0) { // ランダムな選択によってステップの方向を決定
      x++;
    } else if (choise == 1) {
      x--;
    } else if (choise == 2) {
      y++;
    } else {
      y--;
    }
  }
}
```

これでクラスが完成しました.

```processing
Walker w; // Walker オブジェクト
```

```processing
void setup() {
  size(640, 360);
  w = new Walker();
  background(255);
}

void draw() {
  w.step(); // Walker の関数を呼び出す
  w.display();
}
```

```processing
// RandomWalk
Walker w;

void setup() {
  size(400, 400);
  frameRate(30);
  
  w = new Walker();
}

void draw() {
  background(255);
  w.render();
  w.walk();
}

// Walker class
class Walker {
  float x, y;
  
  Walker() {
    x = width / 2;
    y = height / 2;
  }
  
  void render() {
    stroke(0);
    fill(175);
    rectMode(CENTER);
    rect(x, y, 40, 40);
  }
  
  void walk() {
    float vx = random(-2, 2);
    float vy = random(-2, 2);
    
    x += vx;
    y += vy;
    
    x = constrain(x, 0, width - 1);
    y = constrain(y, 0, height - 1);
  }
}
```

```processing
// RandomWalkLevy

Walker w;

void setup() {
  size(640, 480);
  w = new Walker();
  background(0);
}

void draw() {
  w.step();
  w.render();
}

// Walker class
class Walker {
  float x, y;
  float prevX, prevY;
  
  Walker() {
    x = width / 2;
    y = height / 2;
  }
  
  void render() {
    stroke(255);
    line(prevX, prevY, x, y);
  }
  
  void step() {
    prevX = x;
    prevY = y;
    
    float stepx = random(-1, 1);
    float stepy = random(-1, 1);
    
    float stepsize = montecarlo() * 50;
    stepx *= stepsize;
    stepy *= stepsize;
    
    x += stepx;
    y += stepy;
    x = constrain(x, 0, width - 1);
    y = constrain(y, 0, height - 1);
  }
}

float montecarlo() {
  while(true) {
    float r1 = random(1);
    float probability = pow(1.0 - r1, 8);

    float r2 = random(1);
    if (r2 < probability) {
      return r1;
    }
  }
}
```
- [モンテカルロ法](https://www.wikiwand.com/ja/%E3%83%A2%E3%83%B3%E3%83%86%E3%82%AB%E3%83%AB%E3%83%AD%E6%B3%95)


```processing
// RandomWalkerNoise
Walker w;

void setup() {
  size(640, 360);
  w = new Walker();
  background(0);
}

void draw() {
  w.step();
  w.render();
}

// Walker class
class Walker {
  float x, y;
  float tx, ty;
  
  float prevX, prevY;
  
  Walker() {
    tx = 0;
    ty = 10000;
    x = map(noise(tx), 0, 1, 0, width);
    y = map(noise(ty), 0, 1, 0, height);
  }
  
  void render() {
    stroke(255);
    line(prevX, prevY, x, y);
  }
  
  void step() {
    prevX = x;
    prevY = y; 
    
    x = map(noise(tx), 0, 1, 0, width);
    y = map(noise(ty), 0, 1, 0, height);
    
    tx += 0.01;
    ty += 0.01;
  }
}
```[
