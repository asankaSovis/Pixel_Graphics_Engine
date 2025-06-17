Sprite[] sprites;
int sprite_count = 0;
color[][] background = new color[(int)pixel_res.x][(int)pixel_res.y];

class Driver {
  boolean demo = true;
  color background_colour = color(0, 0, 0);
  boolean background_type = false;
  
  Driver(boolean _demo, color _background_colour, boolean _background_type) {
    demo = _demo;
    background_colour = _background_colour;
    background_type = _background_type;
    
    UpdatePixels();
  }
  
  void Initialize() {
    CreateSprites();
  }
  
  void UpdatePixels() {
    if (demo) {
      for (int i = 0; i < pixel_res.y; i++) {
        for (int j = 0; j < pixel_res.x; j++) {
          pixel_array[j][i] = color(random(0, 255), 150, 255);
        }
      }
    } else {
      if (background_type) {
        for (int i = 0; i < pixel_res.y; i++) {
          for (int j = 0; j < pixel_res.x; j++) {
            pixel_array[j][i] = background[j][i];
          }
        }
      } else {
        for (int i = 0; i < pixel_res.y; i++) {
          for (int j = 0; j < pixel_res.x; j++) {
            pixel_array[j][i] = background_colour;
          }
        }
      }
      
      for (int i = 0; i < sprite_count; i++) {
        sprites[i].animate();
      }
    }
  }
}

class Sprite {
  PVector position = new PVector(0, 0);
  PVector bounding_box = new PVector(0, 0);
  Pattern[][] snapshots;
  int snapshot_count = 0; int pattern_count = 0;
  int active_snapshot = -1;
  boolean auto_animate = false;
  
  Sprite(PVector _initial_position, PVector _bounding_box, Pattern[][] _snapshots, int _snapshot_count, int _pattern_count, int _active_snapshot, boolean _auto_animate) {
    position = _initial_position;
    bounding_box = _bounding_box;
    snapshots = _snapshots;
    snapshot_count = _snapshot_count;
    pattern_count = _pattern_count;
    active_snapshot = _active_snapshot;
    auto_animate = _auto_animate;
  }
  
  void animate() {
    for (int i = 0; i < pattern_count; i++) {
      snapshots[active_snapshot][i].draw((int)position.x, (int)position.y);
    }
    
    if ((active_snapshot > -1) && (active_snapshot < snapshot_count)) {
      if (auto_animate) {
        active_snapshot = frameCount % snapshot_count;
      }
    }
  }
}

class Pattern {
  PVector offset_position = new PVector(0, 0);
  PVector[] active_pixels;
  int pixel_count = 0;
  color colour = color(0, 0, 0);
  
  Pattern(PVector _offset_position, PVector[] _active_pixels, int _pixel_count, color _colour) {
    offset_position = _offset_position;
    active_pixels = _active_pixels;
    pixel_count = _pixel_count;
    colour = _colour;
  }
  
  void draw(int x_pos, int y_pos) {
    for (int i = 0; i < pixel_count; i++) {
      int x = (int)(x_pos + offset_position.x + active_pixels[i].x);
      int y = (int)(y_pos + offset_position.y + active_pixels[i].y);
      
      if ((x >= 0) && (x < pixel_res.x) && (y >= 0) && (y < pixel_res.y)) {
        pixel_array[x][y] = colour;
      }
    }
  }
}
