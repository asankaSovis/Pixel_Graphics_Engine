PVector pixel_res = new PVector(50, 40);
int pixel_raduis = 7;
color back = #5F5F5F;

color[][] pixel_array = new color[(int)pixel_res.x][(int)pixel_res.y];

void setup() {
  size(1000, 800);
  
  for (int i = 0; i < pixel_res.y; i++) {
    for (int j = 0; j < pixel_res.x; j++) {
      pixel_array[j][i] = color(0, 0, 0);
    }
  }
}

void draw() {
  UpdatePixels();
  DrawPixels();
  delay(100);
}

void UpdatePixels() {
  for (int i = 0; i < pixel_res.y; i++) {
    for (int j = 0; j < pixel_res.x; j++) {
      pixel_array[j][i] = color(random(0, 255), 150, 255);
    }
  }
}

void DrawPixels() {
  colorMode(RGB, 255);
  background(back);
  PVector pixel_size = new PVector(width / pixel_res.x, height / pixel_res.y);
  
  strokeWeight(2);
  stroke(back);
  colorMode(HSB, 255);
  
  PVector pixel_pos = new PVector(0, 0);
  
  for (int i = 0; i < pixel_res.y; i++) {
    for (int j = 0; j < pixel_res.x; j++) {
      fill(pixel_array[j][i]);
      rect(pixel_pos.x, pixel_pos.y, pixel_size.x, pixel_size.y, pixel_raduis);
      
      pixel_pos.x += pixel_size.x;
    }
    pixel_pos.x = 0;
    pixel_pos.y += pixel_size.y;
  }
}
