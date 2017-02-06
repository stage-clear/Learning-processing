// hand-copying
// NOC_2_1_forces.pde

Mover m;

void setup() {
  size(640, 360);
  m = new Mover();
}

void draw() {
  background(255);
  
  PVector wind = new PVector(0.01, 0);
  PVector gravity = new PVector(0, 0.1);
  m.applyForce(wind);
  m.applyForce(gravity);
  
  m.update();
  m.display();
  m.checkEdge();
}
