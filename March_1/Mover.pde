// define the mover class
class Mover {
  PVector location = new PVector(0, 0);
  PVector velocity;
  PVector acceleration;
  PImage imgMover;
  float maxspeed;
  float maxforce;
  float mass;
  int behavior;
  float fuel;

  // default constructor
  Mover(float locX, float locY, DNA dna) {
    location.x = locX;
    location.y = locY;
    velocity = new PVector(random(0.1, 0.5), random(0.1, 0.5));
    acceleration = new PVector(0, 0);

    // individual information from the DNA:
    imgMover = dna.getRocketImg();
    maxspeed = dna.getMaxSpeed();
    maxforce = dna.getMaxForce();
    mass = dna.getMass();
    behavior = dna.getBehavior();
    fuel = dna.getFuel();
    println(behavior);
    println(fuel);
  }

  // display the mover
  void display() {
    stroke(0);
    fill(255, 255, 0);
    rectMode(CENTER);
    pushMatrix();
    translate(location.x, location.y);
    rotate(velocity.heading()+PI/4);
    image(imgMover, 0, 0, imgMover.width/2, imgMover.height/2); 
    popMatrix();
  }

  // update mover's acceleration acceleration
  void updateAccel(float accX, float accY) {
    acceleration.x = accX;
    acceleration.y = accY;
  }

  // update mover's location
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  // update borders
  void checkBorders() {
    if (location.x > width) {
      //location.x = 0;
      velocity.x *= -1;
    }
    if (location.x < 0) {
      //location.x = width;
      velocity.x *= -1;
    }
    if (location.y < 0) {
      //location.y = height;
      velocity.y *= -1;
    }
    if (location.y > height) {
      //location.y = 0;
      velocity.y *= -1;
    }
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void applyBehaviors(ArrayList<Mover> movers) {
    PVector separate = separate(movers);
    PVector seek = seek(planet.getLocation());
    PVector arrive = arrive(planet.getLocation());
    // apply behaviors according to the dna
    if (behavior == 1)
      applyForce(separate);
    if (behavior == 2)
      applyForce(seek);
    if (behavior == 3)
      applyForce(arrive);
  }

  PVector separate(ArrayList<Mover> movers) {
    fuel -= 0.01;
    PVector steer = new PVector(0, 0);
    float desiredSep = 50; // separation in pixels
    int count = 0;
    PVector sum = new PVector(0, 0);
    for (Mover other : movers) {
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
    return steer;
  }

  // Calculate steering force to seek a target
  PVector seek(PVector target) {
    fuel -= 0.01;
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    return steer;
  }

  PVector arrive(PVector target) {
    fuel -= 0.01;
    PVector desired = PVector.sub(target, location);
    float dPixelsAway = desired.mag();
    desired.normalize();
    if (dPixelsAway < 100) {
      float magAway = map(dPixelsAway, 0, 100, 0, maxspeed);
      desired.mult(magAway);
    } else {
      desired.mult(maxspeed);
    }
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    return steer;
  }

  PVector followFlow(flowField flow) {
    fuel -= 0.01;
    PVector desired = flow.lookup(location);
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    return steer;
  }

  // survival selection
  boolean survival() {
    float away = PVector.dist(planet.location, location);
    if (away < 5) {
      return true;
    }
    return false;
  }

  // check if ran out of fuel
  boolean isDead() {
    if (fuel < 1)
      return true;
    return false;
  }

  // update fuel when on planet
  void updateFuel() {
    float away = PVector.dist(planet.location, location);
    if (away < 5) {
      fuel += 50;
    }
  }
}
