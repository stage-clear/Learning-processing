# 自律性
<sup>_Autonomy_</sup>

> プログラミング用語における「オブジェクト」と「エージェント」の違いは、エージェントが環境を観察し相互作用することにあります。
> エージェントには、目的、意志、偏見といったような、複雑な行動をとる可能性があります。
> それらは不正確さ、自己利益、非合理性などのとても面白い行動を生み出せます。

## セル・オートマトン
### 枠組みをセットアップ

```processing
// CAフレームワーク
Cell[][] _cellArray;
int _cellSize = 10;
int _numX;
int _numY;

void setup() {
  size(500, 300);
  _numX = floor(width / _cellSize);
  _numY = floor(height / _cellSize);
  restart();
}

void restart() {
  _cellArray = new Cell[_numX][_numY];
  for (int x = 0; x < _numX; x++) {
    for (int y = 0; y < _numY; y++) {
      Cell newCell = new Cell(x, y);
      _cellArray[x][y] = newCell;
    }
  }
  
  for (int x = 0; x < _numX; x++) {
    for (int y = 0; y < _numY; y++) {
      int above = y - 1;
      int below = y + 1;
      int left = x - 1;
      int right = x + 1;
      
      if (above < 0) { above = _numY - 1; }
      if (below == _numY) { below = 0; }
      if (left < 0) { left = _numX - 1; }
      if (right == _numX) { right = 0; }
      
      _cellArray[x][y].addNeighbour(_cellArray[left][above]); // 参照したものを周囲に渡す
      _cellArray[x][y].addNeighbour(_cellArray[left][y]);
      _cellArray[x][y].addNeighbour(_cellArray[left][below]);
      _cellArray[x][y].addNeighbour(_cellArray[x][below]);
      _cellArray[x][y].addNeighbour(_cellArray[right][below]);
      _cellArray[x][y].addNeighbour(_cellArray[right][y]);
      _cellArray[x][y].addNeighbour(_cellArray[right][above]);
      _cellArray[x][y].addNeighbour(_cellArray[x][above]);
    }
  }
}

void draw() {
  background(200);
  
  for (int x = 0; x < _numX; x++) {
    for (int y = 0; y < _numY; y++) {
      _cellArray[x][y].calcNextState();
    }
  }
  
  translate(_cellSize / 2, _cellSize / 2);
  
  for (int x = 0; x < _numX; x++) {
    for (int y = 0; y < _numY; y++) {
      _cellArray[x][y].drawMe();
    }
  }
}

void mousePressed() {
  restart();
}


/**
 * Object
 */
class Cell {
  float x;
  float y;
  boolean state;
  boolean nextState;
  Cell[] neighbours;
  
  Cell(float ex, float why) {
    x = ex * _cellSize;
    y = why * _cellSize;
    if (random(2) > 1) { // <- 初期状態をランダムに
      nextState = true;
    } else {
      nextState = false;
    }
    state = nextState;
    neighbours = new Cell[0];
  }
  
  void addNeighbour(Cell cell) {
    neighbours = (Cell[])append(neighbours, cell);
  }
  
  void calcNextState() {
    // to come
  }
  
  void drawMe() {
    state = nextState;
    stroke(0);
    if (state == true) {
      fill(0);
    } else {
      fill(255);
    }
    ellipse(x, y, _cellSize, _cellSize);
  }
}
```

> __多次元配列__  
> 1次元の配列  
> `int[] numberArray = { 1, 2, 3 };`  
> 2D配列  
> `int[][] twoDimArray = { { 1, 2, 3 }, { 4, 5, 6 }, { 7, 8, 9 } };`  
> さらに多くの次元を持たせることもできます
> `int[][][] threeDimArray;`  
> `int[][][][] fourDimArray;`  

### ゲーム・オブ・ライフ

GOL の規則は次の通りです。

1. 生きている（黒い）セルは、2つか3つの隣接するセルが生きていればそのまま生き続ける。さもなければ、過疎か過密のどちらかで死んでしまう
2. 死んだセルの周囲に、ちょうど3つの生きた隣接するセルがあれば奇跡が起こり、それは生き返る

- [Game of Life | Wikipedia](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)

```processing
// 7.2 GOLルールを使って次のステップの状態を計算する
class Cell {
  //...
  //...

  void calcNextState() {
    int liveCount = 0;
    for (int i = 0; i < neighbours.length; i++) {
      if (neighbours[i].state == true) {
        liveCount++;
      }
    }

    if (state == true) {
      if ((liveCount == 2) || (liveCount == 3)) {
        nextState = true;
      } else {
        nextState = false;
      }
    } else {
      if (liveCount == 3) {
        nextState = true;
      } else {
        nextState = false;
      }
    }
  }
}
```

### ヴィシュニアク・ヴォート <sub><em>Vichniac Vote</em></sub>
> ヴィシュニアク・ヴォートは、服従に対する教訓です。  
> それぞれのセルは集団から圧力を受けやすく、隣接セルの傾向に流されます。
> セルの色が多数派であればそれは変化しません。少数派なら変化します。

```processing
// 7.3 ヴシュニアク・ヴォート・ルール
class Cell {
  // ...
  // ...
  
  void calcNextState() {
    int liveCount = 0;
    if (state) { liveCount++; } // <- 自分を含めて隣接セルを数える
    for (int i = 0; i < neighbours.length; i++) {
      if (neighbours[i].state == true) {
        liveCount++;
      }
    }
    
    if (liveCount <= 4) { // 自分は多数派か?
      nextState = false;
    } else if (liveCount > 4) {
      nextState = true;
    }
    
    if ((liveCount == 4) || (liveCount == 5)) {
      nextState = !nextState;
    }
  }
}
```

### ブライアンの脳 <sub><em>Brian's Brain</em></sub>

ブライアンの脳は3状態のセル・オートマンです。セルにオン/オフだけでなく、もう1つの第三の条件があります。
ブライアンの脳のCAの状態は「発火」「休息」「オフ」の３種類です。セルは、脳のニューロンのように発火し、再び発火する前に休息します。

- もし状態が発火なら、次の状態は休息
- もし状態が休息なら、次の状態はオフ
- もし状態がオフで、2個の隣接セルが今まさに発火していれば、そのセルは発火する

```processing
// 7.4 ブライアンの脳のために変更されたセルオブジェクト
class Cell {
  float x;
  float y;
  int state; // <-
  int nextState; // <-
  Cell[] neighbours;

  Cell(float ex, float why) {
    x = ex * _cellSize;
    y = why * _cellSize;
    
    nextState = int(random(2)); // <-
    state = nextState;
    neighbours = new Cell[0];
  }
  
  void addNeighbour(Cell cell) {
    neighbours = (Cell[])append(neighbours, cell);
  }
  
  void calcNextState() {
    if (state == 0) {
      int firingCount = 0;
      for (int i = 0; i < neighbours.length; i++) {
        if (neighbours[i].state == 1) { // <- 発火している隣接セルを数える
          firingCount++;
        }
      }
      if (firingCount == 2) { // <- もし2個のセルが発火していたら発火
        nextState = 1;
      } else {
        nextState = state; // <- それ以外の場合は変化しない
      }
    } else if (state == 1) { // <- 発火したなら休息
      nextState = 2;
    } else if (state == 2) { // <- 休息したならオフ
      nextState = 0;
    }
  }
  
  void drawMe() {
    state = nextState;
    stroke(0);
    if (state == 1) {
      fill(0); // <- 発火 = 黒
    } else if (state == 2) { 
      fill(150); // <- 休息 = グレー
    } else {
      fill(255); // <- オフ = しろ
    }
    ellipse(x, y, _cellSize, _cellSize);
  }
}
```

### 波（平均化）

周囲の影響で混沌が静まっていく標準的な物理モデルの「平均化」を基本にしています。

- もし隣接するセルの状態の平均が255であれば状態は0に
- もし隣接するセルの状態の返金が0であるなら状態は255に
- そうでなければ、新しい状態 = 現在の状態 + 隣接セルの状態の平均 - 前の状態の値
- もし新しい状態が255を超えたら255にし、もし新しい状態が０以下ならそれを0とする

```processing
// 7.5 波のような独自の動き
class Cell {
  float x;
  float y;
  float state; // <-
  float nextState; // <-
  float lastState; // <-
  Cell[] neighbours;
  
  Cell(float ex, float why) {
    x = ex * _cellSize; 
    y = why * _cellSize;
    nextState = ((x / 500) + (y / 300)) * 14;
    state = nextState;
    neighbours = new Cell[0];
  }
  
  void addNeighbour(Cell cell) {
    neighbours = (Cell[])append(neighbours, cell);
  }
  
  void calcNextState() {
    float total = 0; // <- 隣接セルの返金を計算
    for (int i = 0; i < neighbours.length; i++) {
      total += neighbours[i].state;
    }
    float average = int(total / 8);
    
    if (average == 255) {
      nextState = 0;
    } else if (average == 0) {
      nextState = 255;
    } else {
      nextState = state + average;
      if (lastState > 0) { nextState -= lastState; }
      if (nextState > 255) { nextState = 255; }
      else if (nextState < 0) { nextState = 0; }
    }
    lastState = state; // 前の状態を保存
  }
  
  void drawMe() {
    state = nextState;
    stroke(0);
    fill(state); // <- 状態の値に応じた色をつける
    ellipse(x, y, _cellSize, _cellSize);
  }
}
```

## シミュレーションとビジュアライゼーション
この章のコーディング部分は終わりです。しかし、このアプローチをさまざまな方向に発展させていける余地がたくさんあります。
この章の残りのページを利用して、そのうちのいくつかの考えを紹介しましょう。

### ソフトウェア・エージント

```processing
// 例) 単純なオブジェクトの属性とメソッド
class Agent {
  String political_learning = 'right';
  int num_years_in_education = 12;
  int salary = 30000;
  Agent[] neighbors;
  Agent[] coworkers;
  Agent[] friends;
  
  Agent() {
    num_years_in_education = 11 + int(random(8));
    if (num_years_in_eduction < 13) {
      if (random(1 > 0.8)) {
        political_learning = 'right';
      } else {
        political_learning = 'left';
      }
    } else {
      if (random(1) > 0.3) {
        political_learning = 'right';
      } else {
        political_learning = 'left';
      }
    }
  }
}
```

あなたはエージェントの考えや感情を聞き出すことができます。それはおそらくこんな感じになるはずです[
```processing
// 
class Agent {
  // ...
  // ...
  
  boolean isHappy() {
    if (political_learning == 'right') {
      if (salary > 60000) {
        return true;
      } else {
        return false;
      }
    } else {
      if (friends.length > 25) {
        return true;
      } else {
        return false;
      }
    }
  }

}
```

- [THE COLOUR ECONOMY: THE GAP BETWEEN THE RICH AND THE POOR](http://blog.blprnt.com/blog/blprnt/the-colour-economy-the-gap-between-the-rich-and-the-poor)

### 人間エージェント
> 重要な基準の1つは、システムが自律していて、外部からの操作がなく、導き手から自由であること。

> もし人間エージェントが、自分たちの行動がシステムに与える影響に気づかないか、あるいは無関心であれば、他の自律したオブジェクトと同様に、有効なデータベースになりえます。

- [http://seb.ly/](http://seb.ly/)

## まとめ
