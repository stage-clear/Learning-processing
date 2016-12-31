# セルオートマトンが作る迷路
## ルール

## 配列の準備
```processing
int[][] Cells = new int[102][102];
int[][] newCells = new int[102][102];
int[][] rule = {
  { 0, 0, 0, 1, 0, 0, 0, 0, 0 },
  { 1, 1, 1, 1, 1, 0, 0, 0, 0 }
};
```

## 表示 - `display()`
```processing
if (Cells[i][j] == 1) {
  fill(0);
} else {
  fill(255);
}
rect((i - 1) *  5, (j - 1) * 5, 5, 5);
```

```processing
for (int i = 1; i <= 100; i++) {
  for (int j = 1; j <= 100; j++) {
    if (Cells[i][j] == 1) {
      fill(0);
    } else {
      fill(255);
    }
    rect((i - 1) * 5, (j - 1) * 5, 5, 5);
  }
}
```

`clear()` 関数はすべてのセルを0すなわち白にします.

```processing
for (int i = 0; i <= 101; i++) {
  for (int j = 0; j <= 101; j++) {
    Cells[i][j] = 0;
  }
}
display();
```

## 境界処理 - `boundary()`
外側にある仮装セルの処理を行います.
```processing
Cells[i][0] = Cells[i][100];
Cells[i][101] = Cells[i][1];

// 左右
Cells[0][i] = Cells[100][i];
Cells[101][i] = Cells[1][i];
```

## 更新 - `update()`
内部にあるすべての[, それぞれの近傍にある1すなわち黒のセルの数を調べ, ルールを参照して次の時刻の状態を決定します.

```processing
nei = Cells[i - 1][j -1] + Cells[i][j - a] + Cells[i + 1][j - 1]
    + Cells[i - 1][j] + Cells[i + 1][j]
    + Cells[i - 1][j * 1] + Cells[i][j + 1] + Cells[i + 1][j + 1]
```[


