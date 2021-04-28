/*

April 28, 2021.

Campus Cats Adventure is an arcade game that is based on NYU Abu Dhabi campus environment.
A number of cats are wondering around the virtual "campus", and the player's task is to collect as many student ID's as possible.
The game gets more difficult with an increasing score.
If the player's health gets below zero, the game is over.

Author: Amina Kobenova.
Class Credits: Robota Psyche, 2021.

*/

// importing add-ons
import processing.sound.*;

// GUI
SoundFile sound;
SoundFile backgroundSound;
int sceneManager = 0;
int rectX, rectY;
int rectSize = 150;
int gameDifficulty = 50;
color rectColor, rectHover, backgroundColor;
boolean rectOver = false;
PImage tiger;
PFont font;
PImage backgroundImage;
boolean collisionState = false;
boolean soundState = false;

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
  backgroundImage = loadImage("campus.jpg");
  font = createFont("DotGothic16", 32);
  textFont(font);
  sound = new SoundFile(this, "cat.mp3");
  backgroundSound = new SoundFile(this, "backgroundSound.mp3");

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
  // display the UI scene of the game
  if (sceneManager == 0) {
    backgroundColor = color(238, 232, 170);
    push();
    imageMode(CENTER);
    image(tiger, width/2 - 25, height/2 - 10, tiger.width*0.8, tiger.height*0.8);
    pop();
    drawButton();
    updateButton();

    // display the main game with cats, the player, and the id's
  } else if (sceneManager == 1) {
    backgroundColor = color(255);
    image(backgroundImage, 0, 0, width, height);
    playBackgroundSound();

    // the player is creating a flow field around cats
    // non-aggressive cats follow the player
    // aggressive cats wander around 
    
    f.fieldFollowsMouse();
    id.display();
    id.displayScore();
    id.collect();
    student.displayHealth();
    for (Cat cat : cats) {

      // cats are separated from each-other
      // health points deduct if the player collides with a cat
      // game difficulty increases as more id's are collected
      
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
    
    // display the Game Over scene
  } else if (sceneManager == 2) {
    backgroundColor = color(238, 232, 170);
    backgroundSound.stop();
    textAlign(CENTER);
    push();
    fill(0);
    text("GAME OVER", width/2, height/2);
    pop();
  }
}

// update difficulty based on the player's score
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

// draw UI elements
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
  text("Campus Cats Adventure", rectX + rectSize/2, 100);
  text("PLAY", rectX + rectSize/2, rectY + rectSize/4 + 15);
  pop();
}

// is button hovered over?
boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

// if button is hovered over, update accordingly
void updateButton() {
  if (overRect(rectX, rectY, rectSize, rectSize)) {
    rectOver = true;
  } else {
    rectOver = false;
  }
}


// play game sound
void playBackgroundSound() {
  if (sceneManager == 1) {
    if (soundState == false) {
      backgroundSound.play();
      soundState = true;
    }
  }
}

// change scenes
void mousePressed() {
  if (rectOver) {
    sceneManager = 1;
    rectOver = false;
  }
}
