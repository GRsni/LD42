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
  text("Don't stop\nrunning!", width/2, 200);

  noStroke();
  fill(100);
  rect(width/2-200, 350, 400, 75);
  fill(0);
  textSize(30);
  text("Start", width/2, 387);
  if (mouseX>width/2-200&&mouseX<width/2+200&&mouseY>350&&mouseY<425) {
    fill(100);
    textSize(15);
    text("Seriously, you shouldn't stop.", width/2, 450);

    if (mousePressed) {
      if (firstScreen) {
        println("start");
        gameStart();
      } else {
        firstScreen=true;
        gameState=3;
      }
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

void introPage() {
  pushStyle();
  background(#030146);
  drawStars();
  fill(255);
  textSize(30);
  text("Hey, listen!\nYou've escaped from the nearly-impossible-to-escape space jail, but your only way out is through a series of portals. "+
    "Move with A and D, and jump with W or the spacebar. Good luck and don't stop running.\n"+
    "Click anywhere to begin your journey.", 250, 150, 700, 400);
  popStyle();
}


void endGame() {
  pushStyle();
  background(#030146);
  drawStars();
  fill(#FFEE2C);
  textSize(45);
  textAlign(CENTER, CENTER);
  text("Congratulations!\nYou managed to escape!\nBut can you do it faster?", width/2, 150);
  textSize(30);
  text("Your times:", width/2, 350);
  stroke(#FFEE2C);
  strokeWeight(4);
  line(500, 375, 700, 375);
  for (int i=0; i<4; i++) {
    text(time[i][0]+":"+time[i][1]+"."+time[i][2], width/2, 400+i*50);
  }
  noStroke();
  fill(100);
  rect(900, 450, 200, 75);
  fill(255);
  textSize(30);
  text("Retry", 1000, 487);
  if (mouseX>900&&mouseX<1100&&mouseY>450&&mouseY<525) {
    textSize(20);
    text("Hint: Press r to reset faster", 1000, 500);
    if (mousePressed) {
      levelCount=1;
      resetGame();
      gameStart();
    }
  }
  popStyle();
}
