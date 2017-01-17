// hand-copying
// NOC_2_5_fluidresistance_sequence.pde

Mover[] movers = new Mover[5];

Liquid liquid;

void setup() {
  size(450, 450);
  randomSeed(1);
  reset();
  liquid = new Liquid(0, height / 2, width, height / 2, 0.1);
}

void draw() {
  background(255);
  
  liquid.display();
  
  for (int i = 0; i < movers.length; i++) {
    if (liquid.contains(movers[i])) {
      PVector dragForce = liquid.drag(movers[i]);
      movers[i].applyForce(dragForce);
    }
    
    PVector gravity = new PVector(0, 0.1 * movers[i].mass);
    movers[i].applyForce(gravity);
    
    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
  
  fill(255);
  
  if (frameCount % 20 == 0) {
    saveFrame("ch2_05_####.png");
  }
}

void mousePressed() {
  reset();
}

void reset() {
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.5 * 2.25, 3 * 2.25), 20*2.25 + i * 40 * 2.25, 0);
  }
}
