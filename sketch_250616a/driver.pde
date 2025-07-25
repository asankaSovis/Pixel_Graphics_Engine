import java.util.Map;

HashMap<String, Sprite> sprites;
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
    
    sprites = new HashMap<String, Sprite>();
    
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
      
      for (Map.Entry me : sprites.entrySet()) {
        Sprite me_sprite = (Sprite)me.getValue();
        me_sprite.animate();
        me_sprite.update();
      }
    }
  }
}

class Sprite {
  String sprite_name = "";
  PVector position = new PVector(0, 0);
  PVector velocity = new PVector(0, 0);
  PVector bounding_box = new PVector(0, 0);
  Pattern[][] snapshots;
  int snapshot_count = 0; int pattern_count = 0;
  int animation_count = 0; int animation_offset = 0;
  int active_snapshot = -1;
  boolean auto_animate = false;
  int drive_type = 0;
  int collision_layer = 1;
  
  boolean[] reached_the_bounds = {false, false, false, false};
  boolean[] out_of_bounds = {false, false, false, false};
  HashMap<String, Sprite> collided_with = new HashMap<String, Sprite>();
  
  int rotation = 0;
  boolean[] flip = {false, false};
  
  Sprite(String _sprite_name, PVector _initial_position, PVector _bounding_box, Pattern[][] _snapshots, int _snapshot_count, int _pattern_count, int _active_snapshot, boolean _auto_animate, int _collision_layer) {
    sprite_name = _sprite_name;
    position = _initial_position;
    bounding_box = _bounding_box;
    snapshots = _snapshots;
    snapshot_count = _snapshot_count;
    pattern_count = _pattern_count;
    active_snapshot = _active_snapshot;
    auto_animate = _auto_animate;
    collision_layer = _collision_layer;
    
    animation_count = snapshot_count;
    animation_offset = 0;
  }
  
  void SetVelocity(int x, int y) {
    velocity.x = x; velocity.y = y;
  }
  
  void SetPosition(int x, int y) {
    position.x = x; position.y = y;
  }
  
  void SetColour(color colour) {
    for (int i = 0; i < snapshot_count; i++) {
      for (int j = 0; j < pattern_count; j++) {
        snapshots[i][j].colour = colour;
      }
    }
  }
  
  void SetScreenBehaviour(int _drive_type) {
    drive_type = _drive_type;
  }
  
  void Rotate(int amount) {
    ResetTransform();
    
    rotate(amount);
  }
  
  void rotate(int amount) {
    if ((amount > 0) && (amount < 4)) {
      if (amount == 1) {
        for (int i = 0; i < snapshot_count; i++) {
          for (int j = 0; j < pattern_count; j++) {
            snapshots[i][j].Rotate();
            snapshots[i][j].Flip(false);
          }
        }
      } else if (amount == 2) {
        for (int i = 0; i < snapshot_count; i++) {
          for (int j = 0; j < pattern_count; j++) {
            snapshots[i][j].Flip(false);
            snapshots[i][j].Flip(true);
          }
        }
      } else if (amount == 3) {
        for (int i = 0; i < snapshot_count; i++) {
          for (int j = 0; j < pattern_count; j++) {
            snapshots[i][j].Rotate();
            snapshots[i][j].Flip(true);
          }
        }
      }
      
      rotation = (rotation + amount) % 4;
    }
  }
  
  void Flip(boolean dir) {
    ResetTransform();
    
    flip(dir);
  }
  
  void flip(boolean dir) {
    for (int i = 0; i < snapshot_count; i++) {
      for (int j = 0; j < pattern_count; j++) {
        snapshots[i][j].Flip(dir);
      }
    }
   
    if (dir) {
      flip[1] = !(flip[1]);
    } else {
      flip[0] = !(flip[0]);
    }
  }
  
  boolean SetKeyFrames(int offset, int count) {
    if ((offset >= 0) && (count >= 0) && (offset + count <= snapshot_count)) {
      animation_offset = offset; animation_count = count;
      return true;
    }
    return false;
  }
  
  void ResetTransform() {
    if (rotation != 0) {
      rotate(4 - rotation);
    }
    
    if (flip[0]) {
      flip(false);
    }
    
    if (flip[1]) {
      flip(true);
    }
  }

  boolean CheckCollision(Sprite sprite) {
    PVector next_position_me = new PVector(position.x, position.y);
    PVector next_position_sprite = new PVector(sprite.position.x, sprite.position.y);
    next_position_me.add(velocity);
    next_position_sprite.add(sprite.velocity);
    
    boolean collision = (((next_position_me.x <= next_position_sprite.x + sprite.bounding_box.x) &&
            (next_position_me.x + bounding_box.x >= next_position_sprite.x)) &&
            ((next_position_me.y <= next_position_sprite.y + sprite.bounding_box.y) &&
            (next_position_me.y + bounding_box.y >= next_position_sprite.y)));

    return collision;
  }
  
  void update() {
    boolean collision_detected = false;
    // Clear the hashmap for collided sprites
    collided_with.clear();
    
    for (Map.Entry other : sprites.entrySet()) {
      Sprite other_sprite = (Sprite)other.getValue();
      
      if ((sprite_name != other_sprite.sprite_name) && ((collision_layer == 0) || (other_sprite.collision_layer == 0) || (collision_layer == other_sprite.collision_layer))) {
        boolean collision = CheckCollision(other_sprite);
        
        if (collision) {
          //println(sprite_name + " collided with " + other_sprite.sprite_name);
          
          if (other_sprite.drive_type == 2) { // Bounce
            velocity.x = -velocity.x;
            velocity.y = -velocity.y;
          }

          collision_detected = true;
          // Add the collided sprite to the hashmap
          collided_with.put(other_sprite.sprite_name, other_sprite);
        }
      }
    }

    if (!collision_detected) {
      position.add(velocity);
    }
    
    reached_the_bounds[0] = (position.x <= 0);
    reached_the_bounds[1] = (position.y <= 0);
    reached_the_bounds[2] = (position.x >= (pixel_res.x - bounding_box.x));
    reached_the_bounds[3] = (position.y >= (pixel_res.y - bounding_box.y));
    
    out_of_bounds[0] = ((position.x + bounding_box.x) <= 0);
    out_of_bounds[1] = ((position.y + bounding_box.y) <= 0);
    out_of_bounds[2] = (position.x >= pixel_res.x);
    out_of_bounds[3] = (position.y >= pixel_res.y);
    
    if (drive_type == 1) { // Stop at edge
      if (reached_the_bounds[0] || reached_the_bounds[1] || reached_the_bounds[2] || reached_the_bounds[3]) {
        velocity.x = 0; velocity.y = 0;
      }
    }
    if (drive_type == 2) { // Bounce at edge
      if (reached_the_bounds[0]) {
        velocity.x = abs(velocity.x);
      } else if (reached_the_bounds[2]) {
        velocity.x = -(abs(velocity.x));
      }
      if (reached_the_bounds[1]) {
        velocity.y = abs(velocity.y);
      } else if (reached_the_bounds[3]) {
        velocity.y = -(abs(velocity.y));
      }
    }
    if (drive_type == 3) { // Wrap at edge
      if (out_of_bounds[0]) {
        position.x = pixel_res.x - bounding_box.x;
        out_of_bounds[0] = false;
      }
      if (out_of_bounds[1]) {
        position.y = pixel_res.y - bounding_box.y;
        out_of_bounds[1] = false;
      }
      if (out_of_bounds[2]) {
        position.x = 0;
        out_of_bounds[2] = false;
      }
      if (out_of_bounds[3]) {
        position.y = 0;
        out_of_bounds[3] = false;
      }
    }
  }
  
  void animate() {
    if (!(out_of_bounds[0] || out_of_bounds[1] || out_of_bounds[2] || out_of_bounds[3])) {
      for (int i = 0; i < pattern_count; i++) {
        int wrap_pattern = 0;
        if (drive_type == 3) {
          for (int j = 0; j < 4; j++) {
            if (reached_the_bounds[j]) {
              wrap_pattern++;
            }
          }
        }
        snapshots[active_snapshot][i].draw((int)position.x, (int)position.y, wrap_pattern);
      }
      
      if ((active_snapshot > -1) && (active_snapshot < snapshot_count)) {
        if (auto_animate) {
          active_snapshot = animation_offset + (frameCount % animation_count);
        }
      }
    } else {
      //println(sprite_name + ": Not drawn");
    }
  }
}

class Pattern {
  PVector offset_position = new PVector(0, 0);
  PVector bounding_box = new PVector(0, 0);
  PVector[] active_pixels;
  int pixel_count = 0;
  color colour = color(0, 0, 0);
  
  Pattern(PVector _offset_position, PVector _bounding_box, PVector[] _active_pixels, int _pixel_count, color _colour) {
    offset_position = _offset_position;
    bounding_box = _bounding_box;
    active_pixels = _active_pixels;
    pixel_count = _pixel_count;
    colour = _colour;
  }
  
  void Rotate() {
    for (int i = 0; i < pixel_count; i++) {
      float temp = active_pixels[i].y;
      active_pixels[i].y = active_pixels[i].x;
      active_pixels[i].x = temp;
    }
  }
  
  void Flip(boolean dir) {
    if (dir) {
      for (int i = 0; i < pixel_count; i++) {
        active_pixels[i].y = (bounding_box.y - active_pixels[i].y - 1);
      }
    } else {
      for (int i = 0; i < pixel_count; i++) {
        active_pixels[i].x = (bounding_box.x - active_pixels[i].x - 1);
      }
    }
  }
  
  void draw(int x_pos, int y_pos, int wrap) {
    for (int i = 0; i < pixel_count; i++) {
      int x = (int)(x_pos + offset_position.x + active_pixels[i].x);
      int y = (int)(y_pos + offset_position.y + active_pixels[i].y);
      
      if ((x >= 0) && (x < pixel_res.x) && (y >= 0) && (y < pixel_res.y)) {
        pixel_array[x][y] = colour;
      } else if (wrap > 0) {
        int wrapped = 0;
        
        if (x < 0) {
          x += (pixel_res.x);
          wrapped++;
        } else if (x >= pixel_res.x) {
          x -= pixel_res.x;
          wrapped++;
        }
        if (y < 0) {
          y += (pixel_res.y);
          wrapped++;
        } else if (y >= pixel_res.y) {
          y -= pixel_res.y;
          wrapped++;
        }
        if (wrapped >= wrap) {
          pixel_array[x][y] = colour;
        }
      }
    }
  }
}
