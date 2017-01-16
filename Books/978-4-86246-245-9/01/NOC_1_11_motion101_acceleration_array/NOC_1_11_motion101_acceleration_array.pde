// hand-copying
// NOC_1_11_motion101_acceleration_array.pde

Mover[] movers = new Mover[20];

void setup() {
  size(640, 360);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover();
  }
}

void draw() {
  background(255);
  
  for (int i = 0; i < movers.length; i++) {
    movers[i].update();
    movers[i].display();
  }
}
