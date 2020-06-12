public class Landscape
{ 
  private float xVel;
  private LandscapeSegment[] segments;
  private Sand[] sand;

  
  //constructor for defined Cactus location and size.
  public Landscape()
  {
    segments = new LandscapeSegment[8];
    sand = new Sand[8];
    segments[0] = new LandscapeSegment(0);
    segments[1] = new LandscapeSegment(1);
    segments[2] = new LandscapeSegment(2);
    segments[3] = new LandscapeSegment(3);
    segments[4] = new LandscapeSegment(4);
    segments[5] = new LandscapeSegment(5);
    segments[6] = new LandscapeSegment(6);
    segments[7] = new LandscapeSegment(7);
    sand[0] = new Sand(0);
    sand[1] = new Sand(1);
    sand[2] = new Sand(2);
    sand[3] = new Sand(3);
    sand[4] = new Sand(4);
    sand[5] = new Sand(5);
    sand[6] = new Sand(6);
    sand[7] = new Sand(7);
  }
  
  // method to draw the Landscape
  public void drawLandscape()
  {
    for (LandscapeSegment s: segments)
    {
      s.drawLandscapeSegment();
    }
    for (Sand pieces: sand)
    {
       pieces.drawSand(); 
    }
  }
  
  public void setVelocity(float xVel)
  {
    this.xVel = xVel;
    for (LandscapeSegment s: segments)
    {
      s.xVel = xVel;
    }
    for (Sand pieces: sand)
    {
       pieces.xVel = xVel; 
    }
  }
  
  
  // method to scroll the Landscape
  public void moveLandscape()
  {
    for (LandscapeSegment s: segments)
    {
      s.moveLandscapeSegment();
      if (s.x + s.w <= 0)
      {
        s.x = 7 * 200; //set to the id 7's orginal location
      }
    }
    for (Sand pieces: sand)
    {
      pieces.moveSand();
      if (pieces.x + pieces.w <= 0)
      {
        pieces.x = (7 * 200)+random(50,151); //set to the id 7's orginal location
      }
    }
  }
}
