class Cat {
  int numCats = 5;
  PImage[] cats;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxforce;
  float maxspeed;
  boolean alive;
  boolean isRed;
  int catIndex;
  final float tooClose = 25;

  Cat(float x, float y, float vx, float vy) {

    location = new PVector(x, y);
    acceleration = new PVector(0, 0);
    velocity = new PVector(vx, vy);
    maxforce = 1;
    maxspeed = 4;
    alive = true;

    cats = new PImage[numCats];

    for (int i = 0; i < numCats; i++) {
      cats[i] = loadImage(int(i)+1+".png");
    }

    if (round(random(1)) == 1) {
      isRed =  true;
    } else {
      isRed = false;
    }

    catIndex = int(random(1, 5));
  }

  float distanceTo(PVector l) {
    return PVector.sub(l, location).mag();
  }

  void checkBorders() {
    if (location.x + cats[0].width / 2 > width) {
      velocity.x *= -1;
    }
    if (location.x - cats[0].width / 2 < 0) {
      velocity.x *= -1;
    }
    if (location.y - cats[0].height / 2 < 0) {
      velocity.y *= -1;
    }
    if (location.y + cats[0].height / 2 > height) {
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

  void avoidAggressive(ArrayList<Cat> cats) {
    int count = 0; // how
    PVector sum = new PVector(0, 0);
    for (Cat other : cats) {
      float d = PVector.dist(location, other.location);
      if (d == 0) {
        continue;
      }
      if (d > tooClose) {
        continue;
      }
      boolean otherIsAggressive = other.getIsAggressive();
      if (otherIsAggressive) {
        if (other.getIsRed()) {
          redThatAreAlsoAggressive++;
        }
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

  void avoidRedCats(ArrayList<Cat> cats) {
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Cat other : cats) {
      float d = PVector.dist(location, other.location);
      if (d == 0) {
        continue;
      }
      if (d > tooClose) {
        continue;
      }
      boolean otherIsRed = other.getIsRed();
      if (otherIsRed) {
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

  void separate(ArrayList<Cat> cats, int difficulty) {
    println("----");
    println("Difficulty: ", difficulty);
    println("----");
    PVector steer = new PVector(0, 0);
    int desiredSep = difficulty; // separation in pixels
    int count = 0;
    PVector sum = new PVector(0, 0);
    for (Cat other : cats) {
      // distance between current and other
      float thisDist = PVector.dist(location, other.location);

      if ((thisDist > 0) && (thisDist < desiredSep)) {
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        sum.add(diff);
        count++;
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

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0); // clear the acceleration for the next frame
  }

  void display() {
    pushMatrix();
    translate(location.x, location.y);
    if (isRed) {
      image(cats[0], 0, 0, cats[0].width/2, cats[0].height/2);
    } else {
      image(cats[catIndex], 0, 0, cats[1].width/2, cats[1].height/2);
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

  boolean checkCollision() {
    if (mouseX >= location.x && mouseX <= location.x + cats[catIndex].width && 
      mouseY >= location.y && mouseY <= location.y + cats[catIndex].height) {
      return true;
    }
    return false;
  }
}
