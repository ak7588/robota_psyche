// define the mover class
class Mover {
  PVector location = new PVector(0,0);
  PVector velocity;
  PVector acceleration;
  PImage imgMover;
  float maxspeed = 5;
  float maxforce = 0.03;
  
  // default constructor
  Mover(float locX, float locY){
    location.x = locX;
    location.y = locY;
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    imgMover = loadImage("rocket.png");
  }
  
  // display the mover
  void display(){
    stroke(0);
    fill(255,255,0);
    rectMode(CENTER);
    pushMatrix();
      translate(location.x,location.y);
      rotate(velocity.heading()+PI/4);
      image(imgMover, 0,0); 
    popMatrix();
  }
  
  // update mover's acceleration acceleration
  void updateAccel(float accX, float accY){
    acceleration.x = accX;
    acceleration.y = accY;
  }
  
  // update mover's location
  void update(){
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0); 
  }
  
  // update borders
  void checkBorders(){
    if (location.x > width){
      location.x = 0;
    }
    if (location.x < 0){
      location.x = width;
    }
    if (location.y < 0){
      location.y = height;
    }
    if (location.y > height){
      location.y = 0;
    }
  }
  
  void applyForce(PVector force){
    acceleration.add(force);
  }
  
  void followFlow(flowField flow){
    PVector desired = flow.lookup(location);
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
}
