import java.util.Map;

/**
 * @file
 * This file contains code for the pixel-based graphics driver
 *
 * This is the main file driving the rendering of the pixel grid
 * and the sprites within it.
 * It initializes the pixel grid, creates sprites, and updates
 * the pixel array based on sprite animations and interactions.
 *
 * @author Asanka Sovis (Skeptic Studios)
 */

HashMap<String, Sprite> sprites; // HashMap to store sprites
int sprite_count = 0; // Count of sprites
color[][] background = new color[(int)pixel_res.x][(int)pixel_res.y];
// Array to store colours for each pixel in the background
// Can be used to set a static background colour or pattern

/**
 * @class Driver
 * @brief The main driver class for handling pixel updates and rendering
 *
 * This class manages the pixel grid, sprite animations, and interactions.
 */
class Driver {
  boolean demo = true; // Flag to indicate if the driver is in demo mode
  // In demo mode, random colours are used for the pixel grid
  // Otherwise, it uses a static background colour or pattern
  // depending on the background_type
  color background_colour = color(0, 0, 0); // The colour used for the solid background
  boolean background_type = false; // true for a pattern, false for a solid colour
  
  /**
   * @brief Driver class constructor
   *
   * @param _demo Demo mode flag. If true, random colours are used for the pixel grid.
   * @param _background_colour The colour used for the solid background.
   * @param _background_type If true, the background is a pattern; if false,
   *    it is a solid colour.
   */
  Driver(boolean _demo, color _background_colour, boolean _background_type) {
    demo = _demo;
    background_colour = _background_colour;
    background_type = _background_type;
    
    // Construct sprite hashmap
    sprites = new HashMap<String, Sprite>();
    
    UpdatePixels(); // Update the pixels
  }
  
  /**
   * @brief Initializes the driver
   *
   * This function updates the sprite list using the CreateSprites function.
   * Sprites are defined in the contents.pde file.
   */
  void Initialize() {
    CreateSprites();
  }
  
  /**
   * @brief Updates the pixel array with the current state of the sprites
   *
   * This function iterates through the pixel array and updates each pixel
   * based on the current state of the sprites.
   */
  void UpdatePixels() {
    if (demo) { // If in demo mode, fill the pixel array with random colours
      for (int i = 0; i < pixel_res.y; i++) {
        for (int j = 0; j < pixel_res.x; j++) {
          pixel_array[j][i] = color(random(0, 255), 150, 255);
        }
      }
    } else {
      if (background_type) { // If background type is a pattern, fill the
      // pixel array with the background colours
        for (int i = 0; i < pixel_res.y; i++) {
          for (int j = 0; j < pixel_res.x; j++) {
            pixel_array[j][i] = background[j][i];
          }
        }
      } else { // If background type is a solid colour, fill the pixel array
        // with the background colour
        for (int i = 0; i < pixel_res.y; i++) {
          for (int j = 0; j < pixel_res.x; j++) {
            pixel_array[j][i] = background_colour;
          }
        }
      }
      
      // Each sprite gets updated and animated
      for (Map.Entry me : sprites.entrySet()) {
        Sprite me_sprite = (Sprite)me.getValue();

        me_sprite.animate();
        me_sprite.update();
      }
    }
  }
}

/**
 * @class Sprite
 * @brief Defines an individual sprite
 *
 * This class represents a sprite with properties such as position,
 * velocity, bounding box, and patterns for animation.
 * It includes methods for movement, collision detection, and rendering.
 * Sprites can be animated and can interact with each other based on their
 * defined behaviours.
 */
class Sprite {
  String sprite_name = ""; // Name of the sprite for identification
  PVector position = new PVector(0, 0); // Position of the sprite in the pixel grid
  PVector velocity = new PVector(0, 0); // Velocity of the sprite, used for movement
  // Velocity is a vector that defines how much the sprite moves in each frame
  // It can be set to control the speed and direction of the sprite's movement
  PVector bounding_box = new PVector(0, 0); // Bounding box of the sprite
  // The bounding box defines the area occupied by the sprite in the pixel grid
  // It is used for collision detection and rendering the sprite correctly
  // The bounding box is defined by its width and height, which are set when the sprite
  // is created.
  Pattern[][] snapshots; // Array of patterns representing the sprite's animation frames
  // Each pattern contains the active pixels and their colours for a specific frame
  // The snapshots array allows for multiple frames of animation, enabling the sprite
  // to change appearance over time. The active pixels are defined in the contents.pde
  // file, where the sprite patterns are created and assigned colours.
  int snapshot_count = 0; int pattern_count = 0; // Count of snapshots and patterns
  // snapshot_count is the total number of animation frames available for the sprite
  // pattern_count is the number of patterns within each snapshot frame
  // within the snapshots array.
  int animation_count = 0; int animation_offset = 0; // Animation control variables
  // animation_count defines how many frames of animation are played in a loop
  // animation_offset is used to set the starting point for the animation sequence.
  // This allows for control over which frames are displayed and in what order.
  // It can be used to create different animation sequences or to skip frames.
  int active_snapshot = -1; // Index of the currently active snapshot
  boolean auto_animate = false; // Flag to indicate if the sprite should animate
  // automatically.
  // If true, the sprite will automatically cycle through its animation frames.
  // If false, the sprite will remain on the current frame until manually changed.
  int drive_type = 0; // Type of movement behaviour for the sprite
  // drive_type defines how the sprite interacts with the pixel grid boundaries
  // and other sprites.
  // Possible values:
  // 0 - No movement (sprite remains stationary)
  // 1 - Stop at edge (sprite stops moving when it reaches the edge of the pixel grid)
  // 2 - Bounce at edge (sprite bounces back when it hits the edge of the pixel grid)
  // 3 - Wrap at edge (sprite wraps around to the
  int collision_layer = 1; // Layer for collision detection
  // collision_layer defines which layer the sprite belongs to for collision detection
  // Sprites can be assigned to different layers, allowing for selective collision detection
  // between sprites.
  
  boolean[] reached_the_bounds = {false, false, false, false}; // Flags to indicate if the
  // sprite has reached the bounds of the pixel grid
  boolean[] out_of_bounds = {false, false, false, false}; // Flags to indicate if the
  // sprite is out of bounds
  HashMap<String, Sprite> collided_with = new HashMap<String, Sprite>(); // HashMap to store
  // sprites that this sprite has collided with.
  // This allows for tracking of collisions and interactions between sprites.
  
  int rotation = 0; // Current rotation state of the sprite
  // rotation is used to keep track of the sprite's orientation
  // It can be used to rotate the sprite's patterns for rendering.
  // The rotation is defined in multiples of 90 degrees, with 0 being the default
  // orientation.
  // Possible values:
  // 0 - No rotation (default orientation)
  // 1 - 90 degrees clockwise
  // 2 - 180 degrees (flipped upside down)
  // 3 - 270 degrees clockwise (or 90 degrees counter-clockwise)
  boolean[] flip = {false, false}; // The sprite can also be flipped horizontally or vertically using the Flip method.
  // The flip state is stored in a boolean array, where flip[0] indicates horizontal
  // flip and flip[1] indicates vertical flip.
  
  /**
   * @brief Sprite class constructor
   *
   * @param _sprite_name Name of the sprite for identification
   * @param _initial_position Initial position of the sprite in the pixel grid
   * @param _bounding_box Bounding box of the sprite, defining its width and height
   * @param _snapshots Array of patterns representing the sprite's animation frames
   * @param _snapshot_count Total number of animation frames available for the sprite
   * @param _pattern_count Number of patterns within each snapshot frame
   * @param _active_snapshot Index of the currently active snapshot
   * @param _auto_animate Flag to indicate if the sprite should animate automatically
   * @param _collision_layer Layer for collision detection, used to determine which sprites can collide
   *    with this sprite.
   */
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
  
  /**
   * @brief Set the velocity of the sprite
   * 
   * This function sets the velocity of the sprite, which determines how much
   * the sprite moves in each frame. The velocity is a vector that defines the
   * direction and speed of the sprite's movement.
   * 
   * @param x The x-component of the velocity vector
   * @param y The y-component of the velocity vector
   */
  void SetVelocity(int x, int y) {
    velocity.x = x; velocity.y = y;
  }

  /**
   * @brief Set the position of the sprite
   * 
   * This function sets the position of the sprite in the pixel grid.
   * 
   * @param x The x-coordinate of the sprite's position
   * @param y The y-coordinate of the sprite's position
   */
  void SetPosition(int x, int y) {
    position.x = x; position.y = y;
  }
  
  /**
   * @brief Set the colour of the sprite
   * 
   * This function sets the colour of the sprite, which is used for rendering
   * the sprite's patterns. The colour is applied to all snapshots of the sprite.
   * 
   * @param colour The colour to set for the sprite
   */
  void SetColour(color colour) {
    for (int i = 0; i < snapshot_count; i++) {
      for (int j = 0; j < pattern_count; j++) {
        snapshots[i][j].colour = colour;
      }
    }
  }
  
   /**
   * @brief Set the screen behaviour of the sprite
   * 
   * This function sets the screen behaviour of the sprite, which determines how
   * the sprite interacts with the pixel grid boundaries and other sprites.
   * Possible values:
   * 0 - No movement (sprite remains stationary)
   * 1 - Stop at edge (sprite stops moving when it reaches the edge of the pixel grid)
   * 2 - Bounce at edge (sprite bounces back when it hits the edge of the pixel grid)
   * 3 - Wrap at edge (sprite wraps around to the opposite side of the pixel grid)
   *
   * @param _drive_type The type of movement behaviour for the sprite
   */
  void SetScreenBehaviour(int _drive_type) {
    drive_type = _drive_type;
  }
  
  /**
   * @brief Rotate the sprite (Public method)
   * 
   * This function rotates the sprite by a specified amount.
   * The rotation is defined in multiples of 90 degrees.
   * Possible values:
   * 0 - No rotation (default orientation)
   * 1 - 90 degrees clockwise
   * 2 - 180 degrees (flipped upside down)
   * 3 - 270 degrees clockwise (or 90 degrees counter-clockwise)
   * 
   * @param amount The amount to rotate the sprite
   */
  void Rotate(int amount) {
    ResetTransform();
    
    rotate(amount);
  }
  
  /**
   * @brief Rotate the sprite by a specified amount (Private method)
   * 
   * This function rotates the sprite's patterns by a specified amount.
   * The rotation is defined in multiples of 90 degrees.
   * Possible values:
   * 0 - No rotation (default orientation)
   * 1 - 90 degrees clockwise
   * 2 - 180 degrees (flipped upside down)
   * 3 - 270 degrees clockwise (or 90 degrees counter-clockwise)
   * 
   * @param amount The amount to rotate the sprite
   */
  void rotate(int amount) {
    if ((amount > 0) && (amount < 4)) {
      if (amount == 1) { // Rotate 90 degrees clockwise
        for (int i = 0; i < snapshot_count; i++) {
          for (int j = 0; j < pattern_count; j++) {
            snapshots[i][j].Rotate();
            snapshots[i][j].Flip(false);
          }
        }
      } else if (amount == 2) { // Rotate 180 degrees (flipped upside down)
        for (int i = 0; i < snapshot_count; i++) {
          for (int j = 0; j < pattern_count; j++) {
            snapshots[i][j].Flip(false);
            snapshots[i][j].Flip(true);
          }
        }
      } else if (amount == 3) { // Rotate 270 degrees clockwise (or 90 degrees
      // counter-clockwise)
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
  
  /**
   * @brief Flip the sprite horizontally or vertically (Public method)
   * 
   * This function flips the sprite's patterns either horizontally or vertically.
   * The flip direction is determined by the dir parameter.
   * 
   * @param dir If true, flip horizontally; if false, flip vertically
   */
  void Flip(boolean dir) {
    ResetTransform();
    
    flip(dir);
  }
  
  /**
   * @brief Flip the sprite's patterns (Private method)
   * 
   * This function flips the sprite's patterns either horizontally or vertically.
   * The flip direction is determined by the dir parameter.
   * 
   * @param dir If true, flip horizontally; if false, flip vertically
   */
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
  
  /**
   * @brief Set keyframes for the sprite's animation
   * 
   * This function sets the keyframes for the sprite's animation.
   * The keyframes define the starting point and count of frames to be used
   * in the animation sequence.
   * 
   * @param offset The starting point for the keyframes
   * @param count The number of frames to include in the animation
   * @return true if the keyframes were set successfully, false otherwise
   */
  boolean SetKeyFrames(int offset, int count) {
    if ((offset >= 0) && (count >= 0) && (offset + count <= snapshot_count)) {
      animation_offset = offset; animation_count = count;

      return true;
    }

    return false;
  }
  
  /**
   * @brief Reset the sprite's transformation state
   * 
   * This function resets the sprite's transformation state, including rotation
   * and flip states.
   */
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

  /**
   * @brief Check for collision with another sprite
   * 
   * This function checks if the sprite collides with another sprite.
   * It uses the bounding boxes of both sprites to determine if they overlap.
   * 
   * @param sprite The other sprite to check for collision with
   * @return true if a collision is detected, false otherwise
   */
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
  
  /**
   * @brief Update the sprite's position and handle collisions
   * 
   * This function updates the sprite's position based on its velocity.
   * It checks for collisions with other sprites and handles them based on
   * the sprite's drive type.
   */
  void update() {
    boolean collision_detected = false;
    // Clear the hashmap for collided sprites
    collided_with.clear();
    
    //Check for collisions with other sprites
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

    // Update the sprite's position based on its velocity
    // If a collision is detected, the sprite's position is not updated
    if (!collision_detected) {
      position.add(velocity);
    }
    
    // Check if the sprite has reached the bounds of the pixel grid
    reached_the_bounds[0] = (position.x <= 0);
    reached_the_bounds[1] = (position.y <= 0);
    reached_the_bounds[2] = (position.x >= (pixel_res.x - bounding_box.x));
    reached_the_bounds[3] = (position.y >= (pixel_res.y - bounding_box.y));
    
    out_of_bounds[0] = ((position.x + bounding_box.x) <= 0);
    out_of_bounds[1] = ((position.y + bounding_box.y) <= 0);
    out_of_bounds[2] = (position.x >= pixel_res.x);
    out_of_bounds[3] = (position.y >= pixel_res.y);
    
    // Handle sprite movement based on the drive type
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
  
  /**
   * @brief Animate the sprite
   * 
   * This function animates the sprite by drawing its current snapshot
   * at its position in the pixel grid. It handles wrapping around the edges
   * of the pixel grid if necessary.
   */
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

/**
 * @class Pattern
 * @brief Defines a pattern for a sprite's animation frame
 *
 * This class represents a pattern that defines the active pixels and their colours
 * for a specific frame of the sprite's animation.
 * It includes methods for rotating and flipping the pattern, as well as rendering it
 * to the pixel array.
 */
class Pattern {
  PVector offset_position = new PVector(0, 0); // Offset position of the pattern
  // relative to the sprite's position. The offset position defines where the pattern
  // is drawn relative to the sprite's position.
  // The offset position is defined by its x and y coordinates, which are set when the
  // pattern is created.
  PVector bounding_box = new PVector(0, 0); // Bounding box of the pattern
  // The bounding box defines the area occupied by the pattern in the pixel grid.
  // It is used for rendering the pattern correctly and for collision detection.
  // The bounding box is defined in the contents.pde file by its width and height,
  // which are set when the pattern is created.
  PVector[] active_pixels; // Array of active pixels in the pattern
  // The active pixels are the pixels that are part of the pattern and will be drawn
  // to the pixel array. Each active pixel is defined by its x and y coordinates relative
  // to the pattern's offset position.
  // The active pixels are defined in the contents.pde file, where the sprite patterns
  // are created and assigned colours.
  int pixel_count = 0; // Count of active pixels in the pattern
  // It is used to iterate through the active pixels when drawing the pattern.
  // The pixel count is set when the pattern is created, based on the number of active
  // pixels defined in the contents.pde file.
  color colour = color(0, 0, 0); // Colour of the pattern
  // The colour is used for rendering the pattern to the pixel array.
  // It is set when the pattern is created, and can be changed later using the SetColour
  // method. The colour is defined in the contents.pde file, where the sprite patterns
  // are created and assigned colours.
  
  /**
   * @brief Pattern class constructor
   *
   * @param _offset_position Offset position of the pattern relative to the sprite's position
   * @param _bounding_box Bounding box of the pattern, defining its width and height
   * @param _active_pixels Array of active pixels in the pattern
   * @param _pixel_count Count of active pixels in the pattern
   * @param _colour colour of the pattern
   */
  Pattern(PVector _offset_position, PVector _bounding_box, PVector[] _active_pixels, int _pixel_count, color _colour) {
    offset_position = _offset_position;
    bounding_box = _bounding_box;
    active_pixels = _active_pixels;
    pixel_count = _pixel_count;
    colour = _colour;
  }
  
  /**
   * @brief Rotate the pattern
   * 
   * This function rotates the pattern by swapping the x and y coordinates of the active pixels.
   * It effectively rotates the pattern 90 degrees clockwise.
   */
  void Rotate() {
    for (int i = 0; i < pixel_count; i++) {
      float temp = active_pixels[i].y;
      active_pixels[i].y = active_pixels[i].x;
      active_pixels[i].x = temp;
    }
  }
  
  /**
   * @brief Flip the pattern horizontally or vertically
   * 
   * This function flips the pattern either horizontally or vertically based on the dir parameter.
   * If dir is true, it flips vertically; if false, it flips horizontally.
   * 
   * @param dir If true, flip vertically; if false, flip horizontally
   */
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
  
  /**
   * @brief Draw the pattern to the pixel array
   * 
   * This function draws the pattern to the pixel array at the specified position.
   * It handles wrapping around the edges of the pixel grid if necessary.
   * 
   * @param x_pos The x-coordinate of the position where the pattern should be drawn
   * @param y_pos The y-coordinate of the position where the pattern should be drawn
   * @param wrap If greater than 0, allows wrapping around the edges of the pixel grid
   */
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
