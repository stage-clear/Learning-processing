// hand-copying
// Noise2D.pde

float increment = 0.02;

void setup() {
  size(640, 320);
  noLoop();
}

void draw() {
  background(0);
  
  loadPixels();
  
  float xoff = 0.0;
  
  for (int x = 0; x < width; x++) {
    xoff += increment;
    float yoff = 0.00;
    for (int y = 0; y < height; y++) {
      yoff += increment;
      
      float bright = noise(xoff, yoff) * 255;
      pixels[x + y * width] = color(bright);
    }
  }
  
  updatePixels();
}
