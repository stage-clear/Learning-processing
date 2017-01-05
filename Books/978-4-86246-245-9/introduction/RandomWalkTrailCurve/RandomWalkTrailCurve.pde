// hand-copying
// RandomWalkTrailCurve.pde

Walker w;

void setup() {
  size(400, 300);
  w = new Walker();
}

void draw() {
  background(255);
  
  w.step();
  w.render();
}
