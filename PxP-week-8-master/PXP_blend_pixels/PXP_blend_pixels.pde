// The world pixel by pixel 2016
// Daniel Rozin
// blending two images pixel by pixel

import processing.video.*;

int R, G, B, A;          // you must have these global varables to use the PxPGetPixel()
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
  ourVideo.loadPixels();                            // we need access to all 3 sets of pixels: the video, the image, the window
  ourImage.loadPixels();
  loadPixels();
  float transparancy = map (mouseX, 0, width, 0, 1);      // lets get a number 0-1  for the transparancy
  for (int x = 0; x< width; x++) {                        // visit all pixels
    for (int y = 0; y< height; y++) {
      PxPGetPixel(x, y, ourVideo.pixels, width);                 // get the RGB of our pixel in the video
      float videoR = R *  transparancy;                       // multiply the video values by the transwparancy
      float videoG = G *  transparancy;  
      float videoB = B *  transparancy;

      PxPGetPixel(x, y, ourImage.pixels, width);           // get the pixel value in the image
      float imageR = R *  (1-transparancy);                // multiply the image values by the opacity (1-transparency) 
      float imageG = G *  (1-transparancy);
      float imageB = B *  (1-transparancy);

      int newR = int( videoR+imageR);                    // add them all together
      int newG = int( videoG+imageG);
      int newB = int( videoB+imageB);
      PxPSetPixel(x, y, newR, newG, newB, 255, pixels, width);    // sets the R,G,B values to the window
    }
  }
  updatePixels();
}



// our function for getting color components , it requires that you have global variables
// R,G,B   (not elegant but the simples way to go, see the example PxP methods in object for 
// a more elegant solution)

void PxPGetPixel(int x, int y, int[] pixelArray, int pixelsWidth) {
  int thisPixel=pixelArray[x+y*pixelsWidth];     // getting the colors as an int from the pixels[]
  A = (thisPixel >> 24) & 0xFF;                  // we need to shift and mask to get each component alone
  R = (thisPixel >> 16) & 0xFF;                  // this is faster than calling red(), green() , blue()
  G = (thisPixel >> 8) & 0xFF;   
  B = thisPixel & 0xFF;
}


//our function for setting color components RGB into the pixels[] , we need to define the XY of where
// to set the pixel, the RGB values we want and the pixels[] array we want to use and it's width

void PxPSetPixel(int x, int y, int r, int g, int b, int a, int[] pixelArray, int pixelsWidth) {
  a =(a << 24);                       
  r = r << 16;                       // We are packing all 4 composents into one int
  g = g << 8;                        // so we need to shift them to their places
  color argb = a | r | g | b;        // binary "or" operation adds them all into one int
  pixelArray[x+y*pixelsWidth]= argb;    // finaly we set the int with te colors into the pixels[]
}