ArrayList<Ant> ants = new ArrayList<Ant>();
FlowField f;
int numOfAnts = 20;
int redThatAreAlsoAggressive = 0;
final int RED_THRESHHOLD = 7;

void setup() {
  size (700, 700);
  f = new FlowField(15); 
  for (int i = 0; i < numOfAnts; i++) {
    ants.add(new Ant(random(width), random(height), random(-3, 3), random(-3, 3)));
  }
}

void draw(){
  background(200);
  for (Ant a : ants){
    a.avoidAggressive(ants);
    if (redThatAreAlsoAggressive > RED_THRESHHOLD) {
      a.avoidRedAnts(ants);
    }
    a.update();
    a.checkBorders();
    a.display();
  }
}
