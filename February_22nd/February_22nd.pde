Mover mover; // creating Mover object
flowField field;
DNA dna;
Planet planet;

float accelValue = 0.21; // setting default acceleration value
float force = 0.01;
int numOfRockets = 5;
PVector target;
ArrayList<Mover> movers;
boolean selection;

// default window and object setup
void setup() {
  background(255);
  size(680, 470);
  selection = false;
  dna = new DNA();
  planet = new Planet();
  mover = new Mover(width/2, height/2, dna);
  field = new flowField(15);
  target = planet.getLocation();
  movers = new ArrayList<Mover>();
  for (int i = 0; i < numOfRockets; i++) {
    movers.add(new Mover(random(width), random(height), dna));
  }
}

// set the background color and run mover functions
void draw() {
  background(0, 51, 102);

  planet.display();
  field.perlinField();


  //mover.display();
  //field.fieldFollowsMouse();
  //mover.update();
  //mover.checkBorders();
  //mover.followFlow(field);
  //mover.separate(movers);
  //mover.arrive(target);


  // display aray list of movers
  for (Mover m : movers) {
    m.separate(movers);
    m.display();
    m.update();
    m.checkBorders();
    m.applyBehaviors(movers);
    m.followFlow(field);
    m.arrive(target);
    selection = m.survival();
  }

  if (selection) {
    movers.add(new Mover(0, height-10, dna));
  }
}

// update the mover's acceleration as keys are pressed
void keyPressed() {
  if (keyCode == RIGHT) {
    mover.updateAccel(accelValue, 0);
  }
  if (keyCode == LEFT) {
    mover.updateAccel(-accelValue, 0);
  }
  if (keyCode == UP) {
    mover.updateAccel(0, -accelValue);
  }
  if (keyCode == DOWN) {
    mover.updateAccel(0, accelValue);
  }
}
