class Block {
  PVector pos;
  int col, row, type;
  float top, bottom, left, right;
  boolean touched, alive, safe;
  int lastTimeTouched;

  Block(int I, int J, int t) {
    col=I;
    row=J;
    pos=new PVector(col*blockSize, row*blockSize);
    top=pos.y;
    bottom=pos.y+blockSize;
    left=pos.x; 
    right=pos.x+blockSize;
    type=t;
  }

  void show() {
    if (type==1) {
      pushStyle();
      stroke(255);
      strokeWeight(2);
      fill(0);
      rectMode(CORNERS);
      rect(left, top, right, bottom);
      popStyle();
    }
  }

  void update(Player p) {
    //if(p.ground&&p.pos.y+
  }

  void setType() {
  }
}
