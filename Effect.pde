class Effect {
  PVector pos, vel;
  int life, type;//1=portal, 2=comet
  color col;


  Effect(PVector p, PVector speed, int t) {
    pos=p;
    vel=speed;
    type=t;
    if (type==1) col=color(random(255), random(255), random(255));
  }

  void show() {
    pushStyle();
    if (type==1) {
      stroke(col);
      strokeWeight(6);
      point(pos.x, pos.y);
    }

    popStyle();
  }

  void update() {
    life++; 
    vel.y+=grav*.1;
    vel.mult(.96);
    pos.add(vel);
  }
  void delete() {
  }
}
