

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
AudioPlayer word6;
AudioPlayer word7;
AudioPlayer word8;
AudioPlayer word9;
AudioPlayer word10;
AudioPlayer word11;
AudioPlayer word12;
int counter;
String check;
ArrayList <AudioPlayer> ar;
IntList shuff;
int sentenceNum;
int lf = 10;    // Linefeed in ASCII
String myString = null;
Serial myPort;  // The serial port
int sensorValue = 0;
int playedA;
int playedB;
int playedC;
int playedD;
boolean mixed;

void setup() {
  // List all the available serial ports
  printArray(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[14], 9600);
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
  correct = minim.loadFile("welldone.mp3");
  wrong = minim.loadFile("tryagain.mp3");
  word1 = minim.loadFile("what.mp3");
  word2 = minim.loadFile("is.mp3");
  word3 = minim.loadFile("your.mp3");
  word4 = minim.loadFile("name.mp3");
  word5 = minim.loadFile("how.mp3");
  word6 = minim.loadFile("old.mp3");
  word7 = minim.loadFile("are.mp3");
  word8 = minim.loadFile("you.mp3");
  word9 = minim.loadFile("do.mp3");
  word10 = minim.loadFile("speak.mp3");
  word11 = minim.loadFile("english.mp3");
  word12 = minim.loadFile("doing.mp3");
  ar.add(word1);
  ar.add(word2);
  ar.add(word3);
  ar.add(word4);
  ar.add(word5);
  ar.add(word6);
  ar.add(word7);
  ar.add(word8);
  ar.add(word9);
  ar.add(word8);
  ar.add(word10);
  ar.add(word11);
  ar.add(word5);
  ar.add(word7);
  ar.add(word8);
  ar.add(word12);
  counter = 0;
  check = "";
  sentenceNum = 1;
  playedA = 0;
  playedB  = 0;
  playedC = 0;
  playedD = 0;
  shuff = new IntList();
  shuff.append(0);
  shuff.append(1);
  shuff.append(2);
  shuff.append(3);
  mixed = false;
}

void draw() {
  checkCounter();
  delay(500);
  if(!mixed){
    shuff.shuffle();
    mixed = true;
  }
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
          //if(ar.get(0).isPlaying() == false){
            if(playedA == 0){
            ar.get(shuff.get(0)).play();
            playedA = 1;
            check = check +(shuff.get(0) +1);
            delay(500);
            ++counter;
          }
        }
        if(myString.equals("B")){
          if(playedB == 0){
            ar.get(shuff.get(1)).play();
            playedB = 1;
            counter++;
            check = check +(shuff.get(1) +1);
            delay(500);
          }
        }
        if(myString.equals("C")){
          if(playedC == 0){
            ar.get(shuff.get(2)).play();
            playedC = 1;
            counter+=1;
            check = check +(shuff.get(2) +1);
            delay(500);;
          }
        }
        if(myString.equals("D")){
          if(playedD == 0){
            ar.get(shuff.get(3)).play();
            playedD = 1;
            counter+=1;
            check = check +(shuff.get(3) +1);
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
   playedA = 0;
   playedB = 0;
   playedC = 0;
   playedD = 0;
   if(check.equals("1234")){
     delay(500);
     correct.play();
     correct.rewind();
     ar.get(0).rewind();
     ar.get(1).rewind();
     ar.get(2).rewind();
     ar.get(3).rewind();
     ar.remove(0);
     ar.remove(0);
     ar.remove(0);
     ar.remove(0);
     mixed = false;
   }else{
     delay(500);
     wrong.play();
     wrong.rewind();
     ar.get(0).rewind();
     ar.get(1).rewind();
     ar.get(2).rewind();
     ar.get(3).rewind();
   }
   counter = 0;
   check = "";
 }else{
  
 }
}
