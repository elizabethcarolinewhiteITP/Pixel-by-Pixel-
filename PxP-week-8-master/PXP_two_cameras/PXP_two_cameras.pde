// The world pixel by pixel 2016
// Daniel Rozin
// use 2 cameras

import processing.video.*;

Capture ourVideo, ourVideo2;   
void setup() {
  size(1280, 720);
  String[] cameras = Capture.list();
  for (int i = 0; i < cameras.length; i++)println (i + ":"+ cameras[i]);
  //ourVideo = new Capture(this, width, height, "FaceTime HD Camera");       // open first video in the size of window
  ourVideo = new Capture(this, width, height, cameras[0]);
  ourVideo.start();    
  //ourVideo2 = new Capture(this, width, height, "Logitech Camera");       // open second video in the size of window
  ourVideo2 = new Capture(this, width, height, cameras[15]);
  ourVideo2.start();
}

void draw() {
  background (0);
  if (ourVideo.available())  ourVideo.read();       // get a fresh frame of first video as often as we can
  if (ourVideo2.available())  ourVideo2.read();       // get a fresh frame of second video as often as we can
  image(ourVideo, 0, 0, mouseX, mouseY);
  image(ourVideo2, mouseX, mouseY, width- mouseX, height - mouseY);
}