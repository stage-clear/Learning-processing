// hand-copying
// NOC_2_3_forces_many_realgravity.pde

class Mover {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  
  Mover(float m, float x, float y) {
    mass = m;
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }
  
  void applyForce(PVector force) {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }
  
  void display() {
    stroke(0);
    strokeWeight(2);
    fill(0, 127);
    ellipse(position.x, position.y, mass * 16, mass * 16);
  }
  
  void checkEdge() {
    if (position.x > width) {
      position.x = width;
      velocity.x *= -1;
    } else if (position.x < 0) {
      position.x = 0;
      veloctity.x *= -1;
    }
    
    if (position.y > height) {
      position.y = height;
      velocity.y *= -1;
    }
  }
}
