// hand-copying
// NOC_1_7_motion101.pde

Mover mover;

void setup() {
  size(640, 360);
  mover = new Mover();
}

void draw() {
  background(255);
  
  mover.update();
  mover.checkEdge();
  mover.display();
}
