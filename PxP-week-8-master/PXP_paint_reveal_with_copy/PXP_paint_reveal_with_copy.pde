// The world pixel by pixel 2016
// Daniel Rozin
// reveal effect with two images using copy


PImage ourImage, ourImage2;
void setup() {
  size(1280, 720);
  ourImage= loadImage("http://cdn.playbuzz.com/cdn/f721db4c-bdcf-4cbf-83e0-57f9d352b1ed/4330b72d-02e1-4947-b241-9bb4bf06a539.jpg");
  ourImage.resize(width, height);

  ourImage2= loadImage("http://www.kars4kids.org/blog/wp-content/uploads/2015/02/dogs.jpg");
  ourImage2.resize(width, height);

  image(ourImage, 0, 0);                          // the image of the cats is emmidiately drawn to the screen and we will never access it again
}

void draw() {              // move on, nothing here
}
void mouseDragged() {                               // for a painting operation the mouseDragged is the best place to put your code
  int brushSize= 50;                                   // this will be the size of our brush  
  tint(255, 10);
  copy (ourImage2, mouseX-brushSize/2, mouseY-brushSize/2, brushSize, brushSize, mouseX-brushSize/2, mouseY-brushSize/2, brushSize, brushSize);          // copy the same rect from the image to the screen (sorry no transparancy here)
  //  blend (ourImage2, mouseX-brushSize/2, mouseY-brushSize/2, brushSize, brushSize, mouseX-brushSize/2, mouseY-brushSize/2, brushSize, radius,OVERLAY);  // try other modes too
}