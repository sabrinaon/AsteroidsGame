//your variable declarations here
SpaceShip sabrina;
Stars [] bling = new Stars[50];
ArrayList < Asteroid> rocks;
ArrayList <Bullet> bullets;
public void setup() 
{
  //your code here
  size(500,500);
  sabrina = new SpaceShip();
  for(int i=0; i < bling.length; i++)
  {
    bling[i] = new Stars();
  }
  rocks = new ArrayList <Asteroid>();
    for(int r=0; r < 10; r++)
    {
      rocks.add(new Asteroid());
    }
  bullets = new ArrayList <Bullet> () ;
}
public void draw() 
{
  //your code here
  background(0);
  sabrina.show();
  sabrina.move();
  for(int i=0; i <bling.length; i++)
  {
    bling[i].show();
  } 
  for(int i=0;i<bullets.size();i++)
    {
      bullets.get(i).show();
      bullets.get(i).move();
    }
   
    for(int i=0;i<rocks.size();i++)
    {

      if(dist(rocks.get(i).getX(),rocks.get(i).getY(),sabrina.getX(),sabrina.getY())<20)
      {
        rocks.remove(i);
        rocks.add(new Asteroid());
      }
      else 
      {
      rocks.get(i).show();
      rocks.get(i).move();
      }
    }
    for(int r=0;r<rocks.size();r++)
    {
      for(int i=0;i<bullets.size();i++)
      {
        if(dist(rocks.get(r).getX(),rocks.get(r).getY(),bullets.get(i).getX(),bullets.get(i).getY())<20)
        {
          rocks.remove(r);
          bullets.remove(i);
          rocks.add(new Asteroid());
        }
      }
    }
  }
public void keyPressed()
{
  if(key == 'h')
  {
  sabrina.setX((int)(Math.random()*499) + 50);
  sabrina.setY((int)(Math.random()*400) + 50);
  sabrina.setPointDirection((int)(Math.random()*360));
  sabrina.setDirectionX(0);
  sabrina.setDirectionY(0);
  }
  if(key == 'w')
  {
  sabrina.accelerate(Math.random());
  }
  if(key == 's')
  {
    sabrina.accelerate(-Math.random());
  }
  if(key == 'd')
  {
    sabrina.rotate(-10);
  }
  if(key == 'a')
  {
    sabrina.rotate(10);
  }
  if(key == ' ')
  {
    bullets.add(new Bullet(sabrina));
  }
}
class SpaceShip extends Floater  
{   
    //your code here
  public SpaceShip()
  {
    corners = 4;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = 0;
    yCorners[0] = 0;
    xCorners[1] = -6;
    yCorners[1] = -6;
    xCorners[2] = 12;
    yCorners[2] = 0;
    xCorners[3] = -6;
    yCorners[3] = 6;
    myColor = 255;
    myCenterX = 250;
    myCenterY = 250;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }
  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY = y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX = x;}
  public double getDirectionX(){return myDirectionX;}
  public void setDirectionY(double y){myDirectionY = y;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection = degrees;}
  public double getPointDirection(){return myPointDirection;}
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 
public class Stars
{
  int myX, myY, mySize;
  public Stars()
  {
    myX = (int)(Math.random()*width);
    myY = (int)(Math.random()*height);
    mySize = (int)(Math.random()*6);
  }
  public void show()
  {
    noStroke();
    fill(240,240,148);
    ellipse(myX, myY, mySize, mySize);
  }
}
class Asteroid extends Floater
  {
    private int rotSpeed;
    public Asteroid()
  {
    if(Math.random()<.5)
    {
      rotSpeed=2;
    }
    else 
    {
      rotSpeed=-2;      
    }
    corners = 6;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -11;
    yCorners[0] = -8;
    xCorners[1] = 7;
    yCorners[1] = -8;
    xCorners[2] = 13;
    yCorners[2] = 0;
    xCorners[3] = 6;
    yCorners[3] = 10;
    xCorners[4] = -11;
    yCorners[4] = 8;
    xCorners[5] = -5;
    yCorners[5] = 0;
    myCenterX=(int)(Math.random()*500);
    myCenterY=(int)(Math.random()*500);
    if(Math.random()>.5)
    {
      myDirectionX=1;
    }
    else
    {
      myDirectionX=-1;    
    }
    if(Math.random()>.5)
    {
      myDirectionY=1;
    }
    else
    {
      myDirectionY=-1;
    }
    myPointDirection=(int)(Math.random()*360);
    myColor=color(119,27,20);
    }
  public void setX(int x){myCenterX=x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY=y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX=x;}
  public double getDirectionX(){return myDirectionX;}
  public void setDirectionY(double y){myDirectionY=y;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection=degrees;}
  public double getPointDirection(){return myPointDirection;} 
  public void move()
  {
    rotate(rotSpeed);
    super.move();
  }
}
class Bullet extends Floater
{
  private int myColor;
  private double dRadians;
  public Bullet(SpaceShip theShip)
  {
    myCenterX=theShip.getX();
    myCenterY=theShip.getY();
    myPointDirection=theShip.getPointDirection();
    dRadians =myPointDirection*(Math.PI/180);
    myDirectionX=3*Math.cos(dRadians) + theShip.getDirectionX();
    myDirectionY=3*Math.sin(dRadians) + theShip.getDirectionY();
    myColor=color(23,145,129);
  }
  public void show()
  {
    noStroke();
    fill(myColor);
    ellipse((int)myCenterX,(int)myCenterY,10,10);
  }
      public void setX(int x){myCenterX=x;}
      public int getX(){return (int)myCenterX;}
      public void setY(int y){myCenterY=y;}
      public int getY(){return (int)myCenterY;}
      public void setDirectionX(double x){myDirectionX=x;}
      public double getDirectionX(){return myDirectionX;}
      public void setDirectionY(double y){myDirectionY=y;}
      public double getDirectionY(){return myDirectionY;}
      public void setPointDirection(int degrees){myPointDirection=degrees;}
      public double getPointDirection(){return myPointDirection;}  
}

