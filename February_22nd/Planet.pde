class Planet {
  PImage planet;
  PVector location;
  float sizeX = 80;
  float sizeY = 80;
  
  Planet() {
    planet = loadImage("planet.png");
    location = new PVector(random(100, width-100), random(100, height-200));
  }
  
  void display() {
    imageMode(CENTER);
    image(planet, location.x, location.y, sizeX, sizeY);
  }
  
  PVector getLocation() {
    return location.copy();
  }
}
