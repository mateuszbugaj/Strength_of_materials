class Skr{
  ArrayList <Float[]> force = new ArrayList(); // {value of force, dist, spread}
  ArrayList <float[]> cross = new ArrayList(); // {dist of the end of the cross section, value of this cross section}
  int liczbaForce = 1;
  int liczbaSr = 1;
  ArrayList <Float> forceDist = new ArrayList(); // dist of different compartments
  
  ArrayList <PVector> values = new ArrayList(); //coordinates of points {dis, Ms}
  ArrayList <PVector> valuesTau = new ArrayList(); //coordinates of points {dis, Tau}
  ArrayList <Float> allSections = new ArrayList(); // list of all diferent distances from forces and cros sections
  ArrayList <Float[]> MsAL = new ArrayList(); // list of Ms {dist, Ms}
  
  float G, dl = 0;
  int wykresOption = 1; // graph option, 1 means Ms graph, 2 means Tau graph
  
  Wykres wykresMs = new Wykres();
  Wykres wykresTau = new Wykres();
  
  int przekrojeCounter = 0; // TBD To be deleted
  
 void show(){
  skrMenu();
  rysujBelke();
  rysujForce();
  
  for(int i=0; i<forceDist.size();i++)
  rysujPrzekroje(forceDist.get(i));
  
  if(wykresOption==1){
  wykresMs.wczytaj(values,50,570,dl);
  wykresMs.rysujWykres();
  }
  
  if(wykresOption==2){
  wykresTau.wczytaj(valuesTau,50,570,dl);
  wykresTau.rysujWykres();
  }
  
 }
  
  void skrMenu(){
  stroke(0);
  cp5.get("skrLabel").show();
  cp5.get("Dl").show();
  cp5.get("G").show();
  cp5.get("run").show();
  cp5.get("nowa").show();
  cp5.get("nowaSr").show();
  cp5.get("wykresMs").show();
  cp5.get("wykresTau").show();
}
   
   
   
   int getLiczbaForce(){
    return liczbaForce; 
   }
   
    int getLiczbaSr(){
    return liczbaSr; 
   }
   
   void setWykresOpiton(int opt){
     this.wykresOption = opt;
     if(opt == 1){
       cp5.get("wykresMs").setColorBackground(#0074d9);
       cp5.get("wykresTau").setColorBackground(#002d5a);
     } else if (opt == 2){
       cp5.get("wykresTau").setColorBackground(#0074d9);
       cp5.get("wykresMs").setColorBackground(#002d5a);
     }
     
   }
  
void skrSetup(){
  cp5.addTextlabel("skrLabel")
                    .setText("Skręcanie")
                    .setPosition(0,0)
                    .setColorValue(#879102)
                    .setFont(createFont("Georgia",60))
                    .hide(); 
                              
  
    cp5.addTextfield("Dl")
     .setPosition(900,20)
     .setSize(100,30)
     .setFont(createFont("arial",16))
     .setFocus(true)
     .setColor(color(45, 40, 0))
     .setLabel("Długość [mm]")
     .setColorBackground(#d8c745)
     .setColorForeground(#d8c745)
     .hide();
     
     cp5.addTextfield("G")
     .setPosition(1050,20)
     .setSize(100,30)
     .setFont(createFont("arial",16))
     .setFocus(true)
     .setColor(color(45, 40, 0))
     .setLabel("   G [n/m^2]")
     .setColorBackground(#d8c745)
     .setColorForeground(#d8c745)
     .setText("1")
     .hide();
     
     cp5.addButton("run")
    .setPosition(1200,20)
    .setSize(150,50)
    .setFont(createFont("Georgia",16))
    .setLabel("Rozpocznij")
    .hide();
     
     cp5.addButton("nowa")
    .setPosition(1200,75)
    .setSize(150,30)
    .setFont(createFont("Georgia",16))
    .setLabel("Nowa siła")
    .hide();
    
    cp5.addButton("nowaSr")
    .setPosition(1200,110)
    .setSize(150,30)
    .setFont(createFont("Georgia",16))
    .setLabel("Nowa średnica")
    .hide();
    
    cp5.addButton("wykresMs")
    .setPosition(750,400)
    .setSize(45,30)
    .setFont(createFont("Georgia",18))
    .setLabel("Ms ")
    .hide();
    
    cp5.addButton("wykresTau")
    .setPosition(795,400)
    .setSize(45,30)
    .setFont(createFont("Georgia",18))
    .setLabel("Tau ")
    .hide();
    
    setWykresOpiton(1);
  }
  
  void createNew(){
    cp5.addTextfield("P"+liczbaForce)
     .setPosition(1000,120+60*(liczbaForce-1))
     .setSize(100,30)
     .setFont(createFont("arial",16))
     .setFocus(true)
     .setColor(color(45, 40, 0))
     .setLabel("Siła [N] " + liczbaForce)
     .setColorBackground(#d8c745)
     .setColorForeground(#d8c745);
     
     cp5.addTextfield("D"+liczbaForce)
     .setPosition(1110,120+60*(liczbaForce-1))
     .setSize(100,30)
     .setFont(createFont("arial",16))
     .setFocus(true)
     .setColor(color(45, 40, 0))
     .setLabel("Początek " + liczbaForce)
     .setColorBackground(#d8c745)
     .setColorForeground(#d8c745);
     
     cp5.addTextfield("S"+liczbaForce)
     .setPosition(1220,120+60*(liczbaForce-1))
     .setSize(100,30)
     .setFont(createFont("arial",16))
     .setFocus(true)
     .setColor(color(45, 40, 0))
     .setLabel("Pow. " + liczbaForce)
     .setColorBackground(#d8c745)
     .setColorForeground(#d8c745);
     
     
    liczbaForce++;
    
    cp5.get("nowaSr").setPosition(1200,120+(liczbaForce-1)*60);
    
    for(int i = 1; i<liczbaSr;i++){
      cp5.get("DlSr"+i).setPosition(1110,160+60*(i-1)+60*(liczbaForce-1));
      cp5.get("War"+i).setPosition(1220,160+60*(i-1)+60*(liczbaForce-1));
      
    }
    
  }
  
  void createNewSr(){
    cp5.addTextfield("DlSr"+liczbaSr)
     .setPosition(1110,160+60*(liczbaSr-1)+60*(liczbaForce-1))
     .setSize(100,30)
     .setFont(createFont("arial",16))
     .setFocus(true)
     .setColor(color(45, 40, 0))
     .setLabel("Dokąd " + liczbaSr)
     .setColorBackground(#d8c745)
     .setColorForeground(#d8c745);
     
     cp5.addTextfield("War"+liczbaSr)
     .setPosition(1220,160+60*(liczbaSr-1)+60*(liczbaForce-1))
     .setSize(100,30)
     .setFont(createFont("arial",16))
     .setFocus(true)
     .setColor(color(45, 40, 0))
     .setLabel("Wartość " + liczbaSr)
     .setColorBackground(#d8c745)
     .setColorForeground(#d8c745);
     
     liczbaSr++;
  }
  
  
  void run(){
    force.clear();
    forceDist.clear();
    cross.clear();
    values.clear();
    valuesTau.clear();
    allSections.clear();
    MsAL.clear();
    przekrojeCounter=0;
    
    dl = Float.valueOf(cp5.get(Textfield.class,"Dl").getText());
    G =  Float.valueOf(cp5.get(Textfield.class,"G").getText());
    
    println("Dl: " + dl + ", G: " + G);

    for(int i = 0; i<liczbaForce-1; i++){
      Float[] forceData = new Float[3];
      forceData[0] = Float.valueOf(cp5.get(Textfield.class,"P"+(i+1)).getText());
      forceData[1] = Float.valueOf(cp5.get(Textfield.class,"D"+(i+1)).getText());
      forceData[2] = Float.valueOf(cp5.get(Textfield.class,"S"+(i+1)).getText());
      force.add(forceData);
      
       println("Force " + force.size() + " dodana. Data: " + force.get(force.size()-1)[0] + ", " + force.get(force.size()-1)[1] + ", " + force.get(force.size()-1)[2]);
       
       
      if(forceData[2]!=0){ // if force is spreaded add this "blank" force (without value) to the force arrayList on the dist being the sum of the beginning and the spread of the force
      Float[] forceData2 = new Float[3]; // for some reason i had to make this new array and coudn't use the forceData array
        forceData2[0] = 0.0;  // blank force has 0 value
        forceData2[1] = force.get(force.size()-1)[1]+force.get(force.size()-1)[2]; //take the previous force from the force AL because its the spreaded force that blank will be referring to
        forceData2[2] = 0.0; // 0 spread
        force.add(forceData2);
         println("Blank force " + force.size() + " added. Data: " + force.get(force.size()-1)[0] + ", " + force.get(force.size()-1)[1] + ", " + force.get(force.size()-1)[2]);
      }
      
    }   // Adding to the arrayList "force" as many arrays  consisting of 3 numbers as forces.
    
    
    for(int i = 0; i<liczbaSr-1; i++){
      float[] srData = new float[2];
      srData[0] = Float.valueOf(cp5.get(Textfield.class,"DlSr"+(i+1)).getText());
      srData[1] = Float.valueOf(cp5.get(Textfield.class,"War"+(i+1)).getText());
      cross.add(srData);
      println("Sr " + i + " dodana. Data: " + cross.get(i)[0] + ", " + cross.get(i)[1]);
    }   // Adding to the arrayList "cross" as many arrays  consisting of 2 numbers as cross sections.
    
      przekroje();
      if(wykresOption==1)
      wykresMs.wczytaj(values,50 ,570,dl);
      if(wykresOption==2)
      wykresTau.wczytaj(valuesTau,50 ,570,dl);
    
  }
  
  void rysujBelke(){
    strokeWeight(4);
    stroke(160);
    line(50,220,750,220); //220 center of the bar
    stroke(0);
    for (int i = 0; i <5; i++){
      line(35,170+25*i,50,150+25*i);
    }
    line(50,90,50,350); // utwierdzenie
    stroke(0);
    
    float maxSr = 0;
    for (int i = 0; i < cross.size();i++){
      if(cross.get(i)[1]>maxSr)
      maxSr=cross.get(i)[1];
    }
    
    for(int i = 0; i < cross.size(); i++){
      float x = map(cross.get(i)[0],0,dl,35,700);
      float y1 = map(cross.get(i)[1],0,maxSr,220,100);
      float y2 = map(cross.get(i)[1],0,maxSr,220,340);
      if(i==0){
       line(50,y1,x,y1);
       line(50,y2,x,y2);
       line(x,y1,x,y2);
      } else {
      float xb = map(cross.get(i-1)[0],0,dl,35,700);
      float y1b = map(cross.get(i-1)[1],0,maxSr,220,100);
      float y2b = map(cross.get(i-1)[1],0,maxSr,220,340);
      line(xb,y1b,xb,y2b);
       line(xb,y1,x,y1);
       line(xb,y2,x,y2);
       line(x,y1,x,y2);
      }
      
      
    }
    
    stroke(0);
  }
  
  void rysujForce(){
    for (int i = 0; i<force.size(); i++){
      float x = map(force.get(i)[1],0,dl,50,700);
      //noStroke();
      stroke(0);
      strokeWeight(2);

      float dim = 15;
      if(force.get(i)[2]>0){
        float x1 = map(force.get(i)[2],0,dl,50,700)-50; // no idea why -50
        fill(#bfd86c); // green rectangle
        rect(x+x1/2, 220, x1, 50);
        
        if(force.get(i)[0]>0){
        fill(#6faa0a); // green arrow
        rect(x+x1/2, 220+dim, dim, 150);
        triangle(x+x1/2,160-dim,x+x1/2-dim,160+dim,x+x1/2+dim, 160+dim);
      } else if (force.get(i)[0]<0){
        fill(#6faa0a); // green arrow
        rect(x+x1/2, 220-dim, dim, 150);
        triangle(x+x1/2,280+dim,x+x1/2-dim,280-dim,x+x1/2+dim, 280-dim);
      }
        
      }else if(force.get(i)[0]>0){
        fill(#d8c745);
        rect(x, 220+dim, dim, 250);
        triangle(x,95-dim,x-dim,95+dim,x+dim, 95+dim);
      } else if (force.get(i)[0]<0){
        fill(#d8c745);
        rect(x, 220-dim, dim, 250);
        triangle(x,315+2*dim,x+dim,315,x-dim, 315);
      }
      
      stroke(0);
    }
  }
  
  void przekroje(){
      /////////// checking for different distances of forces
      for(int i = 0; i<force.size(); i++){
       forceDist.add(force.get(i)[1]); 
      }
      Collections.sort(forceDist);
      // creating forceDist which is an arraylist consisting of only distances of forces and sorting it
      
      Set<Float> forceDistTemp = new LinkedHashSet(forceDist);
      forceDist.clear();
      forceDist.addAll(forceDistTemp);
      //Removing diplicates by converting arrayList to LinkedHashSet and back to arrayList
      
      ///////////////////////////////////////////////////////////////////// values array
      /////////// sorting forces
      Collections.sort(force, new Comparator<Float[]>() {
        public int compare(Float[] force1,Float[] force2){
          return force1[1].compareTo(force2[1]);
        }
        }); // sorting forces depending on their distance from the left using Comparator
      
      println("Forces after sorting: ");
      for(int i =0; i<force.size(); i++){
       println(i + ": " + force.get(i)[0] + ", " + force.get(i)[1] + ", " +force.get(i)[2]); 
      }
      
      /////////// combining dist from forces and cross sections
      for(int i=0; i<force.size();i++){
        allSections.add(force.get(i)[1]); 
      }
      for(int i=0; i<cross.size();i++){
        allSections.add(cross.get(i)[0]); 
      }
      
      println("All cross: " + allSections);
      /////////// sorting allSections AL
      Collections.sort(allSections); // sorting
      
      Set<Float> allSectionsTemp = new LinkedHashSet(allSections);
      allSections.clear();
      allSections.addAll(allSectionsTemp);
      //Removing diplicates
      println("All cross: " + allSections);
      
      /////////// calculating momentum in the affirmation
      float Ms = 0;
      for(int i=0;i<force.size();i++){ //for every force
        if(force.get(i)[2]==0){ //if the spread is 0
         Ms += force.get(i)[0]; // add force value to the Ms
        } else {
         Ms += force.get(i)[0]*force.get(i)[2]; // else multiply value times spread
        }
      }
      println("Ms = " + Ms);
      
      ///////////
      float[] spreadInfo = new float[2]; // {value, dist left}
      values.add(new PVector(0,Ms)); // first point, dist = 0 and Ms is the Ms of the affirmation
      valuesTau.add(new PVector(0,cTau(Ms,cross.get(0)[1]))); // adding first point with dist = 0 and tau of the affirmation
      //int forceCounter = 0;
      for(int i=0;i<allSections.size();i++){ // for every dist
      for(int j=0;j<force.size();j++){ //for every force (to make sure if two forces are on the same distace program wont miss one
        float pointDist = allSections.get(i); // dist of the next two points (pointMs1 & pointMs2) 
        float pointMs1 = 0; // point before applying force on that dist
        if(spreadInfo[1]!=0){ // if there is spreaded force with dist left not equal to 0
        Ms-=spreadInfo[0]*(pointDist-values.get(values.size()-1).x);
        pointMs1 = Ms; //pointMs1 is equal to Ms minus value of spreaded force times dist of current point minus dist of the previous point
        spreadInfo[1] -= pointDist-values.get(values.size()-1).x; // lower the dist of the spreaded force that's left
        } else {
          println("1. Ms: "+Ms);
        pointMs1 = Ms; // if there is no spreaded force, Ms does not change
        }
        values.add(new PVector(pointDist,pointMs1)); // adding first point of this distance to the values
        
        float currentD = 0; //diameter in that point
        for(int k=0;k<cross.size();k++){ // for every diferent diameter
          if(cross.get(k)[0]>=pointDist){ // if dist of the end of this diamener is lower than the dist of this point
            currentD = cross.get(k)[1]; //set currentD to the value of that diameter
            break;
          }
        }
        
        valuesTau.add(new PVector(pointDist,cTau(pointMs1,currentD))); // adding first point 
        
        for(int k=0;k<cross.size();k++){ // for every diferent diameter
          if(cross.get(k)[0]>pointDist){ // if dist of the end of this diamener is lower than the dist of this point
            currentD = cross.get(k)[1]; //set currentD to the value of that diameter
            break;
          }
        }
        
        float pointMs2 = pointMs1;
                 
        if(force.get(j)[2]!=0&&force.get(j)[1]==pointDist){ //if force has spread and dist is the same like pointDist
         spreadInfo[0] = force.get(j)[0]; // add its value to spreadInfo
         spreadInfo[1] = force.get(j)[2]; // add its spread
         pointMs2 = Ms ;
        } else if(force.get(j)[2]==0&&force.get(j)[1]==pointDist) {
          Ms -= force.get(j)[0];
         pointMs2 =  Ms;
         println("2. Ms: "+Ms);
        }
        
        values.add(new PVector(pointDist,pointMs2)); // adding second point of this distance to the values
        valuesTau.add(new PVector(pointDist,cTau(pointMs2,currentD))); // adding second point 
        for(int g=0;g<force.size();g++){ //for every force
          if(force.get(g)[1]==pointDist){ //check if dist of that point matches the dist of one of the forces in force AL
          //forceCounter++; //if it does it means this point has force on it so you need to add so on the next point there will be next force
          println("Dist and forceCounter: " + pointDist + ", " + j);
          break;
          }
        }
      }//end for j
      } // end for i
      
      println("Values:");
      for(int i=0;i<values.size();i++){
        println(i+": "+values.get(i).x+", "+values.get(i).y);
      }
      
      
      
  }
  
  float cTau(float Ms, float d){
    float tau = (16*Ms)/(PI*d*d*d);
   return tau; 
  }
  
  
  void rysujPrzekroje(float odl){
    // drawing line behind force 
    float x = map(odl,0,dl,50,700);
    float dim = 15;
    stroke(#0190af);
    strokeWeight(4);
    line(x-dim, height*0.47+2*dim, x-dim, height*0.13-2*dim);
    line(x-dim, height*0.47+2*dim, x, height*0.47+2*dim);
    line(x-dim, height*0.13-2*dim, x, height*0.13-2*dim);
  }
  
  
  
}
