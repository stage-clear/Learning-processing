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

```pricessing
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
