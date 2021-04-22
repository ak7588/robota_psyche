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
