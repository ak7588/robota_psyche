Mover mover; // creating Mover object
flowField field;
DNA dna;
Planet planet;
Planet[] planets;
PImage space;

float accelValue = 0.21; // setting default acceleration value
float force = 0.01;
int numOfRockets = 5;
int numPlanets = 2;
PVector target;
ArrayList<Mover> movers;
boolean selection;
boolean isdead;

// default window and object setup
void setup() {
  space = loadImage("space.jpeg");
  size(680, 470);
  selection = false;
  isdead = false;
  dna = new DNA();
  planet = new Planet();
  planets = new Planet[numPlanets];
  for (int i = 0; i < numPlanets; i++){
    planets[i] = new Planet();
  }
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
  // ackground(0, 51, 102);
  background(space);

  planet.display();
  
  for (int i = 0; i < numPlanets; i++){
    planets[i].display();
  }
  
  field.perlinField();

  // display aray list of movers
  for (Mover m : movers) {
    m.separate(movers);
    m.display();
    m.update();
    m.updateFuel();
    m.checkBorders();
    m.applyBehaviors(movers);
    m.followFlow(field);
    m.arrive(target); // arrive to the planet
    selection = m.survival(); // add a new mover if true
  }
  
  // add a new mover if true
  if (selection) {
    println("I am born!");
    movers.add(new Mover(0, height-10, dna));
  }
  
  // remove is no fuel left
  for(int i = movers.size()-1; i >= 0; i--){
    Mover m = movers.get(i);
    if(m.isDead()){
      println("I am dying...");
      movers.remove(i);
    }
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
