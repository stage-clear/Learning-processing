// hand-copying
// Walker.pde

class Walker {
  PVector position;
  
  ArrayList<PVector> history = new ArrayList<PVector>();
  
  Walker() {
    position = new PVector(width / 2, height / 2);
  }
  
  void render() {
    stroke(0);
    beginShape();
    for (PVector v: history) {
      curveVertex(v.x, v.y);
    }
    endShape();
    noFill();
    stroke(0);
    ellipse(position.x, position.y, 16, 16);
  }
  
  void step() {
    position.x += random(-10, 10);
    position.y += random(-10, 10);
    
    position.x = constrain(position.x, 0, width - 1);
    position.y = constrain(position.y, 0, height - 1);
    
    hitstory.add(position.get());
  }
}
