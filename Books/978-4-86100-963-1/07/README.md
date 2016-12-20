# 自律性
<sup>_Autonomy_</sup>

> プログラミング用語における「オブジェクト」と「エージェント」の違いは、エージェントが環境を観察し相互作用することにあります。
> エージェントには、目的、意志、偏見といったような、複雑な行動をとる可能性があります。
> それらは不正確さ、自己利益、非合理性などのとても面白い行動を生み出せます。

## セル・オートマン
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
