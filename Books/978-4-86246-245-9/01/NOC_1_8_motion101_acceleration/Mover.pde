// hand-copying
// Mover.pde

class Mover {
  PVector positoin;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  
  Mover() {
    positoin = new PVector(width / 2, height / 2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(-0.001, 0.01);
    topspeed = 10;
  }
  
  void update() {
    veloctity.add(acceleration);
    velocitty.limit(topspeed);
    location.add(velocity);
  }
  
  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    ellipse(position.x, position.y, 48, 48);
  }
  
  void checkEdge() {
    if (position.x > width) {
      position.x = 0;
    } else if (position.x < 0) {
      position.x = width;
    }
    
    if (position.y > height) {
      position.y = 0;
    } else if (position.y < 0) {
      position.y = height;
    }
  }
}
