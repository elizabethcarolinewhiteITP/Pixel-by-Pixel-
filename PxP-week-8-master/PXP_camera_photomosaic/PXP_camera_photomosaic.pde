// The world pixel by pixel 2016
// Daniel Rozin
// creating a photo mosaic with "frames" of live video
// click mouse to take new snapshot
import processing.video.*;

Capture ourVideo;                                          // variable to hold the video
int numOfCells= 40;                                        // this means 40 across and 40 down 1600 total
int cellX, cellY;                                          // this will hold the size of each little cell
Cell [] cells = new Cell[0];                               // an array of our objects Cell
void setup() {
  size(1280, 720);
  frameRate(120);
  ourVideo = new Capture(this, width, height);           // open default video in the size of window
  ourVideo.start();                                       // start the video
  cellX = width/ numOfCells;
  cellY = height/ numOfCells;
  cells= (Cell[]) append(cells, new Cell() );            // one cell to start with
}

void draw() {
  if (ourVideo.available())  ourVideo.read();           // get a fresh frame of video as often as we can
  background (0);
  ourVideo.loadPixels();                               // load the pixels array of the video 
  for (int x = 0; x<width; x+= cellX) {                // visit every cell 
    for (int y = 0; y<height; y+= cellY) {
      PxPGetPixel(x, y, ourVideo.pixels, width);        // get the RGB of that point
      float recordSimilarity = 100000;                  // this variable will hold the best similarity
      int mostSimilarCell=0;                            // this variable will hold the number of the cell with the best similarity
      for (int thisCell = 0; thisCell< cells.length; thisCell++) {    // visit all our cells in the array
        float thisSimilarity = cells[thisCell].getSimilarity(R, G, B);   // get the similarity of that cell to the current RGB
        if (thisSimilarity < recordSimilarity) {
          recordSimilarity= thisSimilarity;
          mostSimilarCell= thisCell;
        }
      }
      image ( cells[mostSimilarCell].cellImage, x, y);       // draw the most similar cell to the screen
    }
  }                                    
  image (ourVideo, 0, 0, 200, 100);                       // SHOW THE LIVE VIDEO IN THE CORNER
}

class Cell {                            // class to hold a cell
  int cellR, cellG, cellB;              // variables to hold the average RGB of the cell
  PImage cellImage;                     // variable to hold the pic of the cell
  Cell() {                                         // constructor, this will be caled when we call new()
    cellImage= createImage(cellX, cellY, ARGB);        // create an empty smalll pimage
    cellImage.copy(ourVideo, 0, 0, width, height, 0, 0, cellX, cellY);  // copy the curent video into the pic
    cellImage.loadPixels();
    int sumR=0, sumG= 0, sumB= 0, divider = cellX*cellY;
    for (int x = 0; x<cellX; x++) {                     // calculate the average RGB
      for (int y = 0; y<cellY; y++) {
        PxPGetPixel(x, y, cellImage.pixels, cellImage.width);
        sumR+= R;
        sumG+= G;
        sumB+= B;
      }
    }
    cellR= sumR/divider;
    cellG= sumG/divider;
    cellB= sumB/divider;
  }

  float getSimilarity(int r, int g, int b) {            // caculate the similarity between the cell's RGB and the current ount RGB
    return dist (cellR, r, cellG, g, cellB, b);
  }
}

void mousePressed() {                                  // every time we click we add a cell to the array
  cells= (Cell[]) append(cells, new Cell() );
  println(cells.length);
}

// our function for getting color components , it requires that you have global variables
// R,G,B   (not elegant but the simples way to go, see the example PxP methods in object for 
// a more elegant solution
int R, G, B, A;          // you must have these global varables to use the PxPGetPixel()
void PxPGetPixel(int x, int y, int[] pixelArray, int pixelsWidth) {
  int thisPixel=pixelArray[x+y*pixelsWidth];     // getting the colors as an int from the pixels[]
  A = (thisPixel >> 24) & 0xFF;                  // we need to shift and mask to get each component alone
  R = (thisPixel >> 16) & 0xFF;                  // this is faster than calling red(), green() , blue()
  G = (thisPixel >> 8) & 0xFF;   
  B = thisPixel & 0xFF;
}


//our function for setting color components RGB into the pixels[] , we need to efine the XY of where
// to set the pixel, the RGB values we want and the pixels[] array we want to use and it's width

void PxPSetPixel(int x, int y, int r, int g, int b, int a, int[] pixelArray, int pixelsWidth) {
  a =(a << 24);                       
  r = r << 16;                       // We are packing all 4 composents into one int
  g = g << 8;                        // so we need to shift them to their places
  color argb = a | r | g | b;        // binary "or" operation adds them all into one int
  pixelArray[x+y*pixelsWidth]= argb;    // finaly we set the int with te colors into the pixels[]
}