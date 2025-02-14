/*

ID class displays the game token -- student ID.
Player's task is to get the ID.
ID gets replaced each time it gets collected.

*/

class ID {
  PVector location;
  PImage id;
  int score = 0;

  ID() {
    id = loadImage("id.png");
    location = new PVector(random(width), random(height));
  }

  void display() {
    image(id, location.x, location.y);
  }

  void replace() {
    push();
    imageMode(CORNER);
    location.x = random(50, width - id.width);
    location.y = random(50, height - id.height);
    pop();
  }

  void displayScore() {
    push();
    fill(0);
    textAlign(LEFT);
    textSize(22);
    text("Score: " + score, 50, 50);
    text("Health: ", width - 200 - 5*22, 50);
    pop();
  }

  void collect() {
    if (mouseX >= location.x && mouseX <= location.x + id.width && 
      mouseY >= location.y && mouseY <= location.y +id.height) {
      replace();
      score++;
    }
  }
}
