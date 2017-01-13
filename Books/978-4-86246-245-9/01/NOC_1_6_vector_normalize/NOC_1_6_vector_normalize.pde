// hand-copying
// NOC_1_6_vector_normalize.pde

void setup() {
  size(640, 360);
}

void draw() {
  background(255);
  
  PVector mouse = new PVector(mouseX, mouseY);
  PVector center = new PVector(width / 2, height / 2);
  mouse.sub(center);
  
  mouse.normalize();
  
  mouse.mult(150);
  
  translate(width / 2, height / 2);
  stroke(0);
  strokeWeight(2);
  line(0, 0, mouse.x, mouse.y);
}
