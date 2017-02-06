// hand-copying
// Attractor.pde

class Attractor {
  float mass;
  PVector position;
  boolean dragging = false;
  boolean rollover = false;
  PVector drag;
  
  Attractor() {
    position = new PVector(width / 2, height / 2);
    mass = 10;
    drag = new PVector(0.0, 0.0);
  }
  
  PVector attract(Mover m) {
    PVector force = PVector.sub(position, m.position);
    float d = force.mag();
    d = constrain(d, 5.0, 25.0);
    force.normalize();
    float strength = (g * mass * m.mass) / (d * d);
    force.mult(strength);
    return force;
  }
  
  void display() {
    ellipseMode(CENTER);
    stroke(0);
    if (dragging) fill(50);
    else if (rollover) fill(100);
    else fill(0);
    ellipse(position.x, position.y, mass * 6, mass * 6);
  }
  
  void clicked(int mx, int my) {
    float d = dist(mx, my, position.x, position.y);
    if (d < mass) {
      dragging = true;
      drag.x = position.x - mx;
      drag.y = position.y - my;
    }
  }
  
  void rollover(int mx, int my) {
    float d = dist(mx, my, position.x, position.y);
    if (d < mass) {
      rollover = true;
    } else {
      rollover = false;
    }
  }
  
  void stopDragging() {
    dragging = false;
  }
  
  void drag() {
    if (dragging) {
      position.x = mouseX + drag.x;
      position.y = mouseY + drag.y;
    }
  }
}
