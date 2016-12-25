# フラクタル
<sup>Fractals</sup>

> 「フラクタル(fractal)」は、ラテン語の fractus(「砕けた」の意味)からきていて、__たくさんのレベルで反復する形やパターンのことです__。

## 無限の再帰

```processing
// 無限ループの一例
int x = 1;
while(x > 0) {
  x++;
}
```

無限ループをコードするのは簡単ですが、それこそ無限につまらない行為です。

## 自己相似性のコーディング
どのようにしたら自己相似性を作り出せるでしょうか。そのためには、こと親の両方として振る舞い、自分のコピーをたくさん作るオブジェクトを定義します。

### 幹と枝
コードの最初の行で、いくつかの制限を設定します。制限なしではあっという間に無限の再帰の罠の中に落ち込んでしまいます。

```processing
int _numChildren = 3;
int _maxLevels = 3;
```

プロセスの数はベキ乗で増えていくのです。レベルを3、子を3つ増やすことは、3の3乗、すなわちオブジェクトが27増えることを意味します。
もう1つ子を付け加えると3の4乗になり、それは81のオブジェクトに相当します。5つのレベルで5つの子では、3,125のエレメントを操作しなければなりません。
これが慎重にやらなければならない理由です。

```processing
// 8.1 フラクタル構造をコーディングする
int _numChildren = 3;
int _maxLevels = 3;

Branch _trunk;

void setup() {
  size(750, 500);
  background(255);
  noFill();
  smooth();
  newTree();
}

void newTree() {
  _trunk = new Branch(1, 0, width / 2, 50);
  _trunk.drawMe();
}

class Branch {
  float level;
  float index;
  float x;
  float y;
  float endx;
  float endy;
  
  Branch(float lev, float ind, float ex, float why) {
    level = lev;
    index = ind;
    updateMe(ex, why);
  }
  
  void updateMe(float ex, float why) {
    x = ex;
    y = why;
    endx = x + 150;
    endy = y + 15;
  }
  
  void drawMe() {
    line(x, y, endx, endy);
    ellipse(x, y, 5, 5);
  }
}
```

- `Branch` オブジェクト（幹）のインスタンスを定義して作成する
- そのオブジェクトの `drawMe` を呼び出す

次に自己参照しましょう。`Branch` の属性に `chidren` を加えて、`Branch` の作成関数を、自分自身の新しいバージョンを生成するようにアップデートします。
```processing
class Branch {
  // ...
  // ...
  Branch [] children = new Branch[0]
  
  Branch(float lev, float ind, float ex, float why) {
    level = lev;
    index = ind;
    updateMe(ex, why);
    
    if (level < _maxLevels) {
      children = new Branch[_numChildren];
      for (int x = 0; x < _numChildren; x++) {
        children[x] = new Branch(level + 1, x, endx, endy);
      }
    }
  }
}
```

すべての枝を描くために、`drawMe` 関数を修正します。
```processing
void drawMe() {
  line(x, y, endx, endy);
  ellipse(x, y, 5, 5);
  for (int i = 0; i < children.length; i++) {
    children[i].drawMe();
  }
}
```

それぞれの枝を区別できるようにするために、外観を少し変えてみましょう。
`Branch` が自分の level と index を知るようことができると便利です。
`updateMe` を、レベルに応じた重みをかけた乱数で終点を計算するように変えてください。

```processing
void updateMe(float ex, float why) {
  x = ex;
  y = why;
  endx = x + (level * (random(100) - 50));
  endy = y + 50 + (level * random(50));
}
```

さらに、`drawMe` 関数に `strokeWeight` の変化を加えてください。

```processing
void drawMe() {
  strokeWeight(_maxLevels - level + 1); // <-
  // ...
  // ...
}
```

### あなたの木を動かす

`draw` ループで動かしてみましょう。

```processing
void draw() {
  background(255);
  _trunk.updateMe(width / 2, height / 2);
  _trunk.drawMe();
}
```

次に描画スタイル、線の太さ、回転を操作するために、いくつかの新しい属性を `Branch` クラスに加えます。
これらの属性を初期化しなければなりません。

```processing
class Branch {
  // ...
  // ...
  float strokeW;
  float alph;
  float len;
  float lenChange;
  float rot;
  float rotChange;

  Branch() {
    // ...
    // ...
    strokeW = (1 / level) * 100;
    alph = 255 / level;
    len = (1 / level) * random(200);
    rot = random(360);
    lenChange = random(10) - 5;
    rotChange = random(10) - 5;
    
    updateMe() {
      // ...
    }
  }
}
```

この新しい属性を用いて、`updateMe` 関数が毎フレームごとに呼ばれるたびに、実際に何かをさせることができます。

```processing
void updateMe(float ex, float why) {
  x = ex;
  y = why;
  
  rot += rotChange; // <- 回転を増やす
  if (rot > 360) {
    rot = 0;
  } else 
  if (rot < 0) {
    rot = 360;
  }
  
  len -= lenChange; // <- 長さを増やす
  if (len < 0) {
    lenChange *= -1;
  } else
  if (len > 200) {
    lenChange *= -1;
  }
  
  float radian = radians(rot);
  endx = x + (len * cos(radian));
  endy = y + (len * sin(radian));
  
  for (int i = 0; i < children.length; i++) {
    children[i].updateMe(endx, endy);
  }
}
```

あなたが定義、初期化した `strokeW` と `alph` 属性を使うように、オブジェクトの `drawMe` 関数をアップデートします。

```processing
void drawMe() {
  strokeWeight(strokeW);
  stroke(0, alph);
  fill(255, alph);
  line(x, y, endx, endy);
  ellipse(endx, endy, len / 12, len / 12);
  for (int i = 0; i < children.length; i++) {
    children[i].drawMe();
  }
}
```

## 指数的成長

```processing
// 線を細く
strokeW = (1 / level) * 10;
```

```processing
// 幹を描くのをやめます
if (level > 1) {

}
```

```processing
// 8.3 歯車フラクタルのためのコードの最終版
int _numChildren = 7;
int _maxLevels = 7;

Branch _trunk;

void setup() {
  size(750, 500);
  background(255);
  noFill();
  smooth();
  newTree();
}

void newTree() {
  _trunk = new Branch(1, 0, width / 2, height / 2);
  _trunk.drawMe();
}

void draw() {
  background(255);
  _trunk.updateMe(width / 2, height / 2);
  _trunk.drawMe();
}

class Branch {
  float level;
  float index;
  float x;
  float y;
  float endx;
  float endy;
  
  float strokeW;
  float alph;
  float len;
  float lenChange;
  float rot;
  float rotChange;
  
  Branch[] children = new Branch[0];
  
  Branch(float lev, float ind, float ex, float why) {
    level = lev;
    index = ind;
    
    strokeW = (1 / level) * 10;
    alph = 255 / level;
    len = (1 / level) * random(500);
    rot = random(360);
    lenChange = random(10) - 5;
    rotChange = random(10) - 5;
    
    updateMe(ex, why);
    
    if (level < _maxLevels) {
      children = new Branch[_numChildren];
      for (int x = 0; x < _numChildren; x++) {
        children[x] = new Branch(level + 1, x, endx, endy);
      }
    }
  }
  
  void updateMe(float ex, float why) {
    x = ex;
    y = why;
    
    rot += rotChange;
    if (rot > 360) {
      rot = 0;
    } else 
    if (rot < 0) {
      rot = 360;
    }
    
    len -= lenChange;
    if (len < 0) {
      lenChange *= -1;
    } else
    if (len > 500) {
      lenChange *= -1;
    }
    
    float radian = radians(rot);
    endx = x + (len * cos(radian));
    endy = y + (len * sin(radian));
    
    for (int i = 0; i < children.length; i++) {
      children[i].updateMe(endx, endy);
    }
  }
  
  void drawMe() {
    if (level > 1) { // 幹を描かない
      strokeWeight(strokeW);
      stroke(0, alph);
      fill(255, alph);
      line(x, y, endx, endy);
      ellipse(endx, endy, len / 12, len / 12);      
    }
    for (int i = 0; i < children.length; i++) {
      children[i].drawMe();
    }
  }
}
```

## ケーススタディ: サトクリフ五角形
> サトクリフ五角形は、まず五角形を描いて、その5つの辺のそれぞれの中点から垂線を引き、この垂線上の点を結べば別の五角形を作れると言っています。

### 組み立て

```processing
// 8.4 回転を使って五角形を描く

```
