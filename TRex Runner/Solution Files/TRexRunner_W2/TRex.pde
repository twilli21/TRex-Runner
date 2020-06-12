public class TRex
{
  private TRexRunner_W2 game;
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
  
  public TRex(TRexRunner_W2 game)
  {
    //TRex position reset
    w = 50;
    h = 50;
    x = 254; //381.97-129;
    y = 432.62-this.h;
    yVel = 0; //initially no speed along y axis
    yGravity = 0; //before player presses key up, no gravity
    
    TRexSprite = loadImage("trex_jump.png");  //move the first two lines into setup(), since they only need to be executed once. //Make it into gif
    TRexSprite.resize((int)w, (int)w);
    TRexLeftUp = loadImage("trex_leftUp.png");  //move the first two lines into setup(), since they only need to be executed once. //Make it into gif
    TRexLeftUp.resize((int)w, (int)w);
    TRexRightUp = loadImage("trex_rightUp.png");  //move the first two lines into setup(), since they only need to be executed once. //Make it into gif
    TRexRightUp.resize((int)w, (int)w);
    TRexDead = loadImage("trex_dead.png");  //move the first two lines into setup(), since they only need to be executed once. //Make it into gif
    TRexDead.resize((int)w, (int)w);
  }
  
  /*
   * Update the (x, y) coordinates for the TRex.
   */
  public void moveTRex()
  {
    yVel += yGravity;
    y += yVel;
  
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
  
  boolean checkCollision(Cactus cactus)
  {
    // A) detecting when the TRex is in a position that intersects with the vertical side of a cactus.
    if (((this.x + this.w) >= cactus.x) && ((this.x + this.w) <= (cactus.x + 10)) && ((this.y + this.h) > cactus.y) && (this.y <= (cactus.y + cactus.h)))
    {
      //this.xVel = -5;
      return true;
    }
    // B) detecting when the TRex is in a position that intersects with a downwards cactus.
    else if (((this.x + this.w) >= cactus.x) && (this.x <= (cactus.x + cactus.w)) && ((this.y + this.h) > cactus.y) && ((this.y + this.h) <= (cactus.y + 20)))
    {
      this.y -= 1;
      this.yVel = 0;
      this.yGravity = 0;
      return true;
    }
    else if (((this.x + this.w) >= cactus.x) && (this.x <= (cactus.x + cactus.w)) && ((this.y < (cactus.y + cactus.h)) && (this.y >= (cactus.y + cactus.h - 20))))
    {
      this.yVel = 0;
      return true;
    }
    else
    {
      // there is no collision, and we reset the TRex's y-velocity and y-acceleration to their default values.
      //this.xVel = (this.x < 300) ? 3 : 0;
      if (!isBeginning)
      {
        this.yGravity = 0.5;
      }
      return false;
    }    
  }
}
