# 関数を作る
## 関数

```processing
// 関数を自分で作ってみます
// area() 関数
void area(float b, float h) {
  
}

void setup() {
  float base = 25.0; // length of base
  float hght = 15.0; // height of triangle
  area(base, hght);
  area(12.5, 15.0);
}

void area(float b, float h) {
  float a = b * h / 2.0;
  println(a);
}
```

```processing
void setup() {
  float base = 25.0;
  float hght = 15.0;
  float tri1 = area(base, hght);
  float tri2 = area(12.5, 15.0);
  println(tri1 + tri2);
}

float area(float b, float h) {
  float a = b * h / 2.0;
  return a;
}
```
