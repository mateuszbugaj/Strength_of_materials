import java.util.*;
import controlP5.*;
import java.util.Collections;
import java.util.Comparator;

ControlP5 cp5; //initializing library 
Skr skr; // initializing skr object
int option = 1; // option that switch to correct function from menu 

void setup(){
  background(180);
  size(1366,768); // the most popular resolution
  rectMode(CENTER); 
  textSize(20);
  cp5 = new ControlP5(this); //library stuff
  
  skr = new Skr(); //creating skr object
  
  cp5.addTextlabel("wybierz")
                    .setText("Wybierz typ zadania:")
                    .setPosition(440,50)
                    .setColorValue(#879102)
                    .setFont(createFont("Georgia",50)); //text "wybierz"
                    
  cp5.addButton("skr")
  .setPosition(520,150)
  .setSize(300,50)
  .setFont(createFont("Georgia",20))
  .setLabel("Skręcanie wału"); // button for "skr" option
  
  cp5.addButton("roz")
  .setPosition(520,220)
  .setSize(300,50)
  .setFont(createFont("Georgia",20))
  .setLabel("Rozciąganie wału/pręta"); // button for "roz" option
  
  skr.skrSetup(); // setup for skr option
}

void draw(){
  background(180);
  switch(option){ // what option display
    case 1:
    cp5.get("wybierz").hide(); // hiding menu stuff
    cp5.get("skr").hide();
    cp5.get("roz").hide(); 
    
    skr.show(); // running skr option
    break;
  }
  
}

void skr(){
 option = 1;
}

void nowa(){ // handling button for new force from skr
  println("nowa sila");
  if(skr.getLiczbaForce()<=6){
  skr.createNew();
  }
  
}

void nowaSr(){ // handling button for new force from skr
  println("nowa sila");
  if(skr.getLiczbaSr()<=3){
  skr.createNewSr();
  }
  
}

void run(){ // handling button for running program from skr
  println("run");
  skr.run();
}

void wykresMs(){
  skr.setWykresOpiton(1);
}

void wykresTau(){
  skr.setWykresOpiton(2);
}
