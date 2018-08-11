static float grav=0.5;
Player p;
Level l;
int cols, rows, blockSize=20;
int[][] levelLayout;
//int[][] level={0, 0, 0, 0, 0, 0 , 


int gameState=0;

//PFont menus=loadFont()


void setup() {
  //fullScreen();
  size(1200, 600);
  cols=width/blockSize;
  rows=height/blockSize;
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
  levelLayout=readLevel();
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


int[][] readLevel() {
  int[][] out=new int[cols+1][rows];
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      //if (j<15||((cols-i)<10&&j<10)) out[i][j]=0;
      //else out[i][j]=1;
      //out[i][j]=1;
      if (i<10&&j>10) out[i][j]=1;
      else if (i>50&&j>10) out[i][j]=1;
      else if (j>20) out[i][j]=1;
      else out[i][j]=0;
    }
  }//player start position
  //println(out[cols/2][25].aliv
  out[cols][0]=600;
  out[cols][1]=100;
  return out;
}

void checkGameOver() {
  if (p.touchBottom()) {
    //println(l.playerPos.x, l.playerPos.y);

    resetGame();
  }
}

void resetGame() {

  l.layout=l.setupLevel(levelLayout);
  p.reset();
}
