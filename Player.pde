class Player {
  PVector pos, vel=new PVector(0, 0), acc=new PVector(0, 0);
  boolean ground, movingLeft, movingRight, slidingLeft, slidingRight, jumping;
  float w=15, h=20;
  float top, bottom, left, right;
  int col, row;


  Player(PVector p) {
    pos=p;
    top=pos.y;
    left=pos.x;
    bottom=pos.y+h;
    right=pos.x+w;
    //println(top, left, bottom, right);
  }

  void show() {
    noStroke();
    fill(255, 0, 0);
    rect(pos.x, pos.y, w, h);
    stroke(0);
    strokeWeight(1);
    line(pos.x+w/2, pos.y+h/2, pos.x+w/2+vel.x, pos.y+h/2+vel.y);
  }

  void update() {
    updateIndexes();
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
    checkIfOnGround();
    checkTopCollision();
    if (!ground&&(slidingLeft||slidingRight)) {
      //println("sliding speed");
      vel.y+=grav*.2;
    } else  if (!ground) {
      vel.y+=grav;
    }
    vel.add(acc);
    vel.x=constrain(vel.x, -10, 10);
    if (ground) vel.mult(.9);
    else vel.mult(.98);
    lateralCollision(l.layout);
    pos.add(vel);

    pos.x=constrain(pos.x, 0, width-w);
    pos.y=constrain(pos.y, 0, height);
    acc.mult(0);
    updateLimits();
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
    p.pos.x=l.playerPos.x;
    p.pos.y=l.playerPos.y;
    acc.mult(0);
    vel.mult(0);
  }

  void checkIfOnGround() {

    //for (int i=row; i<rows; i++) {
      Block b=l.layout[col][row+1];
      if (b.alive&&b.type==1) {
        if (inside(b, 2)) {
          ground=true;
          jumping=false;
          pos.y=b.top-h;
        }
        //} else {
        //  ground=false;
        //}
      
    }
  }

  void lateralCollision(Block[][] array) {

    if (vel.x>0) {//moving to the right
      if (col<cols-1) {
        Block bLow=array[col+1][row];
        Block bUp=array[col+1][row-1];
        if ((bLow.type==1&&bLow.alive)||(bUp.type==1&&bUp.alive)) {
          if (inside(bLow, 1)) {
            pos.x=bLow.left-w;
            vel.x=0;
            if (!ground) {
              slidingRight=true;
            }
          }
          if (inside(bUp, 1)) {
            pos.x=bUp.left-w;
            vel.x=0;
            if (!ground) {
              slidingRight=true;
            }
          } else {
            if (slidingRight) slidingRight=false;
          }
        }
      }
    } else {//moving left
      if (col>1) {
        Block bLow=array[col-1][row];
        Block bUp=array[col-1][row-1];
        if ((bLow.type==1&&bLow.alive)||(bUp.type==1&&bUp.alive)) {
          if (inside(bLow, 3)) {
            pos.x=bLow.right;
            vel.x=0;
            if (!ground) {
              slidingLeft=true;
            }
          }
          if (inside(bUp, 1)) {
            pos.x=bUp.right;
            vel.x=0;
            if (!ground) {
              slidingLeft=true;
            }
          } else {
            if (slidingLeft) slidingLeft=false;
          }
        }
      }
    }
  }

  void checkTopCollision() {
    if (row>1) {
      Block b=l.layout[col][row-1];
      if (b.type==1&&b.alive&&inside(b, 0)) {
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
