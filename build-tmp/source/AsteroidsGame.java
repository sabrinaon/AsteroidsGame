import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class AsteroidsGame extends PApplet {

//your variable declarations here
SpaceShip bob;
Stars [] bling;
public void setup() 
{
  //your code here
  size(500,500);
  bob = new SpaceShip();
  bling = new Stars[30];
  for(int i=0; i < bling.length; i++)
  {
    bling[i] = new Stars((int)(Math.random()*500),(int)(Math.random()*500));
  }
}
public void draw() 
{
  //your code here
  background(0);
  for(int i=0; i <bling.length; i++)
  {
    bling[i].show();
  } 
  bob.show();
  bob.move();
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
class Stars extends Floater
  {
  Stars(double a, double b)
  {
  corners = 10;
  xCorners = new int[corners];
  xCorners[0] = -1;
  xCorners[1] = 2;
  xCorners[2] = 2;
  xCorners[3] = 4;
  xCorners[4] = 7;
  xCorners[5] = 5;
  xCorners[6] = 7;
  xCorners[7] = 4;
  xCorners[8] = 2;
  xCorners[9] = 2;
  yCorners = new int[corners];
  yCorners[0] = 0;
  yCorners[1] = 1;
  yCorners[2] = 5;
  yCorners[3] = 2;
  yCorners[4] = 3;
  yCorners[5] = 0;
  yCorners[6] = -3;
  yCorners[7] = -2;
  yCorners[8] = -5;
  yCorners[9] = -1;
  myColor = 70;
  myCenterX = a;
  myCenterY = b;
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
public void keyPressed()
  {
  if(key == 'h')
  {
  bob.setX((int)(Math.random()*499) + 50);
  bob.setY((int)(Math.random()*400) + 50);
  bob.setPointDirection((int)(Math.random()*360));
  bob.setDirectionX(0);
  bob.setDirectionY(0);
  }
  if(key == 'a')
  {
  bob.accelerate(Math.random());
  }
  if(key == 'd')
  {
  bob.accelerate(-Math.random());
  }
  if(key == 'l')
  {
  bob.rotate(-10);
  }
  if(key == 'r')
  {
  bob.rotate(10);
  }
  }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "AsteroidsGame" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
