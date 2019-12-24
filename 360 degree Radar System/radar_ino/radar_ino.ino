#include <Servo.h> 
// Defines Trig and Echo pins of the Ultrasonic Sensor
int pos = 0;    // variable to store the servo position
int i,j;
const int trigPin = 10;
const int echoPin = 11;
int const buzzer = 2;
// Variables for the duration and the distance
long duration;
int distance;
int safetyDistance;
Servo myservo;
Servo myservo1;


void setup() {
  pinMode(trigPin, OUTPUT); // Sets the trigPin as an Output
  pinMode(echoPin, INPUT); // Sets the echoPin as an Input
  pinMode(buzzer, OUTPUT);
  myservo.attach(5);
  myservo1.attach(6);
  Serial.begin(9600);
  
}
void loop() {
  
    for(i=pos; i<=179; i+=1){
        distance = calculateDistance();
       Serial.print(i);  
       Serial.print(",");
       Serial.print(distance); 
       Serial.print("."); 
       myservo1.write(i);
        delay(40);
        }

        for(i=0;i<=180;i+=1){
         distance = calculateDistance();
         j=180;
         Serial.print(i+j);  
         Serial.print(",");
         Serial.print(distance); 
         Serial.print("."); 
          myservo.write(i);
          delay(40);
          j+=1;
        }
         
         for(i=180; i>=0; i-=1){
        myservo.write(i);
        myservo1.write(i);
        delay(1);
        }   
    }

// Function for calculating the distance measured by the Ultrasonic sensor
int calculateDistance(){ 
  
  digitalWrite(trigPin, LOW); 
  delayMicroseconds(2);
  // Sets the trigPin on HIGH state for 10 micro seconds
  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  
  duration = pulseIn(echoPin, HIGH); // Reads the echoPin, returns the sound wave travel time in microseconds
  distance= duration*0.034/2;

  safetyDistance = distance;
if (safetyDistance <= 25){
  digitalWrite(buzzer, HIGH);
}
else{
  digitalWrite(buzzer, LOW);
}
  return distance;
}
