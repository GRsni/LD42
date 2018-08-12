class Effect {
  PVector pos, vel;
  int life, type;//1=portal, 2=comet
  color col;


  Effect(float px, float py, float sx, float sy, int t) {
    pos=new PVector(px, py);
    vel=new PVector(sx, sy);
    type=t;
    if (type==1) col=color(random(255), random(255), random(255));
  }

  void show() {
    pushStyle();
    if (type==1) {
      stroke(col);
      strokeWeight((int)random(3,8));
      point(pos.x, pos.y);
    }

    popStyle();
  }

  void update() {
    if (type==1) {
      life++; 
      vel.y+=grav*.1;
      vel.mult(.96);
      pos.add(vel);
    }
  }
  void delete() {
  }
}
