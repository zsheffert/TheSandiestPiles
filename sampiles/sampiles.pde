int [][] sandpiles;
ArrayList<Integer> unstableTiles = new ArrayList<Integer>();
ArrayList<Integer> unstableTilesNext = new ArrayList<Integer>();

void setup() {
  size(1200, 1200, P2D);
  sandpiles = new int[width][height];
  sandpiles[width/2][height/2] = 300;
  unstableTiles.add(width/2);
  unstableTiles.add(height/2);
}

void draw() {
  render();
}

void topple(int x, int y) {
  if(sandpiles[x][y] >= 4) {
     sandpiles[x][y] = sandpiles[x][y] - 4;
  }
   
      for(int i = -1; i < 2; i += 2) {
        if(sandpiles[x][y] >= 4) {
          
          sandpiles[x][y-i] = (sandpiles[x][y-i] + 1);
          sandpiles[x-i][y] = (sandpiles[x-i][y] + 1);
          if(sandpiles[x][y-i] >= 4) {
            unstableTilesNext.add(x);
            unstableTilesNext.add(y-i);
          }
          if(sandpiles[x-i][y] >= 4) {
            unstableTilesNext.add(x-i);
            unstableTilesNext.add(y);
          }
        }
      }
    if(sandpiles[x][y] >= 4) {
            unstableTilesNext.add(x);
            unstableTilesNext.add(y);
    }
}

void toppleAll() {
  for(int i = 0; i < unstableTiles.size()/2; i ++) {
    topple(unstableTiles.get(i*2), unstableTiles.get(i*2+1));
  }
  
  int x = unstableTiles.size();

    unstableTiles = new ArrayList<Integer>();
  
  for(Integer i: unstableTilesNext) {
    System.out.println("oof" + i);
    unstableTiles.add(i);
    
  }
  
  
  
}

void render() {
  loadPixels();
  toppleAll();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int num = sandpiles[x][y];
      if(num < 0) {
        System.out.println("OUCH");
      }
      color col = color(0, 0, 0);

      switch(num) {
      case 0:
        col = color(255, 255, 0);
        break;
      case 1:
        col = color(0, 185, 63);
        break;
      case 2:
        col = color(0, 104, 255);
        break;
      case 3:
        col = color(122, 0, 229);
        break;
      }

      pixels[x+y*width] = col;
    }
  }
  updatePixels();
}
