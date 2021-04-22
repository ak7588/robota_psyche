import processing.sound.*;

// GUI
SoundFile sound;
SoundFile kitty;
int sceneManager = 0;
int rectX, rectY;
int rectSize = 150;
int gameDifficulty = 50;
color rectColor, rectHover, backgroundColor;
boolean rectOver = false;
PImage tiger;
PFont font;
boolean collisionState = false;

// Game Logic
ArrayList<Cat> cats = new ArrayList<Cat>();
FlowField f;
int numOfCats = 10;
int redThatAreAlsoAggressive = 0;
final int RED_THRESHHOLD = 3;
Player student;
ID id;

void setup() {
  size(600, 600);

  // GUI
  rectColor = color(255, 140, 0);
  rectHover = color(255, 180, 0);
  rectX = width/2 - rectSize/2;
  rectY = height/2 + rectSize;
  sceneManager = 0;
  tiger = loadImage("tiger.png");
  font = createFont("DotGothic16", 32);
  textFont(font);
  sound = new SoundFile(this, "cat.mp3");
  kitty = new SoundFile(this, "kitty.mp3");

  // Game Logic
  f = new FlowField(15);
  id = new ID();
  student = new Player();
  for (int i = 0; i < numOfCats; i++) {
    cats.add(new Cat(random(width), random(height), random(-1, 1), random(-1, 1)));
  }
}

void draw() {
  background(backgroundColor);
  if (sceneManager == 0) {
    backgroundColor = color(238, 232, 170);
    push();
    imageMode(CENTER);
    image(tiger, width/2 - 25, height/2 - 50);
    pop();
    drawButton();
    updateButton();
  } else if (sceneManager == 1) {
    backgroundColor = color(255);
    f.fieldFollowsMouse();
    id.display();
    id.displayScore();
    id.collect();
    student.displayHealth();
    for (Cat cat : cats) {
      cat.separate(cats, gameDifficulty);
      cat.follow(f);
      cat.avoidAggressive(cats);
      if (redThatAreAlsoAggressive > RED_THRESHHOLD) {
        cat.avoidRedCats(cats);
      }
      cat.update();
      cat.checkBorders();
      cat.display();
      student.updateHealth(cat.checkCollision());
    }
    updateDifficulty(id);
  } else if (sceneManager == 2) {
    textAlign(CENTER);
    text("GAME OVER", width/2, height/2);
  }
}

void updateDifficulty(ID id) {
  println("Score: ", id.score);
  if (id.score == 5) {
    gameDifficulty = 70;
  } else if (id.score == 10) {
    gameDifficulty = 100;
  } else if (id.score == 15) {
    gameDifficulty = 120;
  }
}

void drawButton() {
  if (rectOver) {
    fill(rectHover);
  } else {
    fill (rectColor);
  }
  noStroke();
  rect(rectX, rectY, rectSize, rectSize/2);
  push();
  fill(0);
  textAlign(CENTER);
  text("PLAY", rectX + rectSize/2, rectY + rectSize/4 + 15);
  pop();
}

void updateButton() {
  if (overRect(rectX, rectY, rectSize, rectSize)) {
    rectOver = true;
  } else {
    rectOver = false;
  }
}

void mousePressed() {
  if (rectOver) {
    sound.play();
    sceneManager = 1;
    rectOver = false;
  }
}

boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
