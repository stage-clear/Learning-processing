// hand-copying
// RandomWalkNoise.pde

Walker w;

void setup() {
  size(640, 360);
  w = new Walker();
  background(0);
}

void draw() {
  w.step();
  w.render();
}
