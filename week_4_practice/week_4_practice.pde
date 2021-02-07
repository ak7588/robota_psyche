Rocket r;

void setup(){
  size(640, 360);
  r = new Rocket();
}

void draw(){
  background(255);
  PVector wind = new PVector(0.02,0.1);
  PVector gravity = new PVector(0, 0.2);
  r.applyForce(wind);
  //r.applyForce(gravity);
  r.update();
  r.edges();
  r.display();
}
