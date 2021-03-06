// hand-copying
// Walker.pde

class Walker {
  PVector position;
  
  ArrayList<PVector> history;
  
  Walker() {
    position = new PVector(width / 2, height / 2);
    history = new ArrayList<PVector>();
  }
  
  void display() {
    stroke(0);
    fill(175);
    rectMode(CENTER);
    rect(position.x, position.y, 16, 16);
    
    beginShape();
    stroke(0);
    noFill();
    for (PVector v: history) {
      vertex(v.x, v.y);
    }
    endShape();
  }
  
  void walk() {
    PVector vel = new PVector(random(-2, 2), random(-2, 2));
    position.add(vel);
    
    position.x = constrain(position.x, 0, width - 1);
    position.y = constrain(position.y, 0, height - 1);
    
    history.add(position.get());
    if (history.size() > 1000) {
      history.remove(0);
    }
  }
}
