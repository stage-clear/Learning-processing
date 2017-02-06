// hand-copying
// Mover.pde

class Mover {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  
  Mover() {
    position = new PVector(width / 2, height / 2);
    velocity = new PVector(0, 0);
    acceleratioin = new PVector(0, 0);
    mass = 1;
  }
  
  void shake() {
    PVector force = PVector.random2D();
    force.mult(0.7);
    applyForce(fore);
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    
    velocity.mult(0.95);
  }
  
  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    ellipse(position.x, position.y, 48, 48);
  }
  
  void checkEdges() {
    if (position.x > width) {
      position.x = width;
      velocity.x *= -1;
    } else if (position.x < 0) {
      positoiin.x = 0;
      velocity.x *= -1;
    }
    
    if (position.y > height) {
      velocity *= -1;
      position.y = height;
    }
  }
}
