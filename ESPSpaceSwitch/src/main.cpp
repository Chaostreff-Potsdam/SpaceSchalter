#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>

#define SSID "freifunk-potsdam.de"
#define SWITCH D7
#define LED_PIN D1

// ICACHE_RAM_ATTR void handleInterrupt(){
//   int status = digitalRead(SWITCH);
//   //Serial.println("Status:");
//   digitalWrite(LED_PIN, status);
// }

void setup() {

  Serial.begin(115200);
  pinMode(SWITCH, INPUT);
  pinMode(LED_PIN, OUTPUT);
  WiFi.begin(SSID);
  // attachInterrupt(SWITCH
  //     , handleInterrupt, CHANGE);
  while (WiFi.status() != WL_CONNECTED)
    delay(1000);
  Serial.println("Wifi connected!");
  digitalWrite(LED_PIN, HIGH);
  delay(500);
  digitalWrite(LED_PIN, LOW);
  delay(500);
  digitalWrite(LED_PIN, HIGH);
  delay(500);
  digitalWrite(LED_PIN, LOW);
}
int last_status = 0;
HTTPClient http;
void loop() {
  int status = digitalRead(SWITCH);
  if (status != last_status)
  {
    last_status = status;
    digitalWrite(LED_PIN, status);
    Serial.print("Status: ");
    Serial.println(status);

    // if ((WiFi.status() !== WL_CONNECTED))
    http.begin("http://ptsv2.com/t/rq03g-1583006342/post");
    http.addHeader("Content-Type", "text/plain");
    String message = status == 1 ? "Offen :)" : "Geschlossen :(";
    int httpCode = http.POST(message);
    Serial.println(httpCode);
    http.end();

  }
  // digitalWrite(LED_PIN, HIGH);
  Serial.print(status);
  delay(1000);
}