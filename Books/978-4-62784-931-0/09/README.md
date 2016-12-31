# 繰り返して描く樹木のかたち
## ツリー
複雑に見えますが, よく観察すると枝は先端で二つに分かれ, 分かれた枝がまた二つに分かれる
というふうに繰り返しによって描かれていることがわかります.

## 枝の描画
```processing
translate(width / 2, height - 20);
strokeWeight(10);
line(0, 0, 0, -1000);
```

## 枝分かれ
```processing
// 原点を移動
translate(0, -100);

rotate(theta);
strokeWeight(w);
line(0, 0, 0, -h);
```

```processing
float angle = 20; // degree
float theta = radians(angle); // radian

void setup() {
  size(600, 400);
  smooth();
}

void draw() {
  background(255);
  translate(width / 2, height - 20);
  strokeWeight(10);
  line(0, 0, 0, -100);
  translate(0, -100);
  branch(100, 10);
}

void branch(float h, float w) {
  h *= 0.7;
  w *= 0.7;
  
  // right branch
  pushMatrix();
  rotate(theta);
  strokeWeight(w);
  line(0, 0, 0, -h);
  popMatrix();
  
  // left branch
  pushMatrix();
  rotate(-theta);
  strokeWeight(w);
  line(0, 0, 0, -h);
  popMatrix();
}
```

## 再帰

```processing
pushMatrix();
rotate(theta);
strokeWeight(w);
line(0, 0, 0, -h);
translate(0, -h); // 先端まで移動
branch(h, w); // 再帰によりさらに枝分かれ
popMatrix();
```

```processing
float angle = 20; // degree
float theta = radians(angle); // radian

void setup() {
  size(600, 400);
  smooth();
}

void draw() {
  background(255);
  float angle = map(mouseY, 0, height, 0, 90);
  theta = radians(angle);
  translate(width / 2, height - 20);
  strokeWeight(10);
  line(0, 0, 0, -100);
  translate(0, -100);
  branch(100, 10);
}

void branch(float h, float w) {
  h *= 0.7;
  w *= 0.7;
  if (h > 2) {
    // right branch
    pushMatrix();
    rotate(theta);
    strokeWeight(w);
    line(0, 0, 0, -h);
    translate(0, -h);
    branch(h, w);
    popMatrix();
    
    // left
    pushMatrix();
    rotate(-theta);
    strokeWeight(w);
    line(0, 0, 0, -h);
    translate(0, -h);
    branch(h, w);
    popMatrix();
  }
}
```
