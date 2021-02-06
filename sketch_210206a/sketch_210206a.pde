// objects moving in different directions

class Mover {
  PVector location;
  PVector velocity;
  
  Mover(){
    location = new PVector(width/2, height/2);
    velocity = new PVector(0,0);
  }
  
  void display(){
    stroke(0);
    fill(255,255,0);
    pushMatrix();
      translate(location.x,location.y);
      rotate(velocity.heading());
      rectMode(CENTER);
      rect(0, 0, 20, 50);
      rect(-10, 25, 20, 12.5);
      rect(-10, -25, 20, 12.5);  
    popMatrix();
  }
  
  void update(float speedX, float speedY){
    velocity.x = speedX;
    velocity.y = speedY;
    location.add(velocity);
  }
  
  void update(){
    location.add(velocity);
  }
  
  void checkBorders(){
    if (location.x > width){
      velocity.x *= -1;
    }
    if (location.x < 0){
      velocity.x *= -1;
    }
    if (location.y < 0){
      velocity.y *= -1;
    }
    if (location.y > height){
      velocity.y *= -1;
    }
  }
}

Mover mover;

void setup(){
  background(255);
  size(680, 470);
  mover = new Mover();
}

void draw(){
  background(255);
  mover.display();
  mover.update();
  mover.checkBorders();
}

void keyPressed(){
  if (keyCode == RIGHT){
    mover.update(3,0);
  }
  if (keyCode == LEFT){
    mover.update(-3,0);
  }
  if (keyCode == UP){
    mover.update(0,-3);
  }
  if (keyCode == DOWN){
    mover.update(0,3);
  }
}
