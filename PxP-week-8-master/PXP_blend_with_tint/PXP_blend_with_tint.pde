// The world pixel by pixel 2016
// Daniel Rozin
// blending two images with tint()

import processing.video.*;


Capture ourVideo;          // variable to hold the video
PImage ourImage;
void setup() {
  size(1280, 720);
  frameRate(120);
  ourVideo = new Capture(this, width, height);       // open default video in the size of window
  ourVideo.start();                                  // start the video

  ourImage= loadImage("http://cdn.playbuzz.com/cdn/f721db4c-bdcf-4cbf-83e0-57f9d352b1ed/4330b72d-02e1-4947-b241-9bb4bf06a539.jpg");
  ourImage.resize(width, height);
}

void draw() {
  if (ourVideo.available())  ourVideo.read();       // get a fresh frame of video as often as we can
  float transparancy = map (mouseX, 0, width, 0, 255);   // define a transparancy value 0-255
  tint (255);                                            // define a tint with full opacityu for the first image()
  image(ourVideo, 0, 0);                                  // copy the cats image in full opacity
  tint (255,transparancy);                            // define a tint with white and some transparancy
  image(ourImage, 0, 0);                                 // copy the live video above with the transparent tint
}