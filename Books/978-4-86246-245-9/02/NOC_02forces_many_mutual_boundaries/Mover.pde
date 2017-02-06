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
    fill(175, 200);
    ellipse(position.x, position.y, mass * 16, mass * 16);
  }
  
  PVector attract(Mover m) {
    PVector force = PVector.sub(position, m.position);
    float distance = force.mag();
    distance = constrain(distance, 5.0, 25.0);
    force.normalize();
    
    float strength = (g * mass * m.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }
  
  void boundaries() {
    float d = 50;
    
    PVector force = new PVector(0, 0);
    
    if (position.x < d) {
      force.x = 1;
    } else if (position.x > width - d) {
      force.x = -1;
    }
    
    if (position.y < d) {
      force.y = 1;
    } else if (position.y > height - d) {
      force.y = -1;
    }
    
    force.normalize();
    force.mult(0.1);
    
    applyForce(force);
  }
}
