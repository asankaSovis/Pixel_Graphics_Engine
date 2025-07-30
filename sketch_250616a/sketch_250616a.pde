/**
 * @brief Processing based Pixel Art Animation
 *
 * This project creates pixel art animation using Processing. The main idea
 * is to use a grid of pixels that can be programmed to display sprites
 * and animations. These pixels can be manipulated to create various visual effects
 * including user input which allows for basic games development.
 *
 * @details
 * - Main Processing sketch file for the pixel art animation.
 *
 * @file sketch_250616a.pde
 * @author Asanka Sovis (Skeptic Studios)
 * @version 1.0
 * @license GNU General Public License v3.0 (GPL-3.0)
 * @date 30/07/2025
 */

/**
 * pixel_res: Resolution of the pixel grid. Modify horizontal and vertical resolution
 *    by setting the x and y values of this vector.
 * pixel_size: Size of each pixel in the grid. This determines how large each pixel appears
 *    on the screen. Adjust the x and y values to change the pixel size.
 * pixel_offset: Offset for the pixel grid. This can be used to shift the entire grid
 *    horizontally or vertically. Set the x and y values to change the offset.
 */
PVector pixel_res = new PVector(46, 46); // Resolution of the pixel grid
PVector pixel_size = new PVector(20, 20); // Size of each pixel
PVector pixel_offset = new PVector(0, 0); // Offset for the pixel

int pixel_raduis = 7; // Radius of the corners of each pixel rectangle
color back = #2F2F2F; // Background colour of the canvas
int frame_delay = 300; // Delay between frames in milliseconds

// Create the pixel array
color[][] pixel_array = new color[(int)pixel_res.x][(int)pixel_res.y];

// Create the driver instance
// The driver handles the pixel updates and rendering
Driver driver = new Driver(false, color(0, 0, 0), false);

// Setup
void setup() {
  size(920, 920); // Set the size of the canvas
  driver.Initialize(); // Initialize the driver
}

// Draw loop
void draw() {
  PerformLogic(); // Perform logic updates
  driver.UpdatePixels(); // Update the pixel array with the driver
  DrawPixels(); // Draw the pixels on the canvas
  delay(frame_delay); // Delay for frame rate control
}


/**
 * @brief Draws the pixels on the canvas
 *
 * This function iterates through the pixel array and draws each pixel
 *
 */
void DrawPixels() {
  background(back); // Set the background colour
  PVector pixel_size = new PVector(width / pixel_res.x, height / pixel_res.y);
  // Calculate the pixel size based on the canvas size and resolution
  
  strokeWeight(2);
  stroke(back);
  
  PVector pixel_pos = new PVector(0, 0);
  
  // Iterate through the pixel array and draw each pixel
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
