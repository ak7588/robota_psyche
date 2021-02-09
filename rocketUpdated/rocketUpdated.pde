Mover mover; // creating Mover object
float accelValue = 0.21; // setting default acceleration value

// default window and object setup
void setup(){
  background(255);
  size(680, 470);
  mover = new Mover();
}

// set the background color and run mover functions
void draw(){
  background(0,51,102); 
  mover.display();
  mover.update();
  mover.checkBorders();
}

// update the mover's acceleration as keys are pressed
void keyPressed(){
  if (keyCode == RIGHT){
    mover.updateAccel(accelValue,0);
  }
  if (keyCode == LEFT){
    mover.updateAccel(-accelValue,0);
  }
  if (keyCode == UP){
    mover.updateAccel(0,-accelValue);
  }
  if (keyCode == DOWN){
    mover.updateAccel(0,accelValue);
  }
}
