class Player {
  PVector pos, vel=new PVector(0, 0), acc=new PVector(0, 0);
  boolean ground, movingLeft, movingRight, slidingLeft, slidingRight, jumping;
  float w=15, h=20;
  float top, bottom, left, right;
  int col, row, fCount;


  Player(float x, float y) {
    pos=new PVector(x, y);
    top=pos.y;
    left=pos.x;
    bottom=pos.y+h;
    right=pos.x+w;
    //println(top, left, bottom, right);
  }

  void show() {

    if (vel.mag()<.1) {
      if (frameCount%15==0) {
        fCount++;
      }
      if (fCount>1) {
        fCount=0;
      }

      image(playerIdle[fCount], left, top);
    } else {
      if (frameCount%5==0) {
        fCount++;
      }
      if (fCount>3) {
        fCount=0;
      }
      if (movingRight||vel.x>0) {//moving to the right
        image(playerRunR[fCount], left, top);
      } else if (movingLeft||vel.x<0) {//moving to the left
        image(playerRunL[fCount], left, top);
      } else if (vel.y>0&&vel.y>abs(vel.x)) {//if falling
        if (fCount>1) fCount=0;
        image(playerFall[fCount], left, top);
      }
    }
  }

  void update() {
    updateIndexes();
    updateLimits();
    //println(slidingLeft, slidingRight);
    PVector moving=new PVector(0, 0);
    if (movingLeft) {
      if (ground) {
        moving=new PVector(-1.5, 0);
      } else {
        moving=new PVector(-.2, 0);
      }
    }
    if (movingRight) {
      if (ground) {
        moving=new PVector(1.5, 0);
      } else {
        moving=new PVector(.2, 0);
      }
    }
    acc.add(moving);
    checkBottomCollision();
    checkTopCollision();
    vel.add(acc);
    if (!ground&&(slidingLeft||slidingRight)) {
      //println("sliding speed");
      vel.y+=grav*.1;
    } else  if (!ground) {
      vel.y+=grav;
    }

    vel.x=constrain(vel.x, -10, 10);
    if (ground) vel.mult(.75);
    else vel.mult(.98);
    lateralCollision(l.layout);
    pos.add(vel);
    pos.x=constrain(pos.x, 0, width-w);
    pos.y=constrain(pos.y, 0, height);
    acc.mult(0);
  }

  void setPos(float x, float y) {
    pos.x=x;
    pos.y=y;
  }


  void updateIndexes() {
    col=(int)(left+right)/2/blockSize;
    row=(int)(top+bottom)/2/blockSize;
  }


  void jump() {
    if (ground) {
      ground=false;
      jumping=true;
      //println("jumping");
      float jumpAmount=vel.mag()/3+10;
      PVector jumpDir=new PVector(0, -jumpAmount);
      vel.add(jumpDir);
      pos.add(vel);
    } else {
      float jumpAmount=15;
      if (slidingLeft) {
        float angle=315;
        PVector jumpDir=PVector.fromAngle(radians(angle)).setMag(jumpAmount);
        vel.add(jumpDir);
        pos.add(vel);
      } else if (slidingRight) {
        float angle=235;
        PVector jumpDir=PVector.fromAngle(radians(angle)).setMag(jumpAmount);
        vel.add(jumpDir);
        pos.add(vel);
      }
    }
  }

  void updateLimits() {
    top=pos.y;
    left=pos.x;
    bottom=pos.y+h;
    right=pos.x+w;
  }

  boolean touchBottom() {
    return bottom>height;
  }

  void reset() {
    setPos(l.startX,l.startY);
    acc.mult(0);
    vel.mult(0);
  }

  void checkBottomCollision() {

    if (row<rows-2) {
      Block b=l.layout[col][row+1];//check the block directly below
      if (b.alive) {
        //println(frameCount+"block below alive", vel.y);
        if (inside(b, 2)) {
          ground=true;
          jumping=false;
          pos.y=b.top-h;
          vel.y=0;
        } else {
          ground=false;
          if (vel.y>0) {
            vel.y*=.6;
          }
        }
      } else {
        ground=false;
      }
      if (vel.y>8) {
        if (l.layout[col][row+2].alive) {
          vel.y*=.6;
        }
      }
    }
  }

  void lateralCollision(Block[][] array) {
    if (col<cols-1&&row<rows-1) {//blocks to the right
      Block bL=array[col+1][row];
      if (bL.alive) {
        if (inside(bL, 1)) {
          slidingRight=true;
          vel.x=0;
          pos.x=bL.left-w-1;
        }
      } else {
        slidingRight=false;
      }
    } 
    if (col>1&&row<rows-1) {//blocks to the left

      Block bL=array[col-1][row];
      if (bL.alive) {
        if (inside(bL, 3)) {
          println("sliding left");
          slidingLeft=true;
          vel.x=0;
          pos.x=bL.right+1;
        }
      } else { 
        slidingLeft=false;
      }
    }
  }

  void checkTopCollision() {
    if (row>1) {
      Block b=l.layout[col][row-1];
      if (b.alive&&inside(b, 0)) {
        vel.y=0;
        pos.y=b.bottom;
      }
    }
  }

  boolean inside(Block b, int dir) {
    if (dir==0) {//block on top
      return top<=b.bottom;
    } else if (dir==1) {//block to the right
      return right>=b.left;
    } else if (dir==2) {//block below
      return bottom>=b.top;
    } else return left<=b.right;//block to the left
  }
}
