// hand-copying
// NOC_I_4_Gaussian.pde

void setup() {
  size(640, 360);
  background(255);
}

void draw() {
  float xloc = randomGaussian();
  
  float sd = 60;
  float mean = width / 2;
  xloc = (xloc * sd) + mean;
  
  fill(0, 10);
  noStroke();
  ellipse(xloc, height / 2, 16, 16);
}
