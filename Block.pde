class Block {
  PVector pos;
  int col, row, type;//0=air, 1=platform, 2=spikes, 3=safe, 4=end, 5=static, 6=first point of portal
  float top, bottom, left, right;
  boolean touched, alive=true, safe, spawning;
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

    if (type==1) {
      if (alive) {
        if (touched) tint(250, 0, 0, 250);
        image(baseTile, left, top);
      }
    } else if (type==2) {
      image(spike, left, top);
    } else if (type==3) {
      image(safePlatform, left, top);
    } else if (type==5) {
      image(staticB, left, top);
    } else if (type==6) {
      displayPortal();
    }

    popStyle();
  }

  void displayPortal() {
    displayRay(left+blockSize*3, top);
    image(end, left, top);
    image(portalBase, left+blockSize*3, top);
    image(portalTop, left+blockSize*3, top-blockSize*4);
  }
  
  void displayRay(float leftPos, float topPos){
    float rayHeight=map(loopCounter, 0, 3, 0, blockSize*3);
    float displayPos=map(loopCounter, 0, 3, topPos-blockSize*1.5, topPos-3*blockSize);
    image(portalGate, leftPos, displayPos, blockSize, rayHeight);
    
  }

  void update() {
    if (touched) {
      if (millis()-lastTimeTouched>timeForBlocksToDisappear) {
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
    } else if (type==4||type==6) {
      portal.play(0);
      loopLevel();
    }
  }
}
