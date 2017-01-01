# 画像を保存する

ファイルに保存するには, `saveFrame()` 関数を使うことができます.

```processing
saveFrame("filename.ext");
saveFrame("filename-####.ext");
```

`filename` の部分は任意のファイル名です.
その後ろに `####` のように付け加えるとフレーム番号が付加されます.
`ext` の部分は拡張子で `"tif", "tga", "jpg", "png"` のいずれかを選びます.

```processing
void setup() {
  size(480, 120);
  smooth();
  fill(0, 100);
  noStroke();
}

void draw() {
  ellipse(mouseX, mouseY, 40, 40);
}

void keyPressed() {
  if (key == 'p') {
    saveFrame("example_####.tif");
  }
}
```
