// hand-copying
// RandomWalkTrail.pde

Walker w;

void setup() {
  size(400, 400);
  frameRate(30);
  
  w = new Walker();
}

void draw() {
  background(255);
  w.walk();
  w.display();
}
