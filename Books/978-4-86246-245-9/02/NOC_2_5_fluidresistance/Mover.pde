// hand-copying
// Mover.pde

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
  
  // Newton's 2nd law: F = M * A
  // or A = F / M
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }
  
  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127, 200);
    ellipse(position.x, position.y, mass * 16, mass * 16);
  }
  
  void checkEdges() {
    if (position.y > height) {
      velocity.y *= -0.9;
      position.y = height;
    }
  }
}
