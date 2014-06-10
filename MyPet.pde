import SimpleOculusRift.*;
import org.openkinect.*;
import org.openkinect.processing.*;

SimpleOculusRift   oculusRiftDev;
Kinect kinect;

float floorDist = 1.7;
boolean   fullScreen = false;

/* IMAGES */
PImage returnImage;
PImage bottomImage; //KiNECT IMAGE
PImage topImage;
PImage sideRImage;
PImage sideLImage;
PImage frontImage;
PImage backImage;


/* KINECT */
boolean rgb = true;
float[] depthLookUp = new float[2048];
int w = 640;
int h = 480;

float walkValueX = 0.9;
float walkValueY = 0;
float walkValueZ = -0.9;
float walk_X = 0.05;
float walk_Y = 0.05;
float walk_Z = 0.05;

/* LEAP MOTION */
ArrayList fingerArray = new ArrayList();

int zoom = 1;

void setup()
{
  if (fullScreen)
    size(1920, 1200, P3D);
  else    
    size(1280, 800, P3D);
  textureMode(NORMAL);

  oculusRiftDev = new SimpleOculusRift(this, SimpleOculusRift.RenderQuality_Middle); 
  oculusRiftDev.setBknColor(10, 13, 2);  // just not total black, to see the barrel distortion

  kinect = new Kinect(this);
  kinect.start();
  kinect.enableRGB(true);
  kinect.enableDepth(true);
  kinect.processDepthImage(false);
  
  backImage = loadImage("grossraumbehaelter_512.jpg");
  topImage = loadImage("grossraumbehaelter_512.jpg");
  sideLImage = loadImage("grossraumbehaelter_512.jpg");
  sideRImage = loadImage("grossraumbehaelter_512.jpg");
  frontImage = loadImage("grossraumbehaelter_512.jpg");
  
 for (int i = 0; i < depthLookUp.length; i++) {
    depthLookUp[i] = rawDepthToMeters(i);
  }
  drawPointCloud();
  strokeWeight(.3);
}

void draw()
{
  oculusRiftDev.draw();
} 

boolean sketchFullScreen() 
{
  return fullScreen;
}     

void keyPressed()
{
  if (key == CODED) {
    if (keyCode == UP) {
      println("UP");
      walkValueY = walkValueY+walk_Y;
    } else if (keyCode == DOWN) {
      println("DOWN");
      walkValueY = walkValueY-walk_Y;
    }
   if (keyCode == LEFT) {
      println("UP");
      walkValueX = walkValueX+walk_X;
    } else if (keyCode == RIGHT) {
      println("DOWN");
      walkValueX = walkValueX-walk_X;
    } 
    if (keyPressed) {
      if (key == 's' || key == 'S') {
        walkValueZ = walkValueZ+walk_Z;
      }
      if (key == 'X' || key == 'X'){
        walkValueZ = walkValueZ-walk_Z;
        println("walkValueZ");
      } 
  } else {
    println("reset head orientation");
    oculusRiftDev.resetOrientation();
  }
}
}

public void stop() {
  leap.stop();
}

