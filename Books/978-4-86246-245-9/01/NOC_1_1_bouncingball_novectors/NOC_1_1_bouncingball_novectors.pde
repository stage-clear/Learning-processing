// hand-copying
// NOC_1_1_bouncingball_novectors.pde

float x = 100;
float y = 100;
float xspeed = 2.5;
float yspeed = 2;

void setup() {
  size(800, 200);
  smooth();
}

void draw() {
  background(255);
  
  x = x + xspeed;
  y = y + yspeed;
  
  if ((x > width) || (x < 0)) {
    xspeed = xspeed * -1;
  }
  if ((y > height) || (y < 0)) {
    yspeed = yspeed * -1;
  }
  
  stroke(0);
  strokeWeight(2);
  fill(127);
  ellipse(x, y, 48, 48);
}
