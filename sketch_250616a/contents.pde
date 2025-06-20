void CreateSprites() {
  colorMode(HSB, 255);
  for (int i = 0; i < pixel_res.y; i++) {
    for (int j = 0; j < pixel_res.x; j++) {
      background[j][i] = color(random(0, 255), 150, 255);
    }
  }
  colorMode(RGB, 255);
  
  Sprite sprite1 = pacman_sprite("pacman1", new PVector(12, 18), 0, true, #FFFD04);
  
  sprites.put("pacman1", sprite1);
  
  Sprite sprite2 = active_ghost("active_ghost", new PVector(30, 18), 0, true, #FD0000);
  
  sprites.put("active_ghost", sprite2);
  
  
  sprites.get("pacman1").SetVelocity(0, 0);
  sprites.get("pacman1").SetScreenBehaviour(3);
  
  sprites.get("active_ghost").SetVelocity(0, 0);
  sprites.get("active_ghost").SetScreenBehaviour(3);
  sprites.get("active_ghost").SetKeyFrames(0, 2);
}

Sprite pacman_sprite(String sprite_name, PVector position, int active_snapshot, boolean auto_animate, color colour) {
  Pattern[][] snapshots = {new Pattern[1], new Pattern[1]};
  
  // Image 01
  PVector[] active_pixels1 = {
    new PVector(2, 0), new PVector(3, 0), new PVector(4, 0),
    new PVector(1, 1), new PVector(2, 1), new PVector(3, 1), new PVector(4, 1), new PVector(5, 1), 
    new PVector(0, 2), new PVector(1, 2), /*new PVector(2, 2), */new PVector(3, 2), new PVector(4, 2), new PVector(5, 2), new PVector(6, 2),
    new PVector(0, 3), new PVector(1, 3), new PVector(2, 3), new PVector(3, 3), new PVector(4, 3), new PVector(5, 3), new PVector(6, 3),
    new PVector(0, 4), new PVector(1, 4), new PVector(2, 4), new PVector(3, 4), new PVector(4, 4), new PVector(5, 4), new PVector(6, 4),
    new PVector(1, 5), new PVector(2, 5), new PVector(3, 5), new PVector(4, 5), new PVector(5, 5),
    new PVector(2, 6), new PVector(3, 6), new PVector(4, 6)
  };
  Pattern pattern1 = new Pattern(new PVector(0, 0), new PVector(7, 7), active_pixels1, 36, colour);
  snapshots[0][0] = pattern1;
  
  // Image 02
  PVector[] active_pixels2 = {
    new PVector(2, 0), new PVector(3, 0), new PVector(4, 0),
    new PVector(1, 1), new PVector(2, 1), /*new PVector(3, 1), */new PVector(4, 1), new PVector(5, 1), 
    /*new PVector(0, 2), new PVector(1, 2), */new PVector(2, 2), new PVector(3, 2), new PVector(4, 2), new PVector(5, 2), new PVector(6, 2),
    /*new PVector(0, 3), new PVector(1, 3), new PVector(2, 3), */new PVector(3, 3), new PVector(4, 3), new PVector(5, 3), new PVector(6, 3),
    /*new PVector(0, 4), new PVector(1, 4), */new PVector(2, 4), new PVector(3, 4), new PVector(4, 4), new PVector(5, 4), new PVector(6, 4),
    new PVector(1, 5), new PVector(2, 5), new PVector(3, 5), new PVector(4, 5), new PVector(5, 5),
    new PVector(2, 6), new PVector(3, 6), new PVector(4, 6)
  };
  Pattern pattern2 = new Pattern(new PVector(0, 0), new PVector(7, 7), active_pixels2, 29, colour);
  snapshots[1][0] = pattern2;
  
  return new Sprite(sprite_name, position, new PVector(7, 7), snapshots, 2, 1, active_snapshot, auto_animate);
}

Sprite active_ghost(String sprite_name, PVector position, int active_snapshot, boolean auto_animate, color colour) {
  Pattern[][] snapshots = {new Pattern[2], new Pattern[2], new Pattern[2], new Pattern[2], new Pattern[2], new Pattern[2], new Pattern[2], new Pattern[2]};
  
  // Body 01
  PVector[] body_1 = {
    new PVector(2, 0), new PVector(3, 0), new PVector(4, 0),
    new PVector(1, 1), new PVector(2, 1), new PVector(3, 1), new PVector(4, 1), new PVector(5, 1), 
    new PVector(0, 2), /*new PVector(1, 2), new PVector(2, 2), */new PVector(3, 2), /*new PVector(4, 2), new PVector(5, 2), */new PVector(6, 2),
    new PVector(0, 3), /*new PVector(1, 3), new PVector(2, 3), */new PVector(3, 3), /*new PVector(4, 3), new PVector(5, 3), */new PVector(6, 3),
    new PVector(0, 4), new PVector(1, 4), new PVector(2, 4), new PVector(3, 4), new PVector(4, 4), new PVector(5, 4), new PVector(6, 4),
    new PVector(0, 5), new PVector(1, 5), new PVector(2, 5), new PVector(3, 5), new PVector(4, 5), new PVector(5, 5), new PVector(6, 5),
    new PVector(0, 6), new PVector(2, 6), new PVector(4, 6), new PVector(6, 6)
  };
  Pattern pattern_body_1 = new Pattern(new PVector(0, 0), new PVector(7, 7), body_1, 32, colour);
  
  // Body 02
  PVector[] body_2 = {
    new PVector(2, 0), new PVector(3, 0), new PVector(4, 0),
    new PVector(1, 1), new PVector(2, 1), new PVector(3, 1), new PVector(4, 1), new PVector(5, 1), 
    new PVector(0, 2), /*new PVector(1, 2), new PVector(2, 2), */new PVector(3, 2), /*new PVector(4, 2), new PVector(5, 2), */new PVector(6, 2),
    new PVector(0, 3), /*new PVector(1, 3), new PVector(2, 3), */new PVector(3, 3), /*new PVector(4, 3), new PVector(5, 3), */new PVector(6, 3),
    new PVector(0, 4), new PVector(1, 4), new PVector(2, 4), new PVector(3, 4), new PVector(4, 4), new PVector(5, 4), new PVector(6, 4),
    new PVector(0, 5), new PVector(1, 5), new PVector(2, 5), new PVector(3, 5), new PVector(4, 5), new PVector(5, 5), new PVector(6, 5),
    new PVector(1, 6), new PVector(3, 6), new PVector(5, 6)
  };
  Pattern pattern_body_2 = new Pattern(new PVector(0, 0), new PVector(7, 7), body_2, 31, colour);
  
  // Eyes 01
  PVector[] eyes_1 = {
    new PVector(1, 2), new PVector(2, 2), new PVector(4, 2), new PVector(5, 2),
    /*new PVector(1, 3), */new PVector(2, 3), /*new PVector(4, 3), */new PVector(5, 3)
  };
  Pattern pattern_eyes_1 = new Pattern(new PVector(0, 0), new PVector(7, 7), eyes_1, 6, #FFFFFF);
  
  // Eyes 02
  PVector[] eyes_2 = {
    new PVector(1, 2), new PVector(2, 2), new PVector(4, 2), new PVector(5, 2),
    new PVector(1, 3), /*new PVector(2, 3), */new PVector(4, 3)/*, new PVector(5, 3)*/
  };
  Pattern pattern_eyes_2 = new Pattern(new PVector(0, 0), new PVector(7, 7), eyes_2, 6, #FFFFFF);
  
  // Eyes 03
  PVector[] eyes_3 = {
    new PVector(1, 2), /*new PVector(2, 2), new PVector(4, 2), */new PVector(5, 2),
    new PVector(1, 3), new PVector(2, 3), new PVector(4, 3), new PVector(5, 3)
  };
  Pattern pattern_eyes_3 = new Pattern(new PVector(0, 0), new PVector(7, 7), eyes_3, 6, #FFFFFF);
  
  // Eyes 04
  PVector[] eyes_4 = {
    new PVector(1, 2), new PVector(2, 2), new PVector(4, 2), new PVector(5, 2),
    new PVector(1, 3), /*new PVector(2, 3), new PVector(4, 3), */new PVector(5, 3)
  };
  Pattern pattern_eyes_4 = new Pattern(new PVector(0, 0), new PVector(7, 7), eyes_4, 6, #FFFFFF);
  
  
  snapshots[0][0] = pattern_body_1;
  snapshots[0][1] = pattern_eyes_1;
  
  snapshots[1][0] = pattern_body_2;
  snapshots[1][1] = pattern_eyes_1;
  
  snapshots[2][0] = pattern_body_1;
  snapshots[2][1] = pattern_eyes_2;
  
  snapshots[3][0] = pattern_body_2;
  snapshots[3][1] = pattern_eyes_2;
  
  snapshots[4][0] = pattern_body_1;
  snapshots[4][1] = pattern_eyes_3;
  
  snapshots[5][0] = pattern_body_2;
  snapshots[5][1] = pattern_eyes_3;
  
  snapshots[6][0] = pattern_body_1;
  snapshots[6][1] = pattern_eyes_4;
  
  snapshots[7][0] = pattern_body_2;
  snapshots[7][1] = pattern_eyes_4;
  
  
  return new Sprite(sprite_name, position, new PVector(7, 7), snapshots, 8, 2, active_snapshot, auto_animate);
}
