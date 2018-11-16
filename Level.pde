class Level {
  Block[][] layout=new Block[cols][rows];
  float startX, startY;

  Level(int[][] levelArray) {
    layout=setupLevel(levelArray);
    startX=levelArray[0][rows];
    startY=levelArray[1][rows];
  }

  void show() {
    for (int i=0; i<cols; i++) {
      for (int j=0; j<rows; j++) {
        layout[i][j].update();
        layout[i][j].show();
      }
    }
  }
  
  void update(Player p) {
    playerTouch(p);
  }

  Block[][] setupLevel(int[][] array) {
    Block[][] out=new Block[cols][rows];
    for (int i=0; i<cols; i++) {
      for (int j=0; j<rows; j++) {
        out[i][j]=new Block(i, j, array[i][j]);
      }
    }
    return out;
  }


  void playerTouch(Player p) {
    if (p.row<rows-1) {//check block below
      Block b=layout[p.col][p.row+1];
      if (p.inside(b, 2)) {
        b.touched();
      }
    }
    if (p.col<cols-1) {
      if (p.row>1&&p.row<rows-1) {
        Block bL=layout[p.col+1][p.row];
        if (bL.type!=4) {
          if (p.inside(bL, 1)) {
            bL.touched();
          }
        }
      }
    }
    if (p.col>1) {
      if (p.row>1&&p.row<rows-1) {
        Block bL=layout[p.col-1][p.row];
        if (bL.type!=4) {
          if (p.inside(bL, 3)) {
            bL.touched();
          }
        }
      }
    }
  }
}
