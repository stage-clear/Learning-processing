// hand-copying
// RandomWalkTraditional2.pde

Walker w;

void setup() {
  size(200, 200);
  w = new Walker();
  background(0);
}

void draw() {
  w.step();
  w.render();
}
