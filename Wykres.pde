class Wykres{
  ArrayList <PVector> values = new ArrayList();
  float posX = 0;
  float posY = 0;
  float dl = 0;
  float dlOsiX = 650;
  float dlOsiY = 150;
  
  void wczytaj(ArrayList <PVector> values,float posX, float posY, float dl){
    this.values = values;
    this.posX = posX;
    this.posY = posY;
    this.dl = dl;
  }
  
  void rysujWykres(){
    rysujOsieWykresu();
    rysujFunkcjeWykresu();
  }
  
  void rysujOsieWykresu(){
    pushMatrix();
    translate(posX,posY);
    stroke(0);
    strokeWeight(4);
    line(0,-dlOsiY-20,0,dlOsiY+20);
    line(0,0,dlOsiX+20,0);
    popMatrix();
    
  }
  
  void rysujFunkcjeWykresu(){
    pushMatrix();
    translate(posX,posY);
    /////////// Finding max Ms for maping the rest of the graph
    float maxMs = 0;
    for (int i=0;i<values.size();i++){ // for every point in values AL
    if(abs(values.get(i).y) > maxMs){
      maxMs = abs(values.get(i).y);
    }
      
    }
    
    for(int i=0;i<values.size();i++){ // for every point in values AL
    if(i<values.size()-1){
      float x1 = map(values.get(i).x,0,dl,0,dlOsiX);
      float y1 = map(values.get(i).y,0,maxMs,0,-dlOsiY);
      float x2 = map(values.get(i+1).x,0,dl,0,dlOsiX);
      float y2 = map(values.get(i+1).y,0,maxMs,0,-dlOsiY);
      fill(0);
      stroke(0);
      line(x1,y1,x2,y2);
      fill(#d8c745);
      stroke(#d8c745);
      ellipse(x1,y1,5,5);
      fill(255);
      stroke(0);
      text(nf(values.get(i).y,1,1),x1-5,y1-10);
    }
      
    }
    
    popMatrix();
  }
  
} // class
