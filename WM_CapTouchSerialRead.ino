 //Edited by Yuchen Zhang to interact with tufting with conductive thread sensor 
 //Using Circuit Playground Capacitive Touch Sensor on board with Processing 3.3.6
 //contact us at info@wearablemedia.studio for any questions


#include <Adafruit_CircuitPlayground.h>

int sensorReading1;

////////////////////////////////////////////////////////////////////////////
void setup() {
  // Initialize serial.
  Serial.begin(9600); 
  
  // Initialize Circuit Playground library.
  CircuitPlayground.begin();

  
}

////////////////////////////////////////////////////////////////////////////
void loop() {
  // Print cap touch reading on serial port.
  
  sensorReading1 = CircuitPlayground.readCap(1);
  Serial.println(sensorReading1);
  delay(100);
}
