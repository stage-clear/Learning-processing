// hand-copying
// NOC_1_9_motion101_acceleration.pde

Mover mover;

void setup() {
  size(640, 320);
  mover = new Mover();
}

void draw() {
  background(255);
  mover.update();
  mover.checkEdge();
  mover.display();
}
