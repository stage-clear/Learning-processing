// hand-copying
// NOC_2_2_forces_many.pde

Mover[] movers = new Mover[20];

void setup() {
  size(640, 360);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.1, 4), 0, 0);
  }
}

void draw() {
  background(255);
  
  for (int i = 0; i < movers.length; i++) {
    PVector wind = new PVector(0.01, 0);
    PVector gravity = new PVector(0, 0.1);
    
    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);
    
    movers[i].update();
    movers[i].display();
    movers[i].checkEdge();
  }
}
