void CreateSprites() {
  colorMode(HSB, 255);
  for (int i = 0; i < pixel_res.y; i++) {
    for (int j = 0; j < pixel_res.x; j++) {
      background[j][i] = color(random(0, 255), 150, 255);
    }
  }
  colorMode(RGB, 255);
  
  Sprite sprite1 = pacman_sprite("pacman1", new PVector(8, 4), 0, true, #FFFD04);
  
  sprites.put("pacman1", sprite1);
  
  Sprite sprite2 = pacman_sprite("pacman2", new PVector(8, 27), 0, true, #FFFD04);
  
  sprite2.Rotate(1);
  sprites.put("pacman2", sprite2);
  
  Sprite sprite3 = pacman_sprite("pacman3", new PVector(31, 27), 0, true, #FFFD04);
  
  sprite3.Rotate(2);
  sprites.put("pacman3", sprite3);
  
  Sprite sprite4 = pacman_sprite("pacman4", new PVector(31, 4), 0, true, #FFFD04);
  
  sprite4.Rotate(3);
  sprites.put("pacman4", sprite4);
  
  
  
  Sprite sprite5 = pacman_sprite("pacman5", new PVector(31, 35), 0, true, #FFFD04);
  
  sprite5.Flip(false);
  sprites.put("pacman5", sprite5);
  
  Sprite sprite6 = pacman_sprite("pacman6", new PVector(8, 12), 0, true, #FFFD04);
  
  sprite6.Flip(true);
  sprites.put("pacman6", sprite6);
  
  Sprite sprite7 = pacman_sprite("pacman7", new PVector(8, 35), 0, true, #FFFD04);
  
  sprite7.Rotate(1);
  sprite7.Flip(false);
  sprites.put("pacman7", sprite7);
  
  Sprite sprite8 = pacman_sprite("pacman8", new PVector(31, 12), 0, true, #FFFD04);
  
  sprite8.Rotate(1);
  sprite8.Flip(true);
  sprites.put("pacman8", sprite8);
  
  
  sprites.get("pacman1").SetVelocity(-1, 0);
  sprites.get("pacman1").SetScreenBehaviour(3);
  
  sprites.get("pacman2").SetVelocity(0, -1);
  sprites.get("pacman2").SetScreenBehaviour(3);
  
  sprites.get("pacman3").SetVelocity(1, 0);
  sprites.get("pacman3").SetScreenBehaviour(3);
  
  sprites.get("pacman4").SetVelocity(0, 1);
  sprites.get("pacman4").SetScreenBehaviour(3);
  
  sprites.get("pacman5").SetVelocity(1, 0);
  sprites.get("pacman5").SetScreenBehaviour(3);
  
  sprites.get("pacman6").SetVelocity(-1, 0);
  sprites.get("pacman6").SetScreenBehaviour(3);
  
  sprites.get("pacman7").SetVelocity(0, -1);
  sprites.get("pacman7").SetScreenBehaviour(3);
  
  sprites.get("pacman8").SetVelocity(0, 1);
  sprites.get("pacman8").SetScreenBehaviour(3);
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
