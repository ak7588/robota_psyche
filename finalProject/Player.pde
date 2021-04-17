class Player {
  PVector location;
  PVector velocity;
  float health;
  boolean alive;
  
  Player () {
    location = new PVector();
  }
  
  boolean checkCollision(){
    return false;
  }
  
  void updateHealth(){
    if (checkCollision()) {
      health -= 10;
    }
    if (health < 0) {
      alive = false;
      sceneManager = 3;
    }
  }
}
