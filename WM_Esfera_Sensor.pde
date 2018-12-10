/**
 * Esfera
 * by David Pena.  
 * 
 * Distribucion aleatoria uniforme sobre la superficie de una esfera. 
  
 */
 
 //Edited by Yuchen Zhang to interact with tufting with conductive thread sensor for processing 3.3.6
 //contact us at info@wearablemedia.studio for any questions


import processing.serial.*;
Serial myPort;  // Create object from Serial class
int val;     // Data received from the serial port
String inData = "";

int cuantos = 16000;
Pelo[] lista ;
float radio = 200;
float rx = 0;
float ry =0;

void setup() {
  size(1500, 900, P3D);

  radio = height/3.5;

  lista = new Pelo[cuantos];
  for (int i = 0; i < lista.length; i++) {
    lista[i] = new Pelo();
  }
  noiseDetail(3);
  
  String portName = Serial.list()[3]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600); // opening serial monitor communication port

  background(0);

}

void draw() {

  // move with touch sensor
    if ( myPort.available() > 0) {  // If data is available,
         try { 
            inData = myPort.readStringUntil('\n');
            if ( inData == null ) {
               throw new Exception("Error reading: "+inData);
            }
            else
              inData = inData.trim();
            val = Integer.parseInt(inData);
           
        if (val>0) {
          
           //float rxp = val * 0.001;
           //float ryp = val * 0.001;
           float rxp = (val-(width/2)) * 0.005;
           float ryp = (val-(height/2)) * 0.005;
           
            rx = rx*0.9 + rxp*0.1;
            ry = ry*0.9 + ryp*0.1;
          
            translate(width/2, height/2);
            rotateY(rx);
            rotateX(ry);
            fill(0);
            noStroke();
            sphere(radio);
            
            for (int i = 0; i < lista.length; i++) {
            lista[i].dibujar();
            }
        }

            
       } catch (Exception ex) {
         println("Exception:"+ex.toString()+" Data:"+inData);
       }
       println(">"+inData+" -> "+val+"<");
  }
}

class Pelo
{
  float z = random(-radio, radio);
  float phi = random(TWO_PI);
  float largo = random(1.15, 1.2);
  float theta = asin(z/radio);

  Pelo() { // what's wrong with a constructor here
    z = random(-radio, radio);
    phi = random(TWO_PI);
    largo = random(1.15, 1.2);
    theta = asin(z/radio);
  }

  void dibujar() {

    float off = (noise(millis() * 0.0002, sin(phi))-0.5) * 0.3;
    float offb = (noise(millis() * 0.0003, sin(z) * 0.01)-0.5) * 0.3;

    float thetaff = theta+off;
    float phff = phi+offb;
    float x = radio * cos(theta) * cos(phi);
    float y = radio * cos(theta) * sin(phi);
    float z = radio * sin(theta);

    float xo = radio * cos(thetaff) * cos(phff);
    float yo = radio * cos(thetaff) * sin(phff);
    float zo = radio * sin(thetaff);

    float xb = xo * largo;
    float yb = yo * largo;
    float zb = zo * largo;

    strokeWeight(3);
    beginShape(LINES);
    stroke(10);
    vertex(x, y, z);
    stroke(150,220,220);
    vertex(xb, yb, zb);
    endShape();
  }
}