static float grav=0.3;
Player p;
Level l;
int cols, rows, blockSize=30;
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
  p=new Player(new PVector(50, 200));
  levelLayout=readLevel();
  l=new Level(levelLayout);
}

void keyPressed() {
  if (gameState==1) {
    if (key=='a'||key=='A') {
      p.movingLeft=true;
    } else if (key=='d'||key=='D') {
      p.movingRight=true;
    }
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
  int[][] out=new int[cols][rows];
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      if (i%10==0||i%11==0||j<10) out[i][j]=0;
      else out[i][j]=1;
    }
  }
  return out;
}
