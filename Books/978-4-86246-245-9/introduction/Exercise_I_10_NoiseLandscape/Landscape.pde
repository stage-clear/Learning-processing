// hand-copying
// Landscape.pde

class Landscape {
  int scl;
  int w, h;
  int rows, cols;
  float zoff = 0.0;
  float[][] z;
  
  Landscape(int scl_, int w_, int h_) {
    scl = scl_;
    w = w_;
    h = h_;
    cols = w / scl;
    rows = h / scl;
    z = new float[cols][rows];
  }
  
  void calculate() {
    float xoff = 0;
    for (int i = 0; i < cols; i++) {
      float yoff = 0;
      for (int j = 0; j < rows; j++) {
        z[i][j] = map(noise(xoff, yoff, zoff), 0, 1, -120, 120);
        yoff += 0.1;
      }
      xoff += 0.1;
    }
    zoff += 0.01;
  }
  
  void render() {
    for (int x = 0; x < z.length - 1; x++) {
      for (int y = 0; y < z[x].length - 1; y++) {
        stroke(0);
        fill(100, 100);
        pushMatrix();
        beginShape(QUADS);
        translate(x * scl - w / 2, y * scl - h / 2, 0);
        vertex(0, 0, z[x][y]);
        vertex(scl, 0, z[x + 1][y]);
        vertex(scl, scl, );
      }
    }
  }
}
