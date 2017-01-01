# 動画を保存する
動画としてファイルに保存するには, ライブラリに用意された MovieMaker を使うことができます.

```processing
import processing.video.*
MovieMaker mm;
```

```processing
mm = new MovieMaker(
  this, 
  width, 
  height, 
  "drawing.mov", 
  30, 
  MovieMaker.H263, 
  MovieMaker.HIGH
);
```

```processing
MovieMaker(parent, width, height, filename, fps, type,  quality);
```

`parent` の部分は, 通常 `this` とします.
`width` と `height` の部分はそれぞれ動画の幅と高さです.
`Filename` はファイル名, `fps` は1秒間のフレーム数, `type` は動画の書式で次の中から選びます.

```processing
ANIMATION, BASE, BMP, CINEPAC, COMPONENT, CMYK, GIF, CRAPHICS, JPEG, MS_VIDEO,
MOTION_JPEG_A, MOTION_JPEG_B, RAW, VIDEO, H261, H263, H264
```

`quality` は動画の質で, やはり次の中から選びます.

```processing
WORST, LOW, MEDIUM, HIGH, BEST, LOSSLESS
```

録画は, `draw()` の中に `addFrame()` 追加します.

```processing
mm.addFrame();
```

録画を停止して保存するには, `finish()` のようにする必要があります.

```processing
mm.finish();
```

```processing
import processing.video.*;
MovieMaker mm; // Declare MovieMaker object

void setup() {
  size(480, 120);
  smooth();
  fill(0, 100);
  noStroke();
  mm = new MovieMaker(this, width, height, "drawing.mov", 30, MovieMaker.H263, MovieMaker.HIGH);
}

void draw() {
  ellipse(mouseX, mouseY, 40, 40);
  mm.addFrame(); // Add window's pixels to movie
}

void keyPressed() {
  if (key == 'Q') {
    mm.finish(); // Finish the movie if space bar is pressed!
  }
}
```[
