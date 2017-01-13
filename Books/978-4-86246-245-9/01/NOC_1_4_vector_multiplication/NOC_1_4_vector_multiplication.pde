// hand-copying
// NOC_1_4_vector_multiplication.pde

void setup() {
  size(640, 360);
  smooth();
}

void draw() {
  background(255);
  
  PVector mouse = new PVector(mouseX, mouseY);
  PVector center = new PVector(width / 2, height / 2);
  mouse.sub(center);
  
  mouse.mult(0.5);
  
  translate(width / 2, height / 2);
  strokeWeight(2); 
  stroke(0);
  line(0, 0, mouse.x, mouse.y);
}
