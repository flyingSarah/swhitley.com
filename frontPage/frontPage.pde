AmpFollower ampFollower;
PImage img;
float imgW;
float imgH;

var canvas = document.getElementById("canvasSketch");

void setup()
{
  background(0,0);
  frameRate(15);

  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
  
  setSizes(canvas.width,canvas.height);
  
  ampFollower = new AmpFollower();
  
  window.addEventListener("orientationchange", function () {
    orientationDidChange = true;
  });
  
  window.addEventListener("resize", resizeEvent);
}



function resizeEvent()
{
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
  size(canvas.width, canvas.height);
  int w = canvas.width;
  int h = canvas.height;
  setSizes(w,h);
}

void setSizes(int w, int h)
{
  noLoop();
   
  size(w, h);

  img = loadImage("./../images/pinkstar-yellowflower.jpg");
  //set original image size
  img.width = 1000;
  img.height = 800;  
  //resize image proportionally
  if(w > img.width || h < img.width)
  {
    img.resize(w, 0);
  }
  
  if(h > img.height)
  {
    img.resize(0, h);
  }
  
  imgW = img.width;
  imgH = img.height;
    
  setupSquares(w);
  
  loop();
}

void draw()
{
  float amp = getAmplitude();
  int r = 255 - int(amp*100);
  tint(r, 255, 255);
  image(img,0,0,imgW,imgH);
  
  drawSquares(amp);
}

void mousePressed()
{
  try
  {
    ampFollower.playSound();
  }
  catch(err){}
}

float getAmplitude()
{
  boolean audioReady = ampFollower.isAudioReady();
  
  if(audioReady)
  {
    return ampFollower.getAmp();
  }
  return -1;
}

//-------------------------------- Squares!!! -------------------------------
Square[] squares;
int squareSpacing;
int squareStartingDimensions;

void setupSquares(int w)
{
  int numSquares = 30;
  squareSpacing = 2;
  squareStartingDimensions = w/numSquares/squareSpacing;
  squares = new Square[numSquares];
  
  for(int i = 0; i < squares.length; i++)
  {
    float x = (squareStartingDimensions/2 + i*squareStartingDimensions)*squareSpacing;
    float rate = random(8.0, 30.0);
    squares[i] = new Square(x,squareStartingDimensions,rate,25); //x,y,diameter,speed
  }
}

void drawSquares(float changingValue)
{
  float dim;
  
  //if there has been an error getting the preferred changing value
  if(changingValue == -1)
  {
    dim = squareStartingDimensions; 
  }
  else
  {
    dim = (squareStartingDimensions * changingValue) + (squareStartingDimensions/2);
  }
  
  for(int i = 0; i < squares.length; i++)
  {
    squares[i].move();
    squares[i].display(dim);
  }
}