class Player {
  PVector pos, vel=new PVector(0, 0), acc=new PVector(0, 0);
  boolean ground=true, movingLeft, movingRight;
  float w=15, h=40;


  Player(PVector p) {
    pos=p;
  }

  void show() {
    noStroke();
    fill(255, 0, 0);
    rect(pos.x, pos.y, w, h);
  }

  void update() {
    if (movingLeft) {
      acc=new PVector(-1.5, 0);
    }
    if (movingRight) {
      acc=new PVector(1.5, 0);
    }
    checkIfOnGround();
    if (!ground) {
      acc.y+=grav;
    }
      vel.add(acc);
    vel.limit(10);
    vel.mult(.95);
    pos.add(vel);
    pos.x=constrain(pos.x, 0, width);
    pos.y=constrain(pos.y, 0, height);
    acc.mult(0);
    //if(ground){ 
    //}
  }

  void jump() {
    //PVector jumpDir=new PVector(
  }

  void checkIfOnGround() {
    int playerCol=(int)pos.x/blockSize;
    int playerRow=(int)pos.y/blockSize;
    Block below=null;
    for (int i=playerRow; i<rows; i++) {
      if (l.layout[playerCol][i].type!=0) { 
        below= l.layout[playerCol][i];
        break;
      }
      if(i==rows-1){
       below=new Block(playerCol, rows+1, 1); 
      }
    }
    if (p.pos.y+p.h<below.top-5||below==null) {
      ground=false;
    } else {
      ground=true;
    }
    println(playerCol, playerRow, mouseX/blockSize, mouseY/blockSize);
  }
}
