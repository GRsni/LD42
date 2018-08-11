class Block {
  PVector pos;
  int col, row, type;//0=air, 1=platform, 2=spikes, 3=...
  float top, bottom, left, right;
  boolean touched, alive=true, safe;
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
    if (alive) {
      if (type==1) {
        pushStyle();
        stroke(255);
        strokeWeight(2);
        fill(0);
        if (touched) fill(0, 255, 0);
        rectMode(CORNERS);
        rect(left, top, right, bottom);
        popStyle();
      } else if (type==2) {
      }
    }
  }

  void update() {
    if (touched) {
      if (millis()-lastTimeTouched>3000) {
        //type=0;
        alive=false;
      }
    }
  }

  void touched() {
    if (!touched) {
      touched=true;
      lastTimeTouched=millis();
    }
  }
}
