class Block {
  PVector pos;
  int col, row, type;//0=air, 1=platform, 2=spikes, 3=safe
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
    if (type==0) alive=false;
  }

  void show() {
    pushStyle();
    rectMode(CORNERS);
    if (alive) {
      if (type==1) {
        
        if (touched) tint(250, 0, 0, 250);
        image(baseTile, left, top);
      } else if (type==2) {
      } else if (type==3) {
        image(safePlatform, left, top);
      } else if (type==4) {
        noStroke();
        fill(#FF7979);
        rect(left, top, right, bottom);
      }
    }
    popStyle();
  }

  void update() {
    if (touched) {
      if (millis()-lastTimeTouched>4500) {
        //type=0;
        alive=false;
      }
    }
  }

  void touched() {
    if (type==1) {
      if (!touched) {
        touched=true;
        lastTimeTouched=millis();
      }
    } else if (type==2) {
      resetGame();
    } else if (type==4) {
      enterPortal(new PVector(p.pos.x, p.pos.y));
      loopCounter++;
      p.reset();
    }
  }
}
