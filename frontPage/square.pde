class Square
{
  float x, y;
  float dimensions;
  int startingDimensions;
  float speed;
  int direction = (int(random(0,2)) % 2 == 0) ? 1 : -1; //start from random direction
  
  int bufferSize;
  float[] posBuffer = new float[bufferSize];
  float[] dimentionBuffer = new float[bufferSize];
  int indexPos = 0;
  
  //constructor
  Square(float a_x, float a_dimensions, float a_speed, int a_bufferSize)
  {
    dimensions = a_dimensions;
    startingDimensions = int(a_dimensions);
    x = a_x;
    y = (int(random(0,2)) % 2 == 0) ? height-(startingDimensions*2) : (startingDimensions*2);
    speed = a_speed;
    bufferSize = a_bufferSize;
  }
  
  void move()
  {
    y += (speed * direction);
    if((y > (height - dimensions/2)) || (y < dimensions/2))
    {
      direction *= -1;
    }
  }
  
  void display(float squareSize)
  {
    posBuffer[indexPos] = y;
    dimentionBuffer[indexPos] = (squareSize/1.5)+5;
  
    //cycle between 0 and bufferSize
    indexPos = (indexPos + 1) % bufferSize;
  
    for(int i = 0; i < bufferSize; i++)
    {
      int pos = (indexPos + i) % bufferSize;
      int alpha = i*(256/bufferSize);
    
      fill(200,int(squareSize*10)-20,90,alpha/1.1);
      noStroke();
      //stroke(10,10,10, alpha);
      rectMode(CENTER);
      rect(x, posBuffer[pos], dimentionBuffer[pos], dimentionBuffer[pos]);
    }
  }
}