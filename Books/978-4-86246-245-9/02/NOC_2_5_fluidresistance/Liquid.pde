// hand-copying
// Liquid.pde

class Liquid {
  float x, y, w, h;
  float c;
  
  Liquid(float x_, float y_, float w_, float h_, float c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }
  
  boolean contains(Mover m) {
    float speed = m.velocity.mag();
    float dragMagnitude = c * speed * speed;
    
    PVector dragForce = m.velocity.get();
    dragForce.mult(-1);
    
    dragForce.normalize();
    dragForce.mult(dragMagnitude);
    return dragForce;
  }
  
  void display() {
    noStroke();
    fill(50);
    rect(x, y, w, h);
  }
}
