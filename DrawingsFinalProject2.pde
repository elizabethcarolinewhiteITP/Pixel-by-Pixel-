
import processing.sound.*;
SoundFile file;

int[][] paintingsPixels;
int[][] values;
float angle;
float motion;
float run;
PImage painting;
int i;
int randomVar;
float newZ;
float newX;
float newY;
float newZ2;
float newX2;
float newY2;
PImage drawing;


void setup() {
  size(1000, 860, P3D);
  noCursor();
  frameRate(20);

  paintingsPixels = new int[width][height];
  values = new int[width][height];
  noFill();

  painting = loadImage( i + ".jpg" );  
  painting.resize(width, height);
  painting.loadPixels();
  for (int h = 0; h < painting.height; h++) {
    for (int j = 0; j < painting.width; j++) {
      paintingsPixels[j][h] = painting.pixels[h*painting.width + j];
      values[j][h] = int(blue(paintingsPixels[j][h]));
    }
  }
  //drawing = loadImage("0.jpg");

  //file = new SoundFile(this, "RunawayHorses.mp3");
  //file.play();
}


void draw() {

  background(0);
  translate(0, 0, -height/2-600);
  scale(1.7);
  angle += 0.01;
  //rotateY(angle);  
  run += 0.01;
  motion = noise(run)*700;

 if (keyPressed) {
        motion = 0;
        randomVar = 0;
        newX=0;
        newY=0;
        newZ=0;
        newX2=0;
        newY2=0;
        newZ2=0;
        for (int x = 0; x < painting.height; x ++) {
          for (int y = 0; y < painting.width; y ++) {
            point(x, y);
          }
        }
      }

  for (int h = 0; h < painting.height; h += 4) {
    for (int j = 0; j < painting.width; j += 4) {
      stroke(values[j][h], 255);
      strokeWeight(0.05);

      newX=(j-painting.width/2)+random(motion);
      newY=(h-painting.height/2)+random(motion);
      newZ=(-values[j][h]);

      newX2=(j-painting.width/2);
      newY2=(h-painting.height/2);
      newZ2=0;
      
      line(newX, newY, newZ, newX2+random(motion), newY2+random(motion), newZ2);
    }
  }
 
}



//void keyPressed() {
//  i++;
//  if (i == 7) {
//    i=0;
//  }
//  painting = loadImage( i + ".jpg" );  
//  painting.resize(width, height);
//  painting.loadPixels();
//  for (int h = 0; h < painting.height; h++) {
//    for (int j = 0; j < painting.width; j++) {
//      paintingsPixels[j][h] = painting.pixels[h*painting.width + j];
//      values[j][h] = int(blue(paintingsPixels[j][h]));
//    }
//  }
//}