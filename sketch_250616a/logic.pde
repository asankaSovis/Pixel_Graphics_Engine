int movement_direction = 0;

void PerformLogic() {
  if (movement_direction == 0) {
    sprites.get("pacman1").SetVelocity(0, 0);
    sprites.get("active_ghost").SetVelocity(0, 0);
  } else if (movement_direction == 1) {
    sprites.get("pacman1").SetVelocity(0, -1);
    sprites.get("active_ghost").SetVelocity(0, -1);
    
    sprites.get("pacman1").Rotate(1);
    sprites.get("active_ghost").SetKeyFrames(4, 2);
  } else if (movement_direction == 2) {
    sprites.get("pacman1").SetVelocity(0, 1);
    sprites.get("active_ghost").SetVelocity(0, 1);
    
    sprites.get("pacman1").Rotate(3);
    sprites.get("active_ghost").SetKeyFrames(6, 2);
  } else if (movement_direction == 3) {
    sprites.get("pacman1").SetVelocity(-1, 0);
    sprites.get("active_ghost").SetVelocity(-1, 0);
    
    sprites.get("pacman1").ResetTransform();
    sprites.get("active_ghost").SetKeyFrames(0, 2);
  } else if (movement_direction == 4) {
    sprites.get("pacman1").SetVelocity(1, 0);
    sprites.get("active_ghost").SetVelocity(1, 0);
    
    sprites.get("pacman1").Flip(false);
    sprites.get("active_ghost").SetKeyFrames(6, 2);
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      movement_direction = 1;
    } else if (keyCode == DOWN) {
      movement_direction = 2;
    } else if (keyCode == LEFT) {
      movement_direction = 3;
    } else if (keyCode == RIGHT) {
      movement_direction = 4;
    } 
  }
}
