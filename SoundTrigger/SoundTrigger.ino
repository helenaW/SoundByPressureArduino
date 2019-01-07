
// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
}

// the loop routine runs over and over again forever:

void loop() {
  // read the input on analog pin 0:
  int sensorValue = analogRead(A0);
  /* int sensorValue1 = analogRead(A1);
     int sensorValue2 = analogRead(A2);
     int sensorValue3 = analogRead(A3);
   */
  // print out the value you read:
    Serial.println(sensorValue);
    /*Serial.println(sensorValue1);
    Serial.println(sensorValue2);
    Serial.println(sensorValue3);*/
   if(sensorValue > 100) {
     Serial.println("A"); // send the letter T (for Trigger) once the sensor value is bigger than 100  
    }
    /* if (sensorValue1 > 100){
        Serial.println("B");
       if(sensorValue2 > 100) {
        Serial.println("C");   
       }
       if(sensorValue3 > 100) {
        Serial.println("D");   
       }
     */
  delay(1);        // delay in between reads for stability
}
