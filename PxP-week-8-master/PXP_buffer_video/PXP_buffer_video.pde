// The world pixel by pixel 2016
// Daniel Rozin
// buffering video frames

import processing.video.*;

int R, G, B, A;          // you must have these global varables to use the PxPGetPixel()
Capture ourVideo;          // variable to hold the video
int numOfFrames= 100;
PImage videoFrames[]= new PImage[numOfFrames];        // this will store all our frames in an array
int currentFrame=0;
void setup() {
  size(1280, 720);
  frameRate(120);
  ourVideo = new Capture(this, width, height);       // open default video in the size of window
  ourVideo.start();                                  // start the video
  for (int i = 0; i < numOfFrames; i++) {
    videoFrames[i]= createImage(width, height, RGB);  // we need to create al the PImages and place in the array
  }
}

void draw() {
  if (ourVideo.available())  ourVideo.read();       // get a fresh frame of video as often as we can
  currentFrame++;                                    // increment our counter
  currentFrame= currentFrame % numOfFrames;         // if we reach the end , roll over to 0
  videoFrames[currentFrame].copy(ourVideo, 0, 0, width, height, 0, 0, width, height);        // copy the current frame into the array
  // videoFrames[currentFrame].set(0,0,ourVideo);                                         // another way to copy the current frame into the array
  image(videoFrames[(currentFrame+1)%numOfFrames], 0, 0);                               // show the oldest frame on screen
  text(currentFrame, 10, 10);                                                    // show the counter
}