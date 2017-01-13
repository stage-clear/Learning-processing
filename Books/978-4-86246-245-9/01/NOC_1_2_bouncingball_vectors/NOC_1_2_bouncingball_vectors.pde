// hand-copying
// NOC_1_2_bouncingball_vectors.pde

PVector position;
PVector velocity;

void setup() {
  size(200, 200);
  background(255); 
  position = new PVector(100, 100);
  velocity = new PVector(2.5, 5);
}

void draw() {
  noStroke();
  fill(255, 10);
  rect(0, 0, width, height);
  
  position.add(velocity);
  
  if ((position.x > width) || (position.x < 0)) {
    velocity.x = velocity.x * -1;
  }
  if ((position.y > height) || (position.y < 0)) {
    velocity.y = velocity.y * -1;
  }
  
  stroke(0);
  fill(175);
  ellipse(position.x, position.y, 16, 16);
}
