// hand-copying
// Walker.pde

class Walker {
  float x, y;
  float tx, ty;
  
  float prevX, prevY;
  
  Walker() {
    tx = 0;
    ty = 10000;
    x = map(noise(tx), 0, 1, 0, width); // noise(tx)を[0~1]の範囲から[0~width]の範囲へ変換
    y = map(noise(ty), 0, 1, 0, height); // noise(ty)を[0~1]の範囲から[0~height]の範囲へ変換
  }
  
  void render() {
    stroke(255);
    line(prevX, prevY, x, y);
  }
  
  void step() {
    prevX = x;
    prevY = y;
    
    x = map(noise(tx), 0, 1, 0, width);
    y = map(noise(ty), 0, 1, 0, height);
    
    tx += 0.01;
    ty += 0.01;
  }
}
