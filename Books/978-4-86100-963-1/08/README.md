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
