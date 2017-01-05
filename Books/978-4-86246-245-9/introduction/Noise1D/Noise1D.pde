// hand-copying
// Noise1D.pde

float xoff = 0.0;
float xincrement = 0.01;

void setup() {
  size(200, 200);
  background(0);
  noStroke();
}

void draw() {
  fill(0, 10); 
  rect(0, 0, width, height); 
  
  float n = noise(xoff) * width;
  
  xoff += xincrement;
  
  fill(200);
  ellipse(n, height / 2, 16, 16);
}
