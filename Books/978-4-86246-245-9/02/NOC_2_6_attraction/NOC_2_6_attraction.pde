// hand-copying
// NOC_2_6_attraction.pde

Mover m;
Attractor a;

void setup() {
  size(640, 360);
  m = new Mover();
  a = new Attractor();
}

void draw() {
  background(255);
  
  PVector force = a.attract(m);
  m.applyForce(force);
  m.update();
  
  a.drag();
  a.hover(mouseX, mouseY);
  
  a.display();
  m.display();
}
