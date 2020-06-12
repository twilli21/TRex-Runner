public class Sand
{
  // sand variables
  private int id;
  private float x;  //sand x position 
  private float y;  //sand y position 
  private float w;  //sand width 
  private float h;  //sand height 
  private float xVel;  //sand velocity (speed) along x axis

  public Sand(int id)
  {
    float h = 1;
    this.xVel = 0;
    this.id = id;
    this.w = random(10,25);
    this.h = h;
    this.x = (this.id * 200)+random(50,151);
    this.y = 432.62 + random(17,218);
  }
  
  public void drawSand()
  {
    // color the sand Dark Gray.
    fill(DARK_GRAY);
    // draw a rectangle according to the sand's dimensions.
    rect(this.x, this.y, this.w, this.h);
  }
  
  // method to draw the sand
  public void moveSand()
  {
    this.x += this.xVel;
  }
}
