void CreateSprites() {
  colorMode(HSB, 255);
  for (int i = 0; i < pixel_res.y; i++) {
    for (int j = 0; j < pixel_res.x; j++) {
      background[j][i] = color(random(0, 255), 150, 255);
    }
  }
  colorMode(RGB, 255);
  
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
  Pattern pattern1 = new Pattern(new PVector(0, 0), active_pixels1, 36, #FFFD04);
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
  Pattern pattern2 = new Pattern(new PVector(0, 0), active_pixels2, 29, #FFFD04);
  snapshots[1][0] = pattern2;
  
  sprites = new Sprite[1]; sprite_count = 1;
  sprites[0] = new Sprite(new PVector(20, 15), new PVector(7, 7), snapshots, 2, 1, 0, true);
}
