static float grav=0.5;
Player p;
Level l;
int cols, rows, blockSize=20;
int[][] levelLayout;
int loopCounter=0;
ArrayList<PVector> stars=new ArrayList<PVector>();
ArrayList<Effect> effects=new ArrayList<Effect>();


int gameState=0, loopCSize=30, levelCount=3, timeToDisappear=4000;
float loopCAngle=-15, mill;
int seconds, minutes, timerStart;


PImage portalGate;
PImage portalBase;
PImage portalTop;  
PImage baseTile;
PImage safePlatform;
PImage spike;
PImage end;
PImage staticB;
PImage[] playerIdle= new PImage[2];
PImage[] playerRunR= new PImage[4];
PImage[] playerRunL=new PImage[4];
PImage[] playerFall=new PImage[2];

PFont main;


void setup() {
  loadStuff();
  //fullScreen();
  size(1200, 600);
  cols=width/blockSize;
  rows=height/blockSize;
  //frameRate(15);
}

void loadStuff() {
  baseTile=loadImage("data/baseTile.png");
  portalGate=loadImage("data/portalGate.png");
  portalBase=loadImage("data/portalBase.png");
  portalTop=loadImage("data/portalTop.png");
  safePlatform=loadImage("data/safe.png");
  spike=loadImage("data/spike.png");
  staticB=loadImage("data/static.png");
  end=loadImage("endBase.png");
  main=loadFont("Power_Red_and_Green-50.vlw");
  textFont(main, 50);

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
  p=new Player(l.startX, l.startY);
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
  int[][] out=new int[cols][rows+1];
  String[] file=loadStrings("level"+levelSelector+".txt");
  for (int i=0; i<rows; i++) {
    char[] indexes=file[i].toCharArray();
    for (int j=0; j<indexes.length; j++) {
      out[j][i]=indexes[j]-48;
    }
  }
  String[] startPos=file[rows].split(" ");
  out[0][rows]=Integer.parseInt(startPos[0]);
  out[1][rows]=Integer.parseInt(startPos[1]);
  return out;
}

void checkGameOver() {
  if (p.touchBottom()) {
    resetGame();
  }
}


void resetGame() {
  loopCSize=35;
  loopCounter=0;
  l.layout=l.setupLevel(levelLayout);
  mill=0;
  seconds=0;
  minutes=0;
  p.reset();
}

void calculateTime() {

  mill+=1000/frameRate;
  if (mill>999) {
    seconds++;
    mill=0;
  }
  if (seconds>59) {
    seconds=0;
    minutes++;
  }
  showTimer();
}

void showTimer() {
  pushMatrix();
  pushStyle();
  fill(255);
  translate(width-150, 50);
  rotate(radians(10));
  textSize(loopCSize+10);
  text(minutes+":"+seconds+"."+(int)mill, 0, 0);
  popStyle();
  popMatrix();
}

void drawStars() {
  for (PVector p : stars) {
    stroke( #FAE7A9);
    int offSet=0;
    if (random(1)>.95) offSet=2;
    else offSet=0;
    strokeWeight(ceil(stars.indexOf(p)/10)+offSet);
    point(p.x, p.y);
  }
}

void enterPortal(PVector origin) {
  for (int i=0; i<15; i++) {
    effects.add(new Effect(origin.x, origin.y, 1));
  }
}

void loopLevel() {
  loopCSize=35;
  enterPortal(new PVector(p.pos.x, p.pos.y));
  loopCounter++;
  if (loopCounter==3) {
    effects.add(new Effect(width-300, p.pos.y-75, 3));
  }
  p.reset();

  if (loopCounter>3) {
    advanceLevel();
  }
}
void advanceLevel() {
  loopCounter=0;
  levelCount++;
  mill=0;
  seconds=0;
  minutes=0;
  timeToDisappear-=300;
  levelLayout=readLevel(levelCount);
  l=new Level(levelLayout);
  p.reset();
}

void createShootingStar() {
  float x=random(300, width-300);
  float y=random(50, 200);
  effects.add(new Effect(x, y, 2));
}
