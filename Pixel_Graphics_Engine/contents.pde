/**
 * @file
 * This file contains code for creating sprites
 *
 * This file contains code for creating sprites at the start of the sketch.
 * All sprites that need to be created should be placed within the CreateSprites()
 * function.
 *
 * @author Asanka Sovis (Skeptic Studios)
 */

/**
 * @brief Create sprites for the pixel art animation
 *
 * Any sprites that need to be created at the start of the sketch
 * should be placed within this function. This function initializes the sprites
 * and adds them to the sprites map for later use. This function is called
 * in the setup() function of the main sketch file once at startup.
 */
void CreateSprites() {
  // Place code here to create sprites at the start of the sketch
  // This is where you can initialize your sprites and add them to the sprites map
  // For example, you can create a sprite for a ball and add it to the sprites
  // map with a unique key.
  // The sprites map is used to store all the sprites in the sketch.
  // Sample code to create a sprite:
  colorMode(HSB, 255);

  // Puts random background colours in the pixel array
  for (int i = 0; i < pixel_res.y; i++) {
    for (int j = 0; j < pixel_res.x; j++) {
      background[j][i] = color(random(0, 255), 150, 255);
    }
  }
  
  // Create five ball sprites and add them to the sprites map
  for (int i = 0; i < 5; i++) {
    sprites.put("ball" + i, return_ball(i));
  }
}

/**
 * @brief Sample function to create a ball sprite
 *
 * This function is a sample function that creates a ball sprite
 * with a random colour and position. It returns a Sprite object that can
 * be added to the sprites map. The sprite has a bounding box of 3x3 pixels
 * and a velocity that is randomly set to either -1 or 1 in both x and y directions.
 * The sprite also has a screen behaviour set to 2, which means it will wrap around
 * the edges of the pixel grid.
 *
 * @param i The index of the ball sprite being created
 * @return A Sprite object representing the ball
 */
Sprite return_ball(int i) {
  // Pixels that are active in the sprite.
  // These are the pixels that will be drawn when the sprite is animated.
  // The active pixels are defined as a 3x3 grid of pixels in this example.
  // You can modify this to create different shapes or patterns for your sprite.
  // The active pixels are defined as a vector of PVector objects.
  // Each PVector object represents a pixel in the sprite.
  // The x and y values of the PVector object represent the position of the pixel
  // in the sprite's bounding box.
  PVector[] active_pixels = {
    new PVector(0, 0), new PVector(1, 0), new PVector(2, 0),
    new PVector(0, 1), new PVector(1, 1), new PVector(2, 1),
    new PVector(0, 2), new PVector(1, 2), new PVector(2, 2)
  };

  // Create a pattern for the sprite using the active pixels
  // The pattern is defined as a 2D array of Pattern objects.
  // Each Pattern object represents a single frame of the sprite's animation.
  // In this example, we create a single pattern with the active pixels.
  Pattern[][] pattern = {new Pattern[1]};
  pattern[0][0] = new Pattern(new PVector(0, 0), new PVector(3, 3), active_pixels, 9, color(random(0, 255), 255, 255));

  // Create a sprite with the pattern and set its properties
  // The sprite is created with a unique name, position, bounding box size,
  // velocity, pattern, and other properties.
  // The sprite's position is set to a random position within the pixel grid.
  // The sprite's velocity is set to a random value of -1 or 1 in both x and y directions.
  // The sprite's screen behaviour is set to 2, which means it will wrap around the edges of the pixel grid.
  // The sprite's bounding box is set to 3x3 pixels, and it has a velocity of 1 pixel per frame.
  Sprite sprite = new Sprite("ball" + i, new PVector(random(0, pixel_res.x), random(0, pixel_res.y)), new PVector(3, 3), 
    pattern, 1, 1, 0, true, 1);

  if (random(0, 2) == 1) {
    sprite.SetVelocity(-1, -1);
  } else {
    sprite.SetVelocity(1, 1);
  }

  // Set the sprite's screen behaviour
  sprite.SetScreenBehaviour(2);

  return sprite;
}