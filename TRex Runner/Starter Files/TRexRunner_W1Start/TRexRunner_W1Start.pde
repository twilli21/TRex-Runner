//Created by Taylor Williams

final private int DARK_GRAY = 51;  //RGB code: 0 is for black and 255 is for white. 51 is a very dark gray.
final private int LIGHT_GRAY = #999999;
final private int WHITE = 255;     //255 is #ffffff
final private int RED = #ff0000; 
final private int ORANGE = #cc6600;

final private int MOVE_SPEED = 10;

private float x;  //TRex x position
private float y;  //TRex y position
private float w;  //TRex width
private float h;  //TRex height
private float xVel; //velocity (speed) along x axis
private float yVel; //velocity (speed) along y axis

/* A Processing app starts with a method invocation to setup() and then will invoke draw() over and over again. That is it!
 *  setup():  Initilize variables when app is started, only one time.
 *  draw():   Update variables. Executed over and over again.
 */
public void setup() 
{
  // Initilize the window size in setup().
  size(1000, 700);
  
  // Disable the layer.
  noStroke();
  
  //TRex initial position
  w = 50;
  h = 50;
  x = 254; //381.97-129;
  y = 432.62-this.h;
  xVel = 0; //initially no speed along x axis
  yVel = 0; //initially no speed along y axis
}

/* A method that will keep looping. 
 *  Any change to the game should happen here. 
 *  Note that drawing in Processing uses the rule of stack:
 *    - First shape/img will be at the bottom. 
 *    - Shape/image drawn later will be on top.
 */
public void draw() 
{ 
  background(LIGHT_GRAY); 

  textSize(20);
  fill(ORANGE);  
  text("Press the UP arrow key to start.", 680, 25);
  
  // move the TRex by adjusting the x and y coordinates. For the next iteration, TRex will be drawn on the new (x, y) location
  x += xVel;
  y += yVel;
  
  // draw a TRex
  //fill color will be applied to the shapes created after until the fill color changes
  fill(WHITE);
  rect(x, y, w, h);
  circle(x+10, y, h);
  fill(RED);  
  circle(x+25, y, h);
}

/* Basic input that will update the data. In this case, the x and y speed.
*  Only variables should be changed in side this method.
*  Bird moving should be in draw() method.
*  If you want to update the game scene outside draw(), you can use redraw().
*/
public void keyPressed() 
{ 
    if (keyCode==UP) 
    {
      yVel = -MOVE_SPEED;
      xVel = 0;
    }
    else if (keyCode==DOWN) 
    {
      yVel = MOVE_SPEED;
      xVel = 0;
    }
    else if (keyCode==LEFT) 
    {
      xVel = -MOVE_SPEED;
      yVel = 0;
    }
    else if (keyCode==RIGHT) 
    {
      xVel = MOVE_SPEED;
      yVel = 0;
    }
}


void keyReleased() 
{
  if (keyCode == LEFT || keyCode == RIGHT) {
    xVel = yVel = 0;
  }
}
