Ball ball;

class Ball {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  
  Ball(){
    location = new PVector(width/2, height);
    velocity = new PVector(0, -3);
    acceleration = new PVector(-.001, .01);
    topspeed = 8;
  }
  
  void update(){
    location.add(velocity);
    // velocity.sub(acceleration);
  }
  
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x,location.y,16,16);
  }

  void checkEdges() {
    if (location.y > height) {
      velocity.y *= -1; 
    } 
     else if (location.y < 0) {
      velocity.y *= -1; 
    }
  }
  
  void applyForce(PVector force){
    acceleration.add(force);
  }
  
}

void setup(){
  size(640,360);
  ball = new Ball();
}

void draw(){
  background(255);
  ball.update();
  ball.checkEdges();
  ball.display();
}
