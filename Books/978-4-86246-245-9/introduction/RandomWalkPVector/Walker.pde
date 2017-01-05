// hand-copying
// Walker.pde

class Walker {
  PVector pos;
  
  Walker() {
    loc = new PVector(width / 2, height / 2);
  }
  
  void render() {
    stroke(0);
    fill(175);
    rectMode(CENTER);
    rect(pos.x, pos.y, 40, 40);
  }
  
  void walk() {
    PVector vel = new PVector(random(-2, 2), random(-2, 2));
    pos.add(vel);
    
    pos.x = constrain(pos.x, 0, width - 1);
    pos.y = constrain(pos.y, 0, height - 1);
  }
}
