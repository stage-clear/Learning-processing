# データ
## データ構造

## Table クラスと表

```java
Table stats;

void setup() {
  stats = loadTable("ortiz.csv");
  for (int i = 0; i < stats.getRowCount(); i++) {
    // i 行目、0列目の整数（年）を取得
    int year = stats.getInt(i, 0);
    // i 行目、1列目の整数（本塁打数）を取得
    int homeRuns = stats.getInt(i, 1);
    // i 行目、2列目の整数（打点）を取得
    int rbi = stats.getInt(i, 2);
    // i 行目、3列目の浮動小数点（打率）を取得
    float average = stats.getFloat(i, 3);
    println(year, homeRuns, rbi, average); // 出力
  }
}
```

- [Table](https://processing.org/reference/Table.html) - Class

```java
// 表からグラフを描く
int[] homeRuns;

void setup() {
  size(480, 120);
  Table stats = loadTable("ortiz.csv");
  int rowCount = stats.getRowCount();
  homeRuns = new int[rowCount];
  for (int i = 0; i < homeRuns.length; i++) {
    homeRuns[i] = stats.getInt(i, 1);
  }
}

void draw() {
  background(204);
  // グラフの目盛りを描く
  stroke(255);
  line(20, 100, 20, 20);
  line(20, 100, 460, 100);
  for (int i = 0; i < homeRuns.length; i++) {
    float x = map(i, 0, homeRuns.length - 1, 20, 460);
    line(x, 20, x, 100);
  }
  // 本塁打数のデータに基づいた折れ線グラフを描画
  noFill();
  stroke(204, 51, 0);
  beginShape();
  for (int i = 0; i < homeRuns.length; i++) {
    float x = map(i, 0, homeRuns.length - 1, 20, 460);
    float y = map(homeRuns[i], 0, 60, 100, 20);
    vertex(x, y);
  }
  endShape();
}
```

```java
// 29,740 の町
Table cities;

void setup() {
  size(240, 120);
  cities = loadTable("cities.csv", "header"); // <-
  stroke(255);
}

void draw() {
  background(0, 26, 51);
  float xoffset = map(mouseX, 0, width, -width * 3, -width);
  translate(xoffset, -300);
  scale(10);
  strokeWeight(0.1);
  for (int i = 0; i < cities.getRowCount(); i++) {
    float latitude = cities.getFloat(i, "lat");
    float longitude = cities.getFloat(i, "lng");
    setXY(latitude, longitude);
  }
}

void setXY(float lat, float lng) {
  float x = map(lng, -180, 180, 0, width);
  float y = map(lat, 90, -90, 0, height);
  print(x, y);
}
```

- [loadTable()](https://processing.org/reference/loadTable_.html)

> `setup()` 内の `loadTable()` を見てください。
> `"header"` というキーワードがあります。これを付けずに実行すると1行目も市のデータとして読み込んでしまいます。
> `"header"` を付けると1行目を飛ばしてくれます

## JSON
```java
// JSONファイルを読み込む
JSONObject film;

void setup() {
  film = loadJSONObject("film.json");
  String title = film.getString("title");
  String dir = film.getString("director");
  int year = film.getInt("year");
  float rating = film.getFloat("rating");
  println(title + " by " + dir + ", " + year);
  println("Rating: " + rating);
}
```

- [loadJSONObject()](https://processing.org/reference/loadJSONObject_.html)

```java
// JSONファイルのデータをビジュアライス
Film[] films;

void setup() {
  size(480, 120);
  JSONArray filmArray = loadJSONArray("films.json");
  films = new Film[filmArray.size()];
  for (int i = 0; i < films.length; i++) {
    JSONObject o = filmArray.getJSONObject(i);
    films[i] = new Film(o);
  }
}

void draw() {
  background(0);
  for (int i = 0; i < films.length; i++) {
    int x = i * 32 + 32;
    films[i].display(x, 105);
  }
}

class Film {
  String title;
  String director;
  int year;
  float rating;
  
  Film(JSONObject f) {
    title = f.getString("title");
    director = f.getString("director");
    year = f.getInt("year");
    rating = f.getFloat("rating");
  }
  
  void display(int x, int y) {
    float ratingGray = map(rating, 6.5, 8.1, 102, 255);
    pushMatrix();
    translate(x, y);
    rotate(-QUARTER_PI);
    fill(ratingGray);
    text(title, 0, 0);
    popMatrix();
  }
}
```

- [loadJSONObject()](https://processing.org/reference/loadJSONObject_.html)

```java
// 気温データを抽出する
void setup() {
  float temp = getTemp("cincinnati.json");
  println(temp);
}

float getTemp(String fileName) {
  JSONObject wheather = loadJSONObject(fileName);
  JSONArray list = weather.getJSONArray("list");
  JSONObject item = list.getJSONObject(0);
  JSONObject main = item.getJSONObject("main");
  float temperature = main.getFloat("temp");
  return temperature;
}
```

```java
// メソッドの連結
JSONObject weather;

void setup() {
  float temp = getTemp("cincinnati.json");
  println(temp);
}

float getTemp(String fileName) {
  JSONObject weather = loadJSONObject(fileName);
  return weather.getJSONArray("list").getJSONObject(0).getJSONObject("main").getFloat("temp");
}
```

## Robot 10: Data

```java
PrintWriter output;

void setup() {
  size(720, 480);
  // 新しいファイルを作成
  output = createWriter("botArmy.tsv");
  // ヘッダー行を出力
  output.println("type\tx\ty");
  
  for (int y = 0; y <= height; y += 120) {
    for (int x = 0; x <= width; x += 60) {
      int robotType = int(random(1, 4));
      output.println(robotType + "\t" + x + "\t" + y);
      ellipse(x, y, 12, 12);
    }
  }
  output.flush();
  output.close();
}
```
このスケッチを実行したあと、スケッチフォルダ内の botArmy.tsv を開いて内容を見てください。
次のスケッチは、botArmy.tsv を読み込み、そのデータを使ってロボットを描きます

```java
Table robots;
PShape bot1;
PShape bot2;
PShape bot3;

void setup() {
  size(720, 480);
  background(0, 153, 204);
  bot1 = loadShape("robot1.svg");
  bot2 = loadShape("robot2.svg");
  bot3 = loadShape("robot3.svg");
  shapeMode(CENTER);
  robots = loadTable("botArmy.tsv", "header");
  for (int i = 0; i < robots.getRowCount(); i++) {
    int bot = robots.getInt(i, "type");
    int x = robots.getInt(i, "x");
    int y = robots.getInt(i, "y");
    float sc = 0.3;
    if (bot == 1) {
      shape(bot1, x, y, bot1.width * sc, bot1.height * sc);
    } else if (bot == 2) {
      shape(bot2, x, y, bot2.width * sc, bot2.height * sc);
    } else {
      shape(bot3, x, y, bot3.width * sc, bot3.height * sc);
    }
  }
}
```
配列と Table クラスの `rows()` メソッドを使うと、このスケッチは次のようにもっと短く書くことができます。

```java
int numRobotTypes = 3;
PShape[] shapes = new PShape[numRobotTypes];
float scalar = 0.3;

void setup() {
  size(720, 480);
  background(0, 153, 204);
  for (int i = 0; i < numRobotTypes; i++) {
    shapes[i] = loadShape("robot" + (i + 1) + ".svg");
  }
  shapeMode(CENTER);
  Table botArmy = loadTable("botArmy.tsv", "header");
  for (TableRow row: botArmy.rows()) {
    int robotType = row.getInt("type");
    int x = row.getInt("x");
    int y = row.getInt("y");
    PShape bot = shapes[robotType - 1];
    shape(bot, x, y, bot.width * scalar, bot.height * scalar);
  }
}
```
