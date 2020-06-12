public class LandscapeSegment
{
  // LandscapeSegment variables
  private int id;
  private float x;  //LandscapeSegment x position 
  private float y;  //LandscapeSegment y position 
  private float w;  //LandscapeSegment width 
  private float h;  //LandscapeSegment height 
  private float xVel;  //LandscapeSegment velocity (speed) along x axis
  
  //constructor for defined LandscapeSegment location and size.
  public LandscapeSegment(int id)
  {
    float y = 432.62;
    //0, 432.62, 1000, 1, 0
    this.xVel = 0;
    this.id = id;
    this.w = 1000/5;  //window width /# segments
    this.h = 1;
    this.x = this.id * 200;
    if (id == 0 || id == 4) {
       this.y = y;
    }
    else if (id == 1 || id == 3 || id == 5 || id == 7) {
       this.y = y+1;
    }
    else if (id == 2 || id == 6) {
       this.y = y-1;
    }
  }
  
  public void setVelocity(float xVel)
  {
    this.xVel = xVel;
  }
  
  // method to draw the LandscapeSegment
  public void drawLandscapeSegment()
  {
    // color the LandscapeSegment Dark Gray.
    fill(DARK_GRAY);
    // draw a rectangle according to the Cactus's dimensions.
    rect(this.x, this.y, this.w, this.h);
  }
  
    // method to draw the LandscapeSegment
  public void moveLandscapeSegment()
  {
    this.x += this.xVel;
  }
}
