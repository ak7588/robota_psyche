// This DNA class is based on randomness in its entirety.
// I wonder if there can be rockets that can
// "inherit" their DNA's from parent rockets?

int numRockets = 4;

class DNA {
  float mass;
  float maxspeed;
  float maxforce;
  PImage[] rockets;
  int behaviorType;
  float fuel;

  // DNA constructor
  DNA() {
    rockets = new PImage[numRockets];
    for (int i = 0; i < numRockets; i++) {
      rockets[i] = loadImage("rocket"+int(i+1)+".png");
    }
  }

  // what is individual image?
  PImage getRocketImg() {
    return rockets[int(random(4))];
  }

  // what is individual mass?
  float getMass() {
    mass = random(1, 7);
    return mass;
  }

  // what is individual maximum speed?
  float getMaxSpeed() {
    maxspeed = random(0.5, 5);
    return maxspeed;
  }

  // what is individual maximum force?
  float getMaxForce() {
    maxforce = random(0.01, 0.6);
    return maxforce;
  }

  // what is the fuel of each rocket?
  float getFuel() {
    return random(50, 100);
  }

  // what is the behavior of the rocket?
  int getBehavior() {
    return int(random(1, 4));
  }
}
