//Created by Taylor Williams

final private int DARK_GRAY = 51;  //RGB code: 0 is for black and 255 is for white. 51 is a very dark gray.
final private int LIGHT_GRAY = #999999;  //RGB code: 0 is for black and 255 is for white. 51 is a very dark gray.
final private int WHITE = 255;     //255 is #ffffff
final private int RED = #ff0000;   

private Landscape landscape;

//TRex object
private TRex trex;

//Step 1 (Declare an ArrayList)
private ArrayList<Cactus> cacti;

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

  landscape = new Landscape();
  //player position reset
  
  score = 0;
  steps = 0;
  isBeginning = true;
  isUpperKeyDisabled = false;
  isDead = false;
  
  //Step 2: Create Cactus arraylist. 
  //        Then create Cactus objects and add them to the array list.
  cacti = new ArrayList<Cactus>();
  
  //Create 8 Cactuss (4 pairs)
  int endOfLine=1000;
  for(int i=0;i<2;i++){
    //generates bottom Cactus
    float randomSpacing =  random(300, 501);   //randome int between 200 and 800
    
    endOfLine += (int) randomSpacing;
    Cactus bottomCactus = new Cactus(endOfLine);
    //adds both to the arraylist
    cacti.add(bottomCactus);
  }
  
  trex = new TRex(this);
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
  
  landscape.moveLandscape();
  landscape.drawLandscape();
  
  for (Cactus cactus: cacti)
  {
    cactus.moveCactus();
    cactus.drawCactus();
  }
  
  //Step 3: Make the draw method work on all Cactuss in the array list.
  for (Cactus cactus: cacti)
  {
    if (trex.checkCollision(cactus))
    {
      gameOver();
    }
  }
  
  if (isDead)
  {
    textSize(32);
    fill(DARK_GRAY);  
    text("GAME OVER", 425, 250);
    text("Play again? (Y/N)", 400, 300);
    if (keyPressed)
    {
      if (key == 'Y' || key == 'y')
      {
        reset();
      }
      else if (key == 'N' || key == 'n')
      {
        exit();
      }
    }
  }
  

  // Create other methods to simplify the code in draw().
  trex.moveTRex();
  trex.drawTRex();

  statBoard();
}

public void displayInstruction()
{
  if (isBeginning)
  {
    textSize(20);
    fill(204, 102, 0);
    text("Press the UP arrow key to start.", 680, 25); 
  }
}

public void gameOver()
{
  isDead = true; //ADDED 5/13

  for(Cactus cactus: cacti)
  {
    cactus.xVel = 0;
  }
  landscape.setVelocity(0);
  trex.y = 432.62 - trex.h;
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
  text("TRex X: " + trex.x, 10, 30); 

  fill(0, 102, 153);
  text("TRex Y: " + trex.y, 10, 60);

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
    if (!isUpperKeyDisabled && !isDead) //<>//
    {
      trex.yVel = -12.5;
      isUpperKeyDisabled = true; //everytime pressing UP key will disable UP key, so that it cannot jump up further while still in the air
    }
    
    if (isBeginning)
    {
      isBeginning = false;
      trex.yGravity = 0.5; //0.5;
      
      //step 4 : apply movement to all Cactuss.
      for (Cactus cactus: cacti)
      {
        cactus.xVel = -5;   
      } 
      landscape.setVelocity(-5);
    }
  }
}
