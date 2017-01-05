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

- [RandomWalk](./RandomWalk/)
- [RandomWalkLevy](./RandomWalkLevy/)
- [RandomWalkerNoise](./RandomWalkerNoise/)
- [モンテカルロ法](https://www.wikiwand.com/ja/%E3%83%A2%E3%83%B3%E3%83%86%E3%82%AB%E3%83%AB%E3%83%AD%E6%B3%95)