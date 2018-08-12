class Effect {
  PVector pos, vel;
  int life, type;//1=portal, 2=comet 3 portal open
  color col;
  int effectTextSize=35;
  float angle;


  Effect(float px, float py, int t) {
    pos=new PVector(px, py);
    type=t;
    if (type==1) {
      col=color(random(255), random(255), random(255));
      vel=setSpeed();
    } else if (type==2) {
      angle=setAngle();
      vel=setSpeed(angle);
    }
  }

  void show() {
    pushStyle();
    if (type==1) {
      stroke(col);
      strokeWeight((int)random(3, 8));
      point(pos.x, pos.y);
    } else if (type==2) {
      pushStyle();
      strokeWeight(map(life, 0, 90, 5, 2));
      //colorMode(HSB, 360, 100, 100);
      stroke(#FAE7A9, map(life, 0, 90, 255, 0));
      point(pos.x, pos.y);

      popStyle();
    } else if (type==3) {
      fill(255);
      textSize(map(life, 0, 135, effectTextSize, 25));
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(radians((-life/10.0)));
      text("The portal has opened!", -life/5, 20);
      popMatrix();
    }

    popStyle();
  }

  void update() {
    if (type==1) {
      life++; 
      vel.y+=grav*.1;
      vel.mult(.96);
      pos.add(vel);
    } else if (type==2) {
      life+=4;
      vel.y+=grav*.5;
      vel.mult(.9);
      pos.add(vel);
    } else if (type==3) {
      life++;
    }
  }

  PVector setSpeed() {
    float angle=random(240, 300);
    return PVector.fromAngle(radians(angle)).setMag(random(1.5, 2.5));
  }

  PVector setSpeed(float a) {
    return PVector.fromAngle(radians(a)).setMag(random(18, 25));
  }

  float setAngle() {
    return pos.x<width/2?(random(190, 200)):random(-20,-10);
  }
}
