static float grav=0.5;
Player p;
Level l;
int cols, rows, blockSize=20;
int[][] levelLayout;
int loopCounter=0;
ArrayList<PVector> stars=new ArrayList<PVector>();
ArrayList<Effect> effects=new ArrayList<Effect>();


int gameState=0, loopCSize=30, levelCount=1, timeToDisappear=4000;
float loopCAngle=-15;


PImage portalGate;
PImage portalBase;
PImage portalTop;  
PImage baseTile;
PImage safePlatform;
PImage spike;
PImage end;
PImage[] playerIdle= new PImage[2];
PImage[] playerRunR= new PImage[4];
PImage[] playerRunL=new PImage[4];
PImage[] playerFall=new PImage[2];



void setup() {
  loadStuff();
  //fullScreen();
  size(1200, 600);
  cols=width/blockSize;
  rows=height/blockSize;
}

void loadStuff() {
  baseTile=loadImage("data/baseTile.png");
  portalGate=loadImage("data/portalGate.png");
  portalBase=loadImage("data/portalBase.png");
  portalTop=loadImage("data/portalTop.png");
  safePlatform=loadImage("data/safe.png");
  end=loadImage("endBase.png");
  for (int i=0; i<playerIdle.length; i++) {
    playerIdle[i]=loadImage("data/idle"+i+".png");
    playerFall[i]=loadImage("data/fall"+i+".png");
  }
  for (int i=0; i<playerRunR.length; i++) {
    playerRunR[i]=loadImage("data/run"+i+".png");
    playerRunL[i]=loadImage("data/run"+i+"L.png");
  }

  populateStars();
}

void populateStars() {
  for (int i=0; i<random(40, 80); i++) {
    stars.add(new PVector(random(width), random(height)));
  }
}


void draw() {
  switch(gameState) {
  case  0:
    menuPage();

    break;
  case 1:
    mainGame();
    break;
  case 2:
    settingsPage();
    break;
  }
}

void gameStart() {
  gameState=1;
  loopCSize=35;
  levelLayout=readLevel(levelCount);
  l=new Level(levelLayout);
  PVector auxPos=new PVector(l.playerPos.x, l.playerPos.y);
  p=new Player(auxPos);
}

void keyPressed() {
  if (gameState==1) {
    if (key=='a'||key=='A') {
      p.movingLeft=true;
    } else if (key=='d'||key=='D') {
      p.movingRight=true;
    }
    if (key=='w'||key=='W') {
      p.jump();
    }
    if (key=='r') {
      resetGame();
    }
  }
  if (key==' ') {
    saveFrame("snapshot###.png");
  }
}


void keyReleased() {
  if (gameState==1) {
    if (key=='a'||key=='A') {
      p.movingLeft=false;
    } else if (key=='d'||key=='D') {
      p.movingRight=false;
    }
  }
}
void mousePressed() {

  if (gameState==1) {
    p.pos.x=mouseX;
    p.pos.y=mouseY;
  }
}

int[][] readLevel(int levelSelector) {
  int[][] out=new int[cols+1][rows];
  switch(levelSelector) {
  case 1:
    for (int i=0; i<cols; i++) {
      for (int j=0; j<rows; j++) {
        if (i<10) {
          if (j>11&&j<14) { //safe zone
            out[i][j]=3;
          } else if (j>13) {
            out[i][j]=1;
          }
        } else if (i<20) {
          if (j>24) {
            out[i][j]=1;
          }
        } else if (i<35) {
          if (j>20) { 
            out[i][j]=1;
          }
        } else if (i<45) {
          if (j>15) { 
            out[i][j]=1;
          }
        } else {
          if (j>10) { 
            out[i][j]=1;
          }
        }
        if (i>55) {
          if (j<12&&j>10) {
            out[i][j]=4;
          }
        }
      }
    }//player start position  
    out[cols][0]=50;
    out[cols][1]=100;
    break;
  case 2 :
    for (int i=0; i<cols; i++) {
      for (int j=0; j<rows; j++) {
        if (i<9) {
          if (j>9) { 
            out[i][j]=3;
          } 
          if (j>12) { 
            out[i][j]=1;
          }
        } else if (i>15&&i<22) {
          if (j>9) { 
            out[i][j]=1;
          }
        } else if (i>28&&i<37) {
          if (j>12) { 
            out[i][j]=1;
          }
        } else if (i>49) {
          if (i>55&&j==19) {
            out[i][j]=4;
          } else if (j>18) { 
            out[i][j]=1;
          }
        }
      }
    }
    out[cols][0]=50;
    out[cols][1]=80;
    break;
  }
  return out;
}

void checkGameOver() {
  if (p.touchBottom()) {
    resetGame();
  }
}

void checkCompleteLevel() {
  //if(p.pos.x
}

void resetGame() {
  loopCSize=35;
  loopCounter=0;
  l.layout=l.setupLevel(levelLayout);
  p.reset();
}

void timer() {
}

void drawStars() {
  for (PVector p : stars) {
    stroke( #FAE7A9);
    strokeWeight(ceil(stars.indexOf(p)/10));
    point(p.x, p.y);
  }
}

void enterPortal(PVector origin) {
  for (int i=0; i<15; i++) {
    float angle=random(240, 300);
    PVector dir=PVector.fromAngle(radians(angle)).setMag(random(1.5, 2.5));
    //println(angle, dir.x, dir.y);
    effects.add(new Effect(origin.x, origin.y, dir.x, dir.y, 1));
  }
}

void loopLevel() {
  loopCSize=35;
  enterPortal(new PVector(p.pos.x, p.pos.y));
  loopCounter++;
  p.reset();
  if (loopCounter>levelCount+2) {
    advanceLevel();
  }
}
void advanceLevel() {
  loopCounter=0;
  levelCount++;
  timeToDisappear-=300;
  levelLayout=readLevel(levelCount);
  l=new Level(levelLayout);
}
