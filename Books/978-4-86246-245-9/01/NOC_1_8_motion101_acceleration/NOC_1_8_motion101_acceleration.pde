// hand-copying
// NOC_1_8_motion101_acceleration.pde

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
