import processing.serial.*; // imports library for serial communication
import java.awt.event.KeyEvent; // imports library for reading the data from the serial port
import java.io.IOException;

Serial myPort; // defines Object Serial
//variables
String angle="";
String distance="";
String data="";
String noObject;
float pixsDistance;
int iAngle, iDistance;
int index1=0;
int index2=0;

void setup() {
 size (800, 840);
 smooth();
 myPort = new Serial(this,"COM3", 9600); // starts the serial communication
 myPort.bufferUntil('.'); // reads the data from the serial port up to the character '.'. So actually it reads this: angle,distance.
 
}

void draw() {
  
  fill(98,245,31);
  // simulating motion blur and slow fade of the moving line
  noStroke();
  fill(0,4);
  rect(0, 0, width, height-height*0.065); //retangulo da tela
  
  fill(98,245,31); // green color
  // calls the functions for drawing the radar
  drawRadar(); 
  drawLine();
  drawObject();
  drawText();
}

void serialEvent (Serial myPort) { // starts reading data from the Serial Port
  // reads the data from the Serial Port up to the character '.' and puts it into the String variable "data".
  data = myPort.readStringUntil('.');
  data = data.substring(0,data.length()-1);
  
  index1 = data.indexOf(","); // find the character ',' and puts it into the variable "index1"
  angle= data.substring(0, index1); // read the data from position "0" to position of the variable index1 or thats the value of the angle the Arduino Board sent into the Serial Port
  distance= data.substring(index1+1, data.length()); // read the data from position "index1" to the end of the data pr thats the value of the distance
  
  // converts the String variables into Integer
  iAngle = int(angle);
  iDistance = int(distance);
}

void drawRadar() {
  pushMatrix();
  translate(width/2,height/2); // moves the starting coordinats to new location
  noFill();
  strokeWeight(2);
  stroke(98,245,31);
  
  // draws the arc lines
  
  arc(0,0,(width*0.20),(width*0.20),0,TWO_PI);
  arc(0,0,(width*0.40),(width*0.40),0,TWO_PI);
  arc(0,0,(width*0.60),(width*0.60),0,TWO_PI);
  arc(0,0,(width*0.80),(width*0.80),0,TWO_PI);
  arc(0,0,(width),(width),0,TWO_PI);
  
  // draws the angle lines
  line(-width/2,0,width/2,0);
  line(0,0,(-width/2)*cos(radians(30)),(-width/2)*sin(radians(30)));
  line(0,0,(-width/2)*cos(radians(60)),(-width/2)*sin(radians(60)));
  line(0,0,(-width/2)*cos(radians(90)),(-width/2)*sin(radians(90)));
  line(0,0,(-width/2)*cos(radians(120)),(-width/2)*sin(radians(120)));
  line(0,0,(-width/2)*cos(radians(150)),(-width/2)*sin(radians(150)));
  line(0,0,(-width/2)*cos(radians(180)),(-width/2)*sin(radians(180)));
  line(0,0,(-width/2)*cos(radians(210)),(-width/2)*sin(radians(210)));
  line(0,0,(-width/2)*cos(radians(240)),(-width/2)*sin(radians(240)));
  line(0,0,(-width/2)*cos(radians(270)),(-width/2)*sin(radians(270)));
  line(0,0,(-width/2)*cos(radians(300)),(-width/2)*sin(radians(300)));
  line(0,0,(-width/2)*cos(radians(330)),(-width/2)*sin(radians(330)));
  line((-width/2)*cos(radians(30)),0,width/2,0);
  popMatrix();
}

void drawObject() {
  pushMatrix();
  translate(width/2,height/2); // moves the starting coordinats to new location
  strokeWeight(9);
  stroke(255,10,10); // red color
  
  pixsDistance = ((iDistance*height*0.1)/10); //37.795275591
 
  // limiting the range to 50 cms
  if(iDistance<50){
  // draws the object according to the angle and the distance
  line(pixsDistance*cos(radians(iAngle)),-pixsDistance*sin(radians(iAngle)),(width-width*0.505)*cos(radians(iAngle)),-(width-width*0.505)*sin(radians(iAngle)));
  }
  popMatrix();
}

void drawLine() {
  pushMatrix();
  strokeWeight(9);
  stroke(30,250,60);
  translate(width/2,height/2); // moves the starting coordinats to new location 0.505
  line(0,0,(height-height*0.505)*cos(radians(iAngle)),-(height-height*0.505)*sin(radians(iAngle))); // draws the line according to the angle
  popMatrix();
}

void drawText() { // draws the texts on the screen
  
  pushMatrix();
  if(iDistance>50) {
  noObject = "Out of Range";
  }
  else {
  noObject = "In Range";
  }
  fill(0,0,0);
  noStroke();
  rect(0, height-height*0.0648, width, height);
  fill(98,245,31);
  textSize(10);
  text("10cm",width-width*0.45,height*0.49);
  text("20cm",width-width*0.35,height*0.49);
  text("30cm",width-width*0.25,height*0.49);
  text("40cm",width-width*0.15,height*0.49);
  text("50cm",width-width*0.05,height*0.49);
  fill(255,255,255);
  textSize(15);
  // 1/25=0.04;
  text("Object: " + noObject, width-width*0.875, height-height*0.0277);
  text("Angle: " + iAngle +" °",  width-width*0.48, height-height*0.0277);
  text("Distance: ", width-width*0.26, height-height*0.0277);
  
  if(iDistance<50) {
  text("        " + iDistance +" cm",  width-width*0.225, height-height*0.0277);
  }
  textSize(10);
   fill(98,245,60);
  popMatrix(); 
}
