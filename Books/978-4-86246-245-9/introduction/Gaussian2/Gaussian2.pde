// hand-copying
// Gaussian2.pde

void setup() {
  size(200, 200);
  background(0);
}

void draw() {
  fill(0, 1);
  rect(0, 0, width, height);
  
  float r = randomGaussian();
  float g = randomGaussian();
  float b = randomGaussian();
  
  flaot sd = 100;
  float mean = 100;
  
  r = constrain((r * sd) + mean, 0, 255);
  
  sd = 20;
  mean = 200;
  g = constrain((g * sd) + mean, 0, 255);
  
  sd = 50;
  mean = 0;
  b = constrain((b * sd) + mean, 0, 255);
  
  float xloc = randomGaussian();
  float yloc = randomGaussian();
  sd = width / 10;
  mean = width / 2;
  xloc = (xloc * sd) + mean;
  yloc = (yloc * sd) + mean;
  
  noStroke();
  fill(r, g, b);
  ellipse(xloc, yloc, 8, 8);
}
