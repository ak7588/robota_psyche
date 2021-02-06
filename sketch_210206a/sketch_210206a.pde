// objects moving in different directions

class Mover {
  PVector location;
  PVector velocity;
  
  Mover(){
    location = new PVector(width/2, height/2);
    velocity = new PVector(0,0);
  }
  
  void display(){
    rect(location.x, location.y, 20, 50);
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
