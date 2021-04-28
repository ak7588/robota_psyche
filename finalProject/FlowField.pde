// flowField class code taken from class repository
// https://github.com/michaelshiloh/resourcesForClasses/blob/master/src/processingSketches/robotaPsyche/association/flowField.pde
// The flow field class, more or less straight from the book
// with the addition of the display() function 

class FlowField {

  PVector[][] field;
  int cols, rows;
  int resolution; // Size of each square in the grid, in pixels

  // Constructor takes the desired resolution
  FlowField(int _res) {
    resolution = _res;
    cols = width/resolution;
    rows = height/resolution;

    // Declare the array of PVectors which will hold the field
    field = new PVector[cols][rows];

    // Initialize the field 
    randomFlowField();
  }

  void randomFlowField() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        field[i][j] = PVector.random2D(); // unit vectors
      }
    }
  }

  void fieldFollowsMouse() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        // PVector of mouse location
        PVector mouseAt = new PVector(mouseX, mouseY);
        // PVector of current location
        PVector weAt = new PVector(i*resolution, j*resolution);
        // PVector from our current position to mouse
        PVector toMouse = PVector.sub( mouseAt, weAt);
        // Normalize
        toMouse.normalize();
        field[i][j] = toMouse;
      }
    }
  }


  // Given a PVector which defines a location in the flow field,
  // return a copy of the value of the flow field at that location
  PVector lookup(PVector lookup) {

    // Convert x and y values to row and column, and constrain
    // to stay within the field
    int column = int(constrain(lookup.x/resolution, 0, cols-1));
    int row = int(constrain(lookup.y/resolution, 0, rows-1));

    return field[column][row].copy();
  }
}
