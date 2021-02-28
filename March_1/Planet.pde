class Planet {
  int numPlanets = 3;
  PImage[] planet;
  PVector location;
  float size;
  int imageIndex;

  Planet() {
    planet = new PImage[numPlanets];
    for (int i = 0; i < numPlanets; i++) {
      planet[i] = loadImage("planet"+int(i)+".png");
    } 
    location = new PVector(random(100, width-100), random(100, height-200));
    imageIndex = int(random(numPlanets));
    size = random(50, 150);
  }

  void display() {
    imageMode(CENTER);
    image(planet[imageIndex], location.x, location.y, size, size);
  }

  PVector getLocation() {
    return location.copy();
  }
}
