// creating the flowfield
class flowField {
  PVector[][] field;
  int rows, cols;
  int resolution;

  flowField(int _res) {
    resolution = _res;
    cols = width/resolution;
    rows = height/resolution;
    field = new PVector[cols][rows];
    fieldFollowsMouse();
  }

  void perlinField() {
    float xoff = 0;
    for (int i = 0; i < cols; i++) {
      float yoff = 0;
      for (int j = 0; j < rows; j++) {
        float theta = map(noise(xoff, yoff), 0, 1, 0, TWO_PI);
        field[i][j] = new PVector(cos(theta), sin(theta));
        yoff += 0.1;
      }
      xoff += 0.1;
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

  // Display the flow field so we can see if it looks like what we think it should
  // 
  void display() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        // print("col " + i + " row " + j + "  ");
        // println(i*resolution, j*resolution, field[i][j].x, field[i][j].y);
        pushMatrix();
        // This translates to the top left corner of the grid, but really
        // it should center the vector in the middle of the grid
        translate(i*resolution, j*resolution);
        PVector f = field[i][j].copy();
        f.mult(resolution);
        line(0, 0, f.x, f.y);
        ellipse(f.x, f.y, 5, 5); // circle instead of arrow head
        popMatrix();
      }
    }
  }

  PVector lookup(PVector lookup) {
    int column = int(constrain(lookup.x/resolution, 0, cols-1));
    int row = int(constrain(lookup.y/resolution, 0, rows-1));
    return field[column][row].copy();
  }
}
