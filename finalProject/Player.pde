class Player {
  PVector location;
  PVector velocity;
  float health;
  boolean alive;
  boolean prevState;
  boolean flag;

  Player () {
    location = new PVector();
    health = 100;
    alive = true;
    prevState = false;
    flag = false;
  }
  
  void displayHealth() {
    int rectW = 200;
    int rectH = 20;
    int rectX = width - 20 - rectW;
    int rectY = 30;
    push();
      noFill();
      stroke(1);
      rect(rectX, rectY, rectW, rectH);
      push();
        fill(238, 232, 170);
        rect(rectX, rectY, health*2, rectH);
      pop();
    pop();
  }

  void updateHealth(boolean collisionState) {
    // check prev state for collision
    if (collisionState) {
      if (prevState == false) {
        // deduct health if collision
        println("Meow!");
        prevState = true;
        health -= 1;
        sound.play();
      }
    } else {
      prevState = false;
    }

    // end the game if no health
    if (health < 0) {
      alive = false;
      sceneManager = 2;
    }

    // reset the collision state
    println("Health: ", health);
  }
}
