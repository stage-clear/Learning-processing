// hand-copying
// Extra_instantforce.pde

Mover m;

float t = 0.0;

void setup() {
  size(640, 360);
  m = new Mover();
}

void draw() {
  background(255);
  
  float wx = map(noise(t), 0, 1, -1, 1);
  PVector wind = new PVector(wx, 0);
  t += 0.01;
  line(width / 2, height / 2, width / 2 + wind.x * 100, height / 2 + wind.y * 100);
  m.applyForce(wind);
  
  PVector gravity = new PVector(0, 0.1);
  // m.applyForce(gravity); 
  
  // Shake force
  // m.shake();
  
  // Boundrary force
  if (m.position.x > width - 50) {
    PVector boundary = new PVector(-1, 0);
    m.applyForce(boundary);
  } else if (m.position.x < 50) {
    PVector boundary = new PVector(1, 0);
    m.applyForce(boundary);
  }
  
  m.update();
  m.display();
  // m.checkEdges();
}

void mousePressed() {
  PVector cannon = PVector.random2D();
  cannon.mult(5);
  m.applyForce(cannon);
}
