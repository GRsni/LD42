class Level {
  Block[][] layout=new Block[cols][rows];

  Level(int[][] levelArray) {
    layout=setupLevel(levelArray);
  }

  void show() {
    for (int i=0; i<cols; i++) {
      for (int j=0; j<rows; j++) {

        layout[i][j].show();
      }
    }
  }

  Block[][] setupLevel(int[][] array) {
    Block[][] out=new Block[cols][rows];
    for (int i=0; i<cols; i++) {
      for (int j=0; j<rows; j++) {
        if (array[i][j]==1) { 
          out[i][j]=new Block(i, j, 1);
        }else out[i][j]=new Block(i, j, 0);
      }
    }
    return out;
  }
}
