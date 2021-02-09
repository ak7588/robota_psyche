// define the mover class
class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  PImage imgMover;
  
  // default constructor
  Mover(){
    location = new PVector(width/2, height/2);
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
    location.add(velocity);
    velocity.add(acceleration);
    acceleration.mult(0);
    velocity.limit(5);
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
}
