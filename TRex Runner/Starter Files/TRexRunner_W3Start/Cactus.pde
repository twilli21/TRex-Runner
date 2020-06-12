public class Cactus
{
  private float x;  //cactus x position 
  private float y;  //cactus y position 
  private float w;  //cactus width 
  private float h;  //cactus height 
  private float xVel;  //cactus velocity (speed) along x axis
  private PImage cactusImage;
  private PImage[] cactusImages;
  
  public Cactus(int x)
  {
    this.w = 40;
    this.h = 80;
    this.x = x;
    this.y = 432.62-this.h;
    this.xVel = 0;
    this.cactusImages = new PImage[3];
    this.cactusImages[0] = loadImage("cactus1.png");
    this.cactusImages[0].resize((int)this.w, (int)this.h);
    this.cactusImages[1] = loadImage("cactus2.png");
    this.cactusImages[1].resize((int)this.w+40, (int)this.h);
    this.cactusImages[2] = loadImage("cactus3.png");
    this.cactusImages[2].resize((int)this.w+60, (int)this.h);
    int randomIndex = (int)random(0,3);
    this.cactusImage = this.cactusImages[randomIndex];
    if (randomIndex == 0 || randomIndex == 1)
    {
      this.y = 432.62-this.h + 10;
    }
    else if (randomIndex == 2)
    {
      this.y = 432.62-this.h + 20;
    }
  }
  
  public void drawCactus()
  {
    image(this.cactusImage, this.x, this.y);
  }
  
  public void moveCactus()
  {
    this.x += this.xVel;
    // if the Cactus goes off-screen, reset its position.
    if (this.x + this.w < 0)
    {
      this.respawn();
    }
  }
  
  public void respawn()
  {
    int randomSpacing =  (int)random(300, 501);
    this.x = 1250 + randomSpacing;
    int randomIndex = (int)random(0,3);
    if (randomIndex == 0)
    {
      this.cactusImage = this.cactusImages[randomIndex];
      this.cactusImage.resize((int)this.w, (int)this.h);
      this.y = 432.62-this.h + 10;
    }
    else if (randomIndex == 1)
    {
      this.cactusImage = this.cactusImages[randomIndex];
      this.cactusImage.resize((int)this.w+40, (int)this.h);
      this.y = 432.62-this.h + 10;
    }
    else if (randomIndex == 2)
    {
      this.cactusImage = this.cactusImages[randomIndex];
      this.cactusImage.resize((int)this.w+60, (int)this.h);
      this.y = 432.62-this.h + 20;
    }
  }
}
