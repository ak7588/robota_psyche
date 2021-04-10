class Ant {
  int numOfAntTypes = 2;
  PImage[] ants;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxforce;
  float maxspeed;
  boolean alive;
  boolean isRed;
  final float tooClose = 25;

  Ant(float x, float y, float vx, float vy) {
    location = new PVector(x, y);
    acceleration = new PVector(0, 0);
    velocity = new PVector(vx, vy);
    maxforce = 1;
    maxspeed = 4;
    alive = true;

    ants = new PImage[numOfAntTypes];
    for (int i = 0; i < numOfAntTypes; i++) {
      ants[i] = loadImage(int(i)+".png");
    }

    if (round(random(1)) == 1) {
      isRed =  true;
    } else {
      isRed = false;
    }
  }

  float distanceTo(PVector l) {
    return PVector.sub(l, location).mag();
  }

  void checkBorders() {
    if (location.x > width) {
      velocity.x *= -1;
    }
    if (location.x < 0) {
      velocity.x *= -1;
    }
    if (location.y < 0) {
      velocity.y *= -1;
    }
    if (location.y > height) {
      velocity.y *= -1;
    }
  }

  void follow(FlowField flow) {
    // Look up the vector at that spot in the flow field
    PVector desired = flow.lookup(location);
    desired.mult(maxspeed);

    // Steering is desired minus velocity
    PVector steer = PVector.sub(desired, velocity);
    applyForce(applyLimits(steer));
  }

  void avoidAggressive(ArrayList<Ant> ants) {
    int count = 0; // how
    PVector sum = new PVector(0, 0);
    for (Ant other : ants) {
      float d = PVector.dist(location, other.location);
      if (d == 0) {
        continue;
      }
      if (d > tooClose) {
        continue;
      }
      boolean otherIsAggressive = other.getIsAggressive();
      if (otherIsAggressive) {
        PVector diff = PVector.sub(location, other.location); // in book, but  wrong way?
        diff.normalize(); 
        diff.div(d); 
        sum.add(diff);
        count++;
      }
    }
    if (count > 0) { 
      sum.div(count); 
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      applyForce(applyLimits(steer));
    }
  }

  void avoidRedAnts(ArrayList<Ant> ants) {
    PVector steer = new PVector(0, 0);
    float desiredSep = 50;
    int count = 0;
    PVector sum = new PVector(0, 0);
    for (Ant other : ants) {
      // distance between current and other
      float thisDist = PVector.dist(location, other.location);
      if (other.getIsRed()) {
        if ((thisDist > 0) && (thisDist < desiredSep)) {
          PVector diff = PVector.sub(location, other.location);
          diff.normalize();
          sum.add(diff);
          count++;
        }
      }
    }
    if (count>0) {
      sum.div(count);
      sum.setMag(maxspeed);
      steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
    }
    applyForce(steer);
  }

  PVector applyLimits(PVector desiredVelocity) {
    desiredVelocity.normalize();
    desiredVelocity.mult(maxspeed);
    PVector steerForce = PVector.sub(desiredVelocity, velocity);
    steerForce.limit(maxforce);
    return(steerForce);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0); // clear the acceleration for the next frame
  }

  void display() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(velocity.heading()+PI/4);
    if (isRed) {
      image(ants[0], 0, 0, ants[0].width/2, ants[0].height/2);
    } else {
      image(ants[1], 0, 0, ants[1].width/2, ants[1].height/2);
    }
    popMatrix();
  }

  void setLocation(PVector _location) {
    location = _location;
  }

  boolean getIsRed() {
    return (isRed);
  }

  boolean getIsAggressive() {
    float chance = random(100);

    if (isRed) {
      return (chance > 20);
    } else {
      return(chance > 80);
    }
  }
}
