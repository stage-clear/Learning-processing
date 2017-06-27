# 6. 創発
<sup>_Emergence_</sup>
## 創発を定義する
低いレベルでの単純なルールが、高いレベルの組織化された複雑さを生み出す現象を「創発」と呼びます。

### アリの群れと群衆アルゴリズム
> なんと、アリの群れの構造と動きは、中央集権的には決められていなかったのです。
> グローバルなレベルのパターンと構造はすべて、ローカルなレベルの多数のミクロな決定から生まれます。
> デザイン、階層、指導者、その他いかなる高レベルな影響も、その中に入っていません。

> それぞれのムクドリは、飛行の速度と方位を決めるのに、自分に最も近い個体だけを見ます。
> この効果は、よく知られているクレイグ・レイノルズの Boids アルゴリズムとして、1987年に計算モデル化されました。

- 分離 -- 近くの個体を避けて進む
- 整列 -- 近くの個体の平均の進行方向に向かって進む
- 結合 -- 近くの個体の平均の位置に向かって進む

[ダン・シフマンが Processing で Boids を実装しました](https://processing.org/examples/flocking.html)

### ローカルに考え、ローカルに行動する

> 明らかに、ここには政治的な意味合いがあります。
> もしそれが自然界でうまく機能しているなら、人間世界においても、中央組織（政府や諸制度）はかなり必要のないものだということを創発は示唆しています。

## オブジェクト指向プログラミング
### クラスとインスタンス

```processing
// 6.1 マウスクリックのたびにいくつかの円を描くコード
int _num = 10;

void setup() {
  size(500, 300);
  background(255);
  smooth();
  strokeWeight(1);
  fill(150, 50);
  drawCircle();
}

void draw() {

}

void mouseReleased() {
  drawCircle();
}

void drawCircles() {
  for (int i = 0; i < _num; i++) {
    float x = random(width);
    float y = random(height);
    float radius = random(100) + 10;
    noStroke();
    ellipse(x, y, radius * 2, radius * 2);
    stroke(0, 150);
    ellipse(x, y, 10, 10);
  }
}
```

```processing
// 6.2 Circle クラス
class Circle {
  float x;
  float y;
  float radius;
  color linecol;
  color fillcol;
  float alph;
  
  Circle() {
    x = random(width);
    y = random(height);
    radius = random(100) + 10;
    linecol = color(random(255), random(255), random(255));
    fillcol = color(random(255), random(255), random(255));
    alph = random(255);
  }
}
```

```processing
// new キーワードを使って呼びます
void drawCircles() {
  for (int i = 0; i < _num; i++) {
    Circle thisCirc = new Circle(); // <- まだ描画はされません
  }
}
```

```processing
// 初めてメソッドと共にふたたび Circle クラスを
class Circle {

  // 属性
  float x;
  float y;
  float radius;
  color linecol;
  color fillcol;
  float alph;
  
  // コンストラクタ
  Circle() {
    x = random(width);
    y = random(height);
    radius = random(100) + 10;
    linecol = color(random(255), random(255), random(255));
    fillcol = color(random(255), random(255), random(255));
    alph = random(255);
  }
  
  // オブジェクト・メソッド
  void drawMe() {
    noStroke();
    fill(fillcol, alph);
    ellipse(x, y, radius * 2, radius * 2);
    stroke(linecol, 150);
    noFill();
    ellipse(x, y, 10, 10);
  }
}
```

```processing
void drawCircles() {
  for (int i = 0; i < _num; i++) {
    Circle theCirc = new Circle();
    thisCirc.drawMe(); // <-
  }
}
```

コードを何箇所か更新して、以下のことを行います

- すべての円をしまっておくための配列を作成する
- それぞれの円に x, y 方向の動きを与える
- それぞれの円に、__draw__ ループでフレームごとに呼ばれる __updateMe__ メソッドを与える

```processing
int _num = 10;
Circle[] _circleArr = {}; // <- 円の配列を定義

void setup() {
  size(500, 300);
  background(255);
  smooth();
  strokeWeight(1);
  fill(150, 50);
  drawCircles();
}

void draw() {
  background(255);
  for (int i = 0; i < _circleArr.length; i++) {
    Circle thisCirc = _circleArr[i];
    thisCirc.updateMe();
  }
}

void mouseRelease() {
  drawCircles();
}

void drawCircles() {
  for (int i = 0; i < _num; i++) {
    Circle thisCirc = new Circle();
    thisCirc.drawMe();
    _circleArr = (Circle[])append(_circleArr, thisCirc); // <- オブジェクトを配列に加える
  }
}

// objects
class Circle {
  float x;
  float y;
  float radius;
  color linecol;
  color fillcol;
  float alph;
  float xmove; // <- 全てのフレームでステップを進める
  float ymove; // <-
  
  Circle() {
    x = random(width);
    y = random(height);
    radius = random(100) + 10;
    linecol = color(random(255), random(255), random(255));
    fillcol = color(random(255), random(255), random(255));
    alph = random(255);
    xmove = random(10) - 5; // <- ランダムなステップ
    ymove = random(10) - 5; // <-
  }
  
  void drawMe() {
    noStroke();
    fill(fillcol, alph);
    ellipse(x, y, radius * 2, radius * 2);
    stroke(linecol, 150);
    noFill();
    ellipse(x, y, 10, 10);
  }

  void updateMe() {
    x += xmove; // <- フレームごとに動かす
    y += ymove; // <-
    if (x > (width + radius)) { x = 0 - radius; } // <- ステージの端から出ないようにする
    if (x < (0 - radius)) { x = width + radius; } // <-
    if (y > (height + radius)) { y = 0 - radius; } // <-
    if (y < (0 - radius)) { y = height + radius; } // <-
    
    drawMe(); // <- 描く
  }
}
```

> __配列を使う__  
> 配列は以下のように定義します  
> `int[] numberArray = new int[5];`  
> すべてが int 型の5つの要素を持つリストを宣言します  
> `int[] numberArray = {1, 2, 3, 4, 5};`  
> 以下のように、それぞれの位置に要素に項目を加えることができます  
> `numberArray[2] = 3;`  
> `int[] numberArray = {};`  
> 追加のスロットを配列に加え、そのスロットにデータを入れるためには __append__ を使います。
> 新しい要素を配列に加える際には、__int__ []のようにその型を明記する必要があります。  
> `numberArray = (int[])append(numberArray, 6);`  

### ローカルな知識（衝突判定）

```processing
// 6.5 Circle クラスno updateMe メソッド(衝突判定付き)
class Circle {
  // ...
  // ...

  void updateMe() {
    x += xmove;
    y += ymove;
    if (x > (width + radius)) { x = 0 - radius; }
    if (x < (0 - radius)) { x = width + radius; }
    if (y > (height + radius)) { y = 0 - radius; }
    if (y < (0 - radius)) { y = height + radius; }

    boolean touching = false; // <-
    for (int i = 0; i < _circleArr.length; i++) {
      Circle otherCirc = _circleArr[i];
      if (otherCirc != this) {
        float dis = dist(x, y, otherCirc.x, otherCirc.y);
        if ((dis - radius - otherCirc.radius) < 0) {
          touching = true;
          break;
        }
      }
    }

    // 衝突判定が true なら、縁がだんだん消えていきます
    if (touching) {
      if (alph > 0) { alph--; }
    } else {
      if (alph < 255) { alph += 2; }
    }

    drawMe();
  }
}
```

### インタラクション・パターン

> 2つの点の中心点を計算するときには、少し慎重にならなくてはなりません。

```processing
// 交差している円の座標よりも大きいならば、中間点のxは
x + (otherCirc.x - x) / 2

// 現在の円のx座標が交差している円のx座標よりも小さければ
otherCirc.x + (x - otherCirc.x) / 2
```
> たった1行のコードでどちらの可能性もカバーできるもっといい方法があります。

```processing
// 2つの円の平均値はそれらの2つの間に中間点をとるので
(x + otherCirc.x) / 2
```

```processing
// 6.6 Circle クラスの updateMe メソッドで円を描く
class Circle {
  //...
  //...
  
  void updateMe() {
    x += xmove;
    y += ymove;
    if (x > (width + radius)) { x = 0 - radius; }
    if (x < (0 - radius)) { x = width + radius; }
    if (y > (height + radius)) { y = 0 - radius; }
    if (y < (0 - radius)) { y = height + radius; }
    
    for (int i = 0; i < _circleArr.length; i++) {
      Circle otherCirc = _circleArr[i];
      if (otherCirc != this) {
        float dis = dist(x, y, otherCirc.x, otherCirc.y);
        float overlap = dis - radius - otherCirc.radius; // <- 重なった部分を計算する
        if (overlap < 0) { // <- 重なりがマイナス = 接触
          float midx;
          float midy;
          midx = (x + otherCirc.x) / 2; // <- 中間点を計算
          midy = (y + otherCirc.y) / 2; // 
          stroke(0, 100);
          noFill();
          overlap *= -1;
          ellipse(midx, midy, overlap, overlap);
        }
      }
    }

    drawMe();
  }
}
```

> さらに、マウスプレス関数に現在の円の数を表示させる1行を加えることで、今いくつの円が作られてか知ることができます

```processing
void mouseReleased() {
  drawCircle();
  println(_circleArr.length);
}
```

> いくつかのアイデアを紹介します。
- 痕跡を残す --- フレームごとのスクリーンをクリアしない。その代わり透明な長方形をその上に描く
- アルファ値と線の太さを減らす --- 線をもっと曖昧な感じにして、くっきりした境界を有機的にぼやけさせる
- もっと複雑な経路にする --- 2つの点を直線で結ぶよりも、ずっと面白いルートがあることを前章で見ていきました。例えばカーブに沿って動きを作って見たらどうでしょう。
- もっと面白い形を描く --- 単純な円よりも、何かもっとドキドキするようなものを描く。イメージを読み込んで、オブジェクトの視覚表現に使用することも可能です。

## まとめ

