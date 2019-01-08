

import processing.serial.*;
import ddf.minim.*;

Minim minim;
AudioPlayer correct;
AudioPlayer wrong;
AudioPlayer word1;
AudioPlayer word2;
AudioPlayer word3;
AudioPlayer word4;
AudioPlayer word5;
int counter;
String check;
ArrayList <AudioPlayer> ar;

int lf = 10;    // Linefeed in ASCII
String myString = null;
Serial myPort;  // The serial port
int sensorValue = 0;

void setup() {
  // List all the available serial ports
  printArray(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[10], 9600);
  myPort.clear();
  // Throw out the first reading, in case we started reading 
  // in the middle of a string from the sender.
  myString = myPort.readStringUntil(lf);
  myString = null;
  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);
  ar = new ArrayList<AudioPlayer>();
  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  // Change the name of the audio file here and add it by clicking on "Sketch —> Import File"
  correct = minim.loadFile("correct.wav");
  wrong = minim.loadFile("error.wav");
  word1 = minim.loadFile("meow.mp3");
  word2 = minim.loadFile("pew.wav");
  word3 = minim.loadFile("anim.wav");
  word4 = minim.loadFile("haha.wav");
  word5 = minim.loadFile("woop.mp3");
  ar.add(word1);
  ar.add(word2);
  ar.add(word3);
  ar.add(word4);
  ar.add(word5);
  ar.add(word1);
  ar.add(word2);
  ar.add(word3);
  counter = 0;
  check = "";
}

void draw() {
  checkCounter();
  delay(500);
  // check if there is something new on the serial port
  while (myPort.available() > 0) {
    // store the data in myString 
    myString = myPort.readStringUntil(lf);
    // check if we really have something
    if (myString != null) {
      myString = myString.trim(); // let's remove whitespace characters
      // if we have at least one character...
      if(myString.length() > 0) {
        println(myString); // print out the data we just received
        // if we received a number (e.g. 123) store it in sensorValue, we sill use this to change the background color. 
        try {
          sensorValue = Integer.parseInt(myString);
          // As the range of an analog sensor is between 0 and 1023, we need to 
          // convert it in order to use it for the background color brightness
          int brightness = (int)map(sensorValue, 0, 1023, 0, 255);
          background(brightness);
          
        } catch(Exception e){}
        if(myString.equals("A")){
          if(ar.get(0).isPlaying() == false){
            ar.get(0).play();
            ar.get(0).rewind();
            check = check +"1";
            delay(500);
            ++counter;
          }
        }
        if(myString.equals("B")){
          if(ar.get(1).isPlaying() == false){
            ar.get(1).play();
            ar.get(1).rewind();
            counter++;
            check = check +"2";
            delay(500);
          }
        }
        if(myString.equals("C")){
          if(ar.get(2).isPlaying() == false){
            ar.get(2).play();
            ar.get(2).rewind();
            counter+=1;
            check = check +"3";
            delay(500);;
          }
        }
        if(myString.equals("D")){
          if(ar.get(3).isPlaying() == false){
            ar.get(3).play();
            ar.get(3).rewind();
            counter+=1;
            check = check +"4";
            delay(500);
          }
        }
      }
    }
  }
}

void checkCounter(){
 //println(counter);
 if(counter>=4){
   if(check.equals("1234")){
     delay(500);
     correct.play();
     correct.rewind();
     ar.remove(0);
     ar.remove(0);
     ar.remove(0);
     ar.remove(0);
   }else{
     delay(500);
     wrong.play();
     wrong.rewind();
   }
   counter = 0;
   check = "";
 }else{
  
 }
}
