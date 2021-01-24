Car car; // class name + variable name to declare an object

void setup(){
  size(600,600);
  car = new Car(width/2, height/2); // instantiating an object
}

void draw(){
  background(255);
  car.display();
  car.move();
  car.checkBorders();
}
