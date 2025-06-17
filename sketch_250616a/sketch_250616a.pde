PVector pixel_res = new PVector(50, 40);
int pixel_raduis = 7;
color back = #2F2F2F;
int frame_delay = 300;

color[][] pixel_array = new color[(int)pixel_res.x][(int)pixel_res.y];

Driver driver = new Driver(false, color(0, 0, 0), false);

void setup() {
  size(1000, 800);
  driver.Initialize();
}

void draw() {
  driver.UpdatePixels();
  DrawPixels();
  delay(frame_delay);
}



void DrawPixels() {
  background(back);
  PVector pixel_size = new PVector(width / pixel_res.x, height / pixel_res.y);
  
  strokeWeight(2);
  stroke(back);
  
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
