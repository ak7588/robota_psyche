void calculateProjection(){
  PVector P1 = new PVector(2, 3);
  PVector P2 = new PVector(7, 10);
  PVector P3 = new PVector(5, 5);
  PVector V = PVector.sub(P3, P1);
  PVector B = PVector.sub(P1, P2);
  V.normalize();
  PVector VM = B.mult(V.dot(B));
}
