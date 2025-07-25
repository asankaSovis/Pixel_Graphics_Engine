void CreateSprites() {
  colorMode(HSB, 255);
  for (int i = 0; i < pixel_res.y; i++) {
    for (int j = 0; j < pixel_res.x; j++) {
      background[j][i] = color(random(0, 255), 150, 255);
    }
  }
  
  for (int i = 0; i < 5; i++) {
    sprites.put("ball" + i, return_ball(i));
  }
}

Sprite return_ball(int i) {
  PVector[] active_pixels = {
    new PVector(0, 0), new PVector(1, 0), new PVector(2, 0),
    new PVector(0, 1), new PVector(1, 1), new PVector(2, 1),
    new PVector(0, 2), new PVector(1, 2), new PVector(2, 2)
  };
  Pattern[][] pattern = {new Pattern[1]};
  pattern[0][0] = new Pattern(new PVector(0, 0), new PVector(3, 3), active_pixels, 9, color(random(0, 255), 255, 255));
  Sprite sprite = new Sprite("ball" + i, new PVector(random(0, pixel_res.x), random(0, pixel_res.y)), new PVector(3, 3), 
    pattern, 1, 1, 0, true, 1);
  if (random(0, 2) == 1) {
    sprite.SetVelocity(-1, -1);
  } else {
    sprite.SetVelocity(1, 1);
  }
  sprite.SetScreenBehaviour(2);
  return sprite;
}

/*Sprite return_ball(int i) {
  PVector[] active_pixels = {
    new PVector(1, 0),
    new PVector(0, 1), new PVector(1, 1), new PVector(2, 1),
    new PVector(1, 2)
  };
  Pattern[][] pattern = {new Pattern[1]};
  pattern[0][0] = new Pattern(new PVector(0, 0), new PVector(3, 3), active_pixels, 5, color(random(0, 255), 255, 255));
  Sprite sprite = new Sprite("ball" + i, new PVector(10 + (i * 5), 10), new PVector(3, 3), 
    pattern, 1, 1, 0, true, 1);
  if (i == 1) {
    sprite.SetVelocity(-1, 0);
  } else {
    sprite.SetVelocity(1, 0);
  }
  sprite.SetScreenBehaviour(2);
  return sprite;
}*/
