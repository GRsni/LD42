static float grav=0.5;
Player p;
Level l;
int cols, rows, blockSize=20;
int[][] levelLayout;
int loopCounter=0;
ArrayList<PVector> stars=new ArrayList<PVector>();
ArrayList<Effect> effects=new ArrayList<Effect>();


int gameState=0;


PImage portalGate;
PImage portalBase;
PImage baseTile;
PImage safePlatform;
PImage spike;
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
  safePlatform=loadImage("data/safe.png");
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
  //if (frameCount%2==0) {
  //  saveFrame("snaps/gif#####.png");
  //}
}

void gameStart() {
  gameState=1;
  levelLayout=readLevel(1);
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


int[][] readLevel(int levelSelector) {
  int[][] out=new int[cols+1][rows];
  if (levelSelector==1) {
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
  } else if (levelSelector==2) {
    for (int i=0; i<cols; i++) {
      for (int j=0; j<rows; j++) {
      }
    }
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
  for (int i=0; i<ceil(random(10, 15)); i++) {
    PVector dir=PVector.random2D().setMag(10);
    effects.add(new Effect(origin, dir, 1));
  }
}
