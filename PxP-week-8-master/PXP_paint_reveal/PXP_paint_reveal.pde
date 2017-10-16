// The world pixel by pixel 2016
// Daniel Rozin
// reveal effect with two images


int R, G, B, A;          // you must have these global varables to use the PxPGetPixel()
PImage ourImage, ourImage2;
void setup() {
  size(1280, 720);

  ourImage= loadImage("http://cdn.playbuzz.com/cdn/f721db4c-bdcf-4cbf-83e0-57f9d352b1ed/4330b72d-02e1-4947-b241-9bb4bf06a539.jpg");
  ourImage.resize(width, height);

  ourImage2= loadImage("http://www.kars4kids.org/blog/wp-content/uploads/2015/02/dogs.jpg");
  ourImage2.resize(width, height);
  ourImage2.loadPixels();                          // the image of the dogs will be revealed so we need to access its pixels

  image(ourImage, 0, 0);                          // the image of the cats is emmidiately drawn to the screen and we will never access it again
}

void draw() {              // move on, nothing here
}

void mouseDragged() {                               // for a painting operation the mouseDragged is the best place to put your code
  loadPixels();
  int radius= 50;                                   // this will be the radius of our brush  
  float transparancy = 0.1;                         // this will be the tranparency of the brush (1 = 100%)

  for (int x = mouseX-radius; x< mouseX+radius; x++) {           // visit all 50 pixels around the mouse
    for (int y = mouseY-radius; y< mouseY+radius; y++) {
      if (
        x>0 && x<width && y>0 && y<height                           // check that we are in the bounds of the window
        &&  dist (mouseX, mouseY, x, y )< radius) {                  // check that we are inside a bounding circle
        PxPGetPixel(x, y, ourImage2.pixels, width);                 // get the RGB of our pixel in the image of dogs
        float imageR = R *  transparancy;                          // mutiply the dogs values with the transparancy
        float imageG = G *  transparancy;
        float imageB = B *  transparancy;

        PxPGetPixel(x, y, pixels, width);                       // get the RGB of our pixel in the window (which has the cats drawn on it)                   
        float windowR = R *  (1-transparancy);                  // multiply the windows values with the compliment of our transparency (1- transparency)
        float windowG = G *  (1-transparancy);
        float windowB = B *  (1-transparancy);

        int newR = int( windowR+imageR);                        // add up the values of the multiplied RGBs
        int newG = int( windowG+imageG);
        int newB = int( windowB+imageB);
        PxPSetPixel(x, y, newR, newG, newB, 255, pixels, width);    // sets the R,G,B values to the window
      }
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