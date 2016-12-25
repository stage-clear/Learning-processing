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
FractalRoot pentagon;
int _maxlevels = 5;

void setup() {
  size(1000, 1000);
  smooth();
  pentagon = new FractalRoot(); // ルートの五角形を作る
  pentagon.drawShape(); // そこに drawShape メソッドを呼ぶ
}

class PointObj { // x, y の位置を格納するオブジェクト・クラス
  float x;
  float y;
  PointObj(float ex, float why) {
    x = ex;
    y = why;
  }
}

class FractalRoot {
  PointObj[] pointArr = new PointObj[5];
  Branch rootBranch;
  
  FractalRoot() {
    float centX = width / 2;
    float centY = height / 2;
    int count = 0;
    for (int i = 0; i < 360; i += 72) {
      float x = centX + (400 * cos(radians(i)));
      float y = centY + (400 * sin(radians(i)));
      pointArr[count] = new PointObj(x, y);
      count++;
    }
    rootBranch = new Branch(0, 0, pointArr);
  }
  
  void drawShape() {
    rootBranch.drawMe();
  }
}

class Branch {
  int level;
  int num;
  PointObj[] outerPoints = {};
  
  Branch(int lev, int n, PointObj[] points) {
    level = lev;
    num = n;
    outerPoints = points;
  }
  
  void drawMe() {
    strokeWeight(5 - level);
    // draw outer shape
    for (int i = 0; i < outerPoints.length; i++) {
      int nexti = i + 1;
      if (nexti == outerPoints.length) {
        nexti = 0;
      }
      line(
        outerPoints[i].x, outerPoints[i].y, 
        outerPoints[nexti].x, outerPoints[nexti].y
      );
    }
  }
}
```

```processing
// 8.5 頂点（辺）の中点を計算する関数
class Branch {
  // ...
  // ...

  PointObj[] calcMidPoints() {
    PointObj[] mpArray = new PointObj[outerPoints.length];
    for (int i = 0; i < outerPoints.length; i++) {
      int nexti = i + 1;
      if (nexti == outerPoints.length) {
        nexti = 0;
      }
      PointObj thisMP = calcMidPoint(outerPoints[i], outerPoints[nexti]);
      mpArray[i] = thisMP;
    }
    return mpArray;
  }

  PointObj calcMidPoint(PointObj end1, PointObj end2) {
    float mx;
    float my;
    if (end1.x > end2.x) {
      mx = end2.x + ((end1.x - end2.x) / 2);
    } else {
      mx = end1.x + ((end2.x - end1.x) / 2);
    }

    if (end1.y > end2.y) {
      my = end2.y + ((end1.y - end2.y) / 2);
    } else {
      my = end1.y + ((end2.y - end1.y) / 2);
    }
    return new PointObj(mx, my);
  }
}
```

最初の `calcMidPoint` 関数は、外周の点の中点を求めて、2番目の `calcMidPoint` 関数にその値を渡します。
`calcMidPoint` 関数は、あらゆる位置の組み合わせに対して中点を求めます。
そして最後に `calcMidPoints` 関数が、それぞれの結果を配列に集めて返します。

`Branch` コンストラクタの中から新しい関数を呼び出して、そして `midPoints` という名前の配列にその結果を入れます。

```processing
class Branch {
  // ...
  // ...
  PointObj [] midPoints = {}; // <-
  
  Branch(int lev, int n, PointObj[] points) {
    // ...
    // ...
    midPoints = calcMidPoints(); // <-
  }
}
```

次に、`drawMe` 関数の中のそれらの点を図上にプロットします。

```processing
class Branch {
  // ...
  // ...
  void drawMe() {
    // ...
    // ...
 
    strokeWeight(0.5);
    fill(255, 150);
    for (int j = 0; j < midPoints.length; j++) {
      ellipse(midPoints[j].x, midPoints[j].y, 15, 15);
    }
  }
}
```

次に必要になる点の集合は、中点から延ばす支柱の終端です。辺の頂点の角度を扱う必要はありません。
その代わりに、辺と向かい合った頂点を使うことができます。

最初に、支柱を押し出す長さを全体の長さの比から決めるために、グローバルな `_strutFactor` 変数を定義します。

```processing
float _strutFactor = 0.2;
```

`Branch` オブジェクトに、点を追加して描く関数を加えます。

```processing
// 8.6 辺の中点を向かい合った頂点に向かって延ばす関数
class Branch {

  PointObj[] calcStrutPoints() {
    PointObj[] strutArray = new PointObj[midPoints.length];
    for (int i = 0; i < midPoints.length; i++) {
      int nexti = i + 3;
      if (nexti >= midPoints.length) {
        nexti -= midPoints.length;
      }
      PointObj thisSP = calcProjPoint(midPoints[i], outerPoints[nexti]);
      strutArray[i] = thisSP;
    }
    return strutArray;
  }
  
  PointObj calcProjPoint(PointObj mp, PointObj op) {
    float px;
    float py;

    // 三角形の計算
    float adj; 
    float opp;
    if (op.x > mp.x) {
      opp = op.x - mp.x;
    } else {
      opp = mp.x - op.x;
    }
    if (op.y > mp.y) {
      adj = op.y - mp.y;
    } else {
      adj = mp.y - op.y;
    }
    
    // 斜辺に沿って伸ばす
    if (op.x > mp.x) {
      px = mp.x + (opp * _strutFactor);
    } else {
      px = mp.x - (opp * _strutFactor);
    }
    if (op.y > mp.y) {
      py = mp.y + (adj * _strutFactor);
    } else {
      py = mp.y - (adj * _strutFactor);
    }

    return new PointObj(px, py);
  }
}
```

さらに、`Branch` コンストラクタにこのコードを加えます。

```processing
class Branch {
  // ...
  // ...
  PointObj[] projPoints = {}; // <-
  
  Branch() {
    // ...
    // ...
    
    projPoints = calcStrutPoints(); // <-
  }
}
```

### 探求
`drowMe` 関数で、これらの点を図の中に描いて、正しいかどうかをみてみましょう。

```processing
class Branch {
  //...
  //...
  
  void drawMe() {
    //...
    //...

    strokeWeight(0.5);
    fill(255, 150);
    for (int j = 0; j < midPoints.length; j++) {
      ellipse(midPoints[j].x, midPoints[j].y, 15, 15);
      line( // <-
        midPoints[j].x, midPoints[j].y,
        projPoints[j].x, projPoints[j].y
      );
      ellipse(projPoints[j].x, projPoints[j].y, 15, 15); // <-
    }
  }
}
```

これで、再帰構造のために必要なすべての点を描くことができるようになりました。
5本の支柱の端点を内側の五角形の頂点とすることで、これを試してみることができます。
`Branch` オブジェクトのコンストラクタに以下のコードを加えてください。

```processing
class Branch {
  Branch[] myBranches = {};

  Branch(int lev, int n, Point[] points) {
    //...
    if ((level + 1) < _maxLevels) {
      Branch childBranch = new Branch(level + 1, 0, projPoints);
      myBranches = (Branch[])append(myBranches, childBranch);
    }
  }
}
```

さらに、子の五角形が画面に表示されるように、`drawMe` 関数に同様のコードを加えてください。

```processing
class Branch {
  //...

  void drawMe() {
    //...
    for (int k = 0; k < myBranches.length; k++) {
      myBranches[k].drawMe();
    }
  }
}
```

完全なサトクリフ五角形フラクタルを作成するためには、他の5つの五角形の内側にも、同様に五角形を描かなければなりません。
そのためには、さらに5つの新しい `Branch` オブジェクトに点を渡せばいいだけです。

```processing
class Branch {
  //...

  Branch(int lev, int n, PointObj[] points) {
    //...

    if ((level + 1) < _maxlevels) {
      //...
      
      for (int k = 0; k < outerPoints.length; k++) {
        int nextk = k - 1;
        if (nextk < 0) {
          nextk += outerPoints.length;
        }
        PointObj[] newPoints = {
          projPoints[k], 
          midPoints[k], 
          outerPoints[k],
          midPoints[nextk],
          projPoints[nextk]
        };
        childBranch = new Branch(level + 1, k + 1, newPoints);
        myBranches = (Branch[])append(myBranches, childBranch);
      }
    }
  }
}
```
