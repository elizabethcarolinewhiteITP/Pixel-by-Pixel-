// The world pixel by pixel 2016
// Daniel Rozin
// copying live video with transparancy to create ghosting effect usint tint()

import processing.video.*;

Capture ourVideo;          // variable to hold the video

void setup() {
  size(1280, 720);
  frameRate(120);
  ourVideo = new Capture(this, width, height);       // open default video in the size of window
  ourVideo.start();                                  // start the video
}

void draw() {
  if (ourVideo.available())  ourVideo.read();       // get a fresh frame of video as often as we can
  tint(255, 15);                                     // set a transparent white tint
  image(ourVideo, 0, 0);                              // draw the transparent live video over itself (to the window)
}