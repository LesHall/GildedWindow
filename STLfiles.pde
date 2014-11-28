// by Les Hall
// 


STLfiles stl = new STLfiles();


class STLfiles
{
  //PVector[] vertexes;
  
  STLfiles()
  {
    //vertexes = new PVector[0];
  }

  void drawSTL(int count)
  {
    pushMatrix();
      rotateX(2*PI*count/900);
      rotateY(2*PI*count/1800);
      rotateZ(2*PI*count/3600);
      box(100);
    popMatrix();
  }
}



