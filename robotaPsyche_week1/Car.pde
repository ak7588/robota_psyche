class Car{
  PVector location;
  PVector velocity;
  float carWidth, carHeight;
  
  Car(float xPos, float yPos) {
    location = new PVector(xPos, yPos);
    velocity = new PVector(2.5, 0);
    carWidth = 100;
    carHeight = 60;
  }
  
  void move(){
    location.add(velocity);
  }
  
  void display(){
    rectMode(CENTER);
    noStroke();
    fill(0);
    rect(location.x, location.y, carWidth, carHeight);
    rect(location.x-carWidth/2, location.y+carHeight/2, carWidth/4, carHeight/4);
    rect(location.x-carWidth/2, location.y-carHeight/2, carWidth/4, carHeight/4);  
    rect(location.x+carWidth/2, location.y+carHeight/2, carWidth/4, carHeight/4);
    rect(location.x+carWidth/2, location.y-carHeight/2, carWidth/4, carHeight/4);
 }
  
  void checkBorders(){
    if (location.x - carWidth > width) {
      location.x = -carWidth;
    }
  } 
}
