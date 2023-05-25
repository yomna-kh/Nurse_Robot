#include <SoftwareSerial.h>

SoftwareSerial leftMotor(10, 11);  // RX, TX
SoftwareSerial rightMotor(8, 9);   // RX, TX

int error = 0;
int leftMotorSpeed = 0;
int rightMotorSpeed = 0;

//**line tracker**//

int sensorPins[8] = { A0, A1, A2, A3, A4, A5, A6, A7 };  //  3 | 2 | 1 | 0 | 0 | 1 | 2 | 3    sensor weight values
int sensorValues[8] = { 0 };                             //  0 | 1 | 2 | 3 | 4 | 5 | 6 | 7    sensor numbers

#define IR 2
#define PWM 60  //80
#define GAIN 2.5

int intersection = 0;

//** timer ***//
char inputChar;
unsigned long counter = 0;
bool ledState = 0;
#define led 13
#define GND 12

//***obstacle***//

//#include <SharpIR.h>

#define leftProximity 50
#define rightProximity 51
#define minThreshold 200
#define maxThreshold 300
#define sharpIR A10

//SharpIR sensor(SharpIR::GP2Y0A02YK0F, sharpIR);
int dis1;
int room_no;
char room ; 


//** prototypes **//

void lineTracker(void);
int Obstacle_Detection(void);


void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  while (!Serial) {};
  leftMotor.begin(115200);
  rightMotor.begin(115200);
 

  for (int i = 1; i < 7; i++) {
    pinMode(sensorPins[i], INPUT);
  }

  pinMode(rightProximity, INPUT);
  pinMode(leftProximity, INPUT);
  pinMode(sharpIR, INPUT);
  pinMode(led, OUTPUT);
  pinMode(GND, OUTPUT);
  pinMode(IR, OUTPUT);

  digitalWrite(IR, HIGH);
  digitalWrite(GND, LOW);
}


void loop() {

  // put your main code here, to run repeatedly:

 leftMotor.write(1);
  rightMotor.write(1);
  
  while (Serial.available() > 0) {
  inputChar = Serial.read(); 
   
 //dis1 = sensor.getDistance();  // this returns the distance for sensor 1
  dis1 = analogRead(A10);
   
  while ((inputChar=='A')  && (digitalRead(leftProximity) == 1)&& (digitalRead(leftProximity) == 1)&&((dis1 < minThreshold) || (dis1 > maxThreshold)) ){
    
    //while (c=="Start" &&((dis1 < minThreshold) || (dis1 > maxThreshold)) && (digitalRead(rightProximity) == 1) && (digitalRead(leftProximity) == 1)) {
     Serial.println (inputChar);
     room =  Serial.read();
     while ( (room == 'C' || room == 'D' || room == 'E')  &&  inputChar != 'B' ){
    
    lineTracker();
    switch (room) {
  case 'C':
    room_no = 1;
    break;
  case 'D':
    // statements
    room_no = 2 ;
    break;
  case 'E':
    // statements
    room_no = 3 ;
    break;
}
 Serial.println(room_no);
    if (Serial.read() == ('B'))
    {
      inputChar = 'B';
      Serial.println (inputChar);
      return;
    }
    
    leftMotorSpeed = PWM + error - 1;   // PWM = 79
    rightMotorSpeed = PWM - error + 1;  // PWM = 81
    leftMotor.write(leftMotorSpeed);
    rightMotor.write(rightMotorSpeed);

     if (Serial.read() == 'B')
    {
      inputChar = 'B';
      Serial.println (inputChar);
      return;
    }
    

    if (sensorValues[1] && sensorValues[4] && sensorValues[2] && sensorValues[5] && sensorValues[3] && sensorValues[6]) {
      counter = millis();
      while (sensorValues[1] && sensorValues[4] && sensorValues[2] && sensorValues[5] && sensorValues[3] && sensorValues[6]) {
        lineTracker();
      
         if (Serial.read() =='B')
    {
      inputChar = 'B';
      Serial.println (inputChar);
      
      return;
    }
    

        if (millis() - counter > 100) {
          intersection++;
 Serial.println("2");
  if (Serial.read() =='B')
    {
      inputChar = 'B';
      Serial.println (inputChar);
      return;
    }
                                    
          //Serial.print(" intersection = ");
          //Serial.println(intersection);
          if (intersection == room_no)
          {
               leftMotor.write(1);
               rightMotor.write(1);
               digitalWrite(8, HIGH);
               
                Serial.println("3");
               
          }
          counter = millis();
        }
 
        }
      }
    }
 
    //Serial.println("ana 5alast");
    error = 0;
    delay(100);
 
    
  }
  leftMotor.write(1);
  rightMotor.write(1);
  } 
 
  }

  
   



void lineTracker(void) {

  for (int i = 1; i < 4; i++) {
    sensorValues[i] = digitalRead(sensorPins[i]);
    Serial.print(sensorValues[i]);

    if (sensorValues[i]) {
      error += GAIN * (3 - i);
    }
  }
  for (int i = 4; i < 7; i++) {
    sensorValues[i] = digitalRead(sensorPins[i]);
    Serial.print(sensorValues[i]);

    if (sensorValues[i]) {
      error += GAIN * (4 - i);
    }
  }
  Serial.println();
}
