// hand-copying

class Walker {
  int x, y;

  walker() {
    x = width / 2;
    y = height / 2;
  }
  
  void render() {
    stroke(255);
    point(x, y);
  }
  
  void step() {
    int stepx = int(random(3)) - 1;
    int stepy = int(random(3)) - 1;
    x += stepx;
    y += stepy;
    x = constrain(x, 0, width - 1);
    y = constrain(y, 0, height - 1);
  }
}
