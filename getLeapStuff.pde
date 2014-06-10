PImage getKinectImage(){
 for (Finger finger : leap.getFingerList()) {
    PVector fingerPos = leap.getTip(finger);
    ellipse(fingerPos.x, fingerPos.y, 10, 10);
  } 
  
  returnImage = kinect.getVideoImage();
  return returnImage;
}
