void menuPage() {
  pushStyle();
  background(#030146);
  textSize(25);
  fill(255);
  text("LD 42", 50, 50);

  fill(200, 200, 0);
  textSize(60);
  textAlign(CENTER, CENTER);
  text("Don't stop!", width/2, 200);

  noStroke();
  fill(100);
  rect(width/2-200, 350, 400, 75);
  fill(0);
  textSize(20);
  text("Start game", width/2, 387);
  if (mouseX>width/2-200&&mouseX<width/2+200&&mouseY>350&&mouseY<425&&mousePressed) {
    println("start");
    gameStart();
  }

  popStyle();
}

void mainGame() {
  pushStyle();
  background(#030146);
  //println(l.playerPos.x, l.playerPos.y);
  p.show();
  p.update();
  l.update(p);
  l.show();
  checkGameOver();

  popStyle();
}


void settingsPage() {
}
