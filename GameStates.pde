void menuPage() {
  pushStyle();
  background(#030146);
   drawStars();
  textSize(25);
  fill(255);
  text("LD 42", 50, 50);
  text("Game made by GRsni", 50, 75);

  fill(200, 200, 0);
  textSize(70);
  textAlign(CENTER, CENTER);
  text("Don't stop!", width/2, 200);

  noStroke();
  fill(100);
  rect(width/2-200, 350, 400, 75);
  fill(0);
  textSize(30);
  text("Start", width/2, 387);
  if (mouseX>width/2-200&&mouseX<width/2+200&&mouseY>350&&mouseY<425) {
    fill(100);
    textSize(15);
    text("Seriously, you shouldn't stop.", width/2, 250);

    if (mousePressed) {
      println("start");
      gameStart();
    }
  }

  popStyle();
}

void mainGame() {

  pushStyle();
  background(#01002D);
  fill(255);
 drawStars();

  pushMatrix();
  translate(20, 50);
  rotate(radians(loopCAngle));
  if (loopCSize>20) { 
    loopCSize--;
  }
  textSize(loopCSize);
  text("Loops: "+loopCounter, 20, 20);
  popMatrix();

  calculateTime();



  //println(l.playerPos.x, l.playerPos.y);
  p.show();
  p.update();
  l.update(p);

  if (random(1)>.995) {
    createShootingStar();
  }
  for (int i=effects.size()-1; i>=0; i--) {
    Effect e= effects.get(i);
    e.show();
    e.update();
    if (e.life>45*e.type) { 
      effects.remove(e);
    }
  }
  l.show();
  checkGameOver();

  popStyle();
}

void introPage(){
  pushStyle();
  background(#030146);
   drawStars();
  //fill(
  popStyle();
  
}


void settingsPage() {
}
