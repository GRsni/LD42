class Block {
  PVector pos;
  int col, row, type;//0=air, 1=platform, 2=spikes, 3=safe, 4=end, 5=static
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
        image(spike, left, top);
      } else if (type==3) {
        image(safePlatform, left, top);
      } else if (type==4) {
        if (cols-col==4) {
          image(end, left, top);
        }
        if (col==cols-1) {
          image(portalBase, left, top);
          for (int i=0; i<loopCounter; i++) {
            image(portalGate, left, top-(i+1)*20);
          }
          image(portalTop, left, top-4*20);
        }
        //noStroke();
        //fill(#FF7979);
        //rect(left, top, right, bottom);
      }else if(type==5){
        image(staticB, left, top);  
      }
      
    }
    popStyle();
  }

  void update() {
    if (touched) {
      if (millis()-lastTimeTouched>timeToDisappear) {
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
      hit.play(0);
      resetGame();
    } else if (type==4) {
      portal.play(0);
      loopLevel();
    }
  }
}
