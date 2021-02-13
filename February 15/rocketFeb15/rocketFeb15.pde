Mover mover; // creating Mover object
flowField field;
float accelValue = 0.21; // setting default acceleration value
float force = 0.01;

ArrayList<Mover> movers;

// default window and object setup
void setup(){
  background(255);
  size(680, 470);
  
  mover = new Mover(width/2, height/2);
  field = new flowField();
  
  movers = new ArrayList<Mover>();
  for(int i = 0; i < 3; i++){
    movers.add(new Mover(random(width-50), random(height-50)));
  }
  
}

// set the background color and run mover functions
void draw(){
  background(0,51,102); 
  
  mover.display();
  field.display();
  mover.update();
  mover.checkBorders();
  mover.followFlow(field);
  
  // display aray list of movers
  for(Mover m : movers){
    m.display();
    m.update();
    m.checkBorders();
    m.followFlow(field);
  }
  
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
