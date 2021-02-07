class Rocket {
  PVector loc;
  PVector vel;
  PVector acc;
  
  Rocket(){
    loc = new PVector(width/2, height/2);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
  }
  
  void update(){
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
    vel.limit(5);
  }
  
  void applyForce(PVector f){
    acc.add(f);
  }
  
  void edges(){
    if (loc.x > width || loc.x < 0){
      vel.x *= -1;
    }
    if (loc.y > height || loc.y < 0){
      vel.y *= -1;
    }
  }
  
  void display(){
    ellipse(loc.x, loc.y, 25, 25);
  }
}
