//Created by Taylor Williams

final private int DARK_GRAY = 51;  //RGB code: 0 is for black and 255 is for white. 51 is a very dark gray.
final private int LIGHT_GRAY = #999999;
final private int WHITE = 255;     //255 is #ffffff
final private int RED = #ff0000;
final private int ORANGE = #cc6600;


private float x;  //TRex x position
private float y;  //TRex y position
private float w;  //TRex width
private float h;  //TRex height
private float yVel; //TRex velocity (speed) of along y axis
private float yGravity; //TRex velocity along y axis due to gravity

private PImage TRexSprite;
private PImage TRexLeftUp;
private PImage TRexRightUp;
private PImage TRexDead;

private int score;
private int steps;
private boolean isBeginning;
private boolean isUpperKeyDisabled;
private boolean isDead;
private int timer;
private int stepTimer;

/* A Processing app starts with a method invocation to setup() and then will invoke draw() over and over again.  That is it!
 *  setup():  Initilize variables when app is started, only one time.
 *  draw():   Update variables. Executed over and over again.
 */
public void setup() 
{
  // Initilize the window size in setup().
  size(1000, 700);

  // Disable the layer.
  noStroke();
  
  reset();
}

/*
 * reset():  a method for game restart purpose. We always use reset() to reset data (such as position of the rectangle).
 */
public void reset()
{
  //TRex position reset
  w = 50;
  h = 50;
  x = 254; //381.97-129;
  y = 432.62-this.h;
  yVel = 0; //initially no speed along y axis
  yGravity = 0; //before player presses key up, no gravity

  score = 0;
  steps = 0;
  isBeginning = true;
  isUpperKeyDisabled = false;
  isDead = false;
}

/*  A method that will keep looping. 
 *  Any change to the game should happen here. 
 *  Note that drawing in Processing uses the rule of stack:
 *    - First shape/img will be at the bottom. 
 *    - Shape/image drawn later will be on top.
 */
public void draw() 
{ 
  background(LIGHT_GRAY); 
  displayInstruction();

  // Create other methods to simplify the code in draw().
  moveTRex();
  drawTRex();
  
  statBoard();
}

public void displayInstruction()
{
  if (isBeginning) {
    textSize(20);
    fill(ORANGE);
    text("Press the UP arrow key to start.", 680, 25); 
  }
}

/*
 * Update the (x, y) coordinates for the TRex.
 */
public void moveTRex()
{
  yVel += yGravity;
  y += yVel;

  //x += xVel;  //added for cactus collision

  checkBorder();
}

public void checkBorder()
{
  if (y < 0)
  {
    yVel = 0; 
    y = 1;
  }
  else if (y > 432.62 - this.h)   //If TRex falls below land, disable UpperKey.
  {
    yVel = 0; 
    y = 432.62 - this.h;
    isUpperKeyDisabled = false;
  }
}

/*
 * drawTRex by drawing shapes or load image
 */
public void drawTRex()
{
  TRexSprite = loadImage("trex_jump.png");  //move the first two lines into setup(), since they only need to be executed once. //Make it into gif
  TRexSprite.resize((int)w, (int)w);
  TRexLeftUp = loadImage("trex_leftUp.png");  //move the first two lines into setup(), since they only need to be executed once. //Make it into gif
  TRexLeftUp.resize((int)w, (int)w);
  TRexRightUp = loadImage("trex_rightUp.png");  //move the first two lines into setup(), since they only need to be executed once. //Make it into gif
  TRexRightUp.resize((int)w, (int)w);
  TRexDead = loadImage("trex_dead.png");  //move the first two lines into setup(), since they only need to be executed once. //Make it into gif
  TRexDead.resize((int)w, (int)w);
  if (isBeginning || isUpperKeyDisabled)
  {
    image(TRexSprite, x, y);
  }
  else if (!isDead) 
  {
    if (steps % 2 == 0)
    {
      image(TRexLeftUp, x, y);
    }
    else if (steps % 2 != 0)
    {
      image(TRexRightUp, x, y);
    }
  }
  else
  {
    image(TRexDead, x, y);
  }
}

public void updateScore()
{
  if (!isBeginning && !isDead)
  {
    if (millis() - stepTimer >= 100)
    {
      steps += 1; 
      stepTimer = millis();
    }
    if (millis() - timer >= 1000)
    {
      score += 1;
      timer = millis();
    }
  }
}

public void statBoard()
{ 
  updateScore();
  textSize(32);

  fill(204, 102, 0);
  text("TRex X: " + x, 10, 30); 

  fill(0, 102, 153);
  text("TRex Y: " + y, 10, 60);

  fill(204, 102, 0);
  text("Score: " + score, 10, 90);
}

/* Basic input that will update the data. In this case, the x and y speed.
*  Only variables should be changed in side this method.
*  TRex moving should be in draw() method.
*  If you want to update the game scene outside draw(), you can use redraw().
*/
public void keyPressed() 
{
  if (key == TAB || key == ENTER)
  {
    reset();
  } 
  else if (keyCode==UP)  
  {
    if (!isUpperKeyDisabled && !isDead)
    {
      yVel = -12.5;
      isUpperKeyDisabled = true; //everytime pressing UP key will disable UP key, so that it cannot jump up further while still in the air
    }
    if (isBeginning)
    {
      isBeginning = false;
      yGravity = 0.5; //0.5;
    }
  }
}
