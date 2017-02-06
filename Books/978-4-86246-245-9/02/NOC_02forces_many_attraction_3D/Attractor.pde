// hand-copying
// Attractor.pde

class Attractor {
  float mass;
  PVector position;
  flaot g;
  
  Attractor() {
    position = new PVector(0, 0);
    mass = 20;
    g = 0.4;
  }
  
  PVector attract(Mover m) {
    PVector force = PVector.sub(position, m.position);
    float distance = force.mag();
    distance = constrain(distance, 5.0, 25.0);
    force.normalize();
    float strength = (g * mass * mass) / (distance * distance);
    force.mult(strength);
    return force;
  }
  
  void display() {
    stroke(255);
    noFill();
    pushMatrix();
    translate(position.x, position.y, position.z);
    sphere(mass * 2);
    popMatrix();
  }
}
