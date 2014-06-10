void onDrawScene(int eye)
{  
  PVector orientation = oculusRiftDev.sensorOrientation();
  getLeapStuff();
  stroke(200, 200, 220);
  fill(100, 100, 220);
  
  drawGrid(new PVector(0, -floorDist, 0), 10, 10);

  fill(100, 20, 100);
  
  pushMatrix();
  
  translate(walkValueX, walkValueY, walkValueZ);
  
  rotateY(radians(orientation.y));
  rotateX(radians(orientation.x));
  rotateZ(radians(180));
  
  bottomImage = getKinectImage();
  
  beginShape(QUADS);
  texture(frontImage);
  // +Z "Front" face
  vertex(-zoom, -zoom, zoom, 0, 0);
  vertex( zoom, -zoom, zoom, zoom, 0);
  vertex( zoom, zoom, zoom, zoom, zoom);
  vertex(-zoom, zoom, zoom, 0, zoom);
  endShape();
  
  beginShape(QUADS);
  texture(backImage);
  // -Z "back" face
  vertex( zoom, -zoom, -zoom, 0, 0);
  vertex(-zoom, -zoom, -zoom, zoom, 0);
  vertex(-zoom, zoom, -zoom, zoom, zoom);
  vertex( zoom, zoom, -zoom, 0, zoom);
  endShape();
  
  beginShape(QUADS);
  texture(sideRImage);
  // +X "right" face
  vertex( zoom, -zoom, zoom, 0, 0);
  vertex( zoom, -zoom, -zoom, zoom, 0);
  vertex( zoom, zoom, -zoom, zoom, zoom);
  vertex( zoom, zoom, zoom, 0, zoom);
  endShape();
  
  beginShape(QUADS);
  texture(sideLImage);
  // -X "left" face
  vertex(-zoom, -zoom, -zoom, 0, 0);
  vertex(-zoom, -zoom, zoom, zoom, 0);
  vertex(-zoom, zoom, zoom, zoom, zoom);
  vertex(-zoom, zoom, -zoom, 0, zoom);
  endShape();

  beginShape(QUADS);
  texture(bottomImage);
  rotateY(radians(180));
  // +Y "bottom" face
  vertex(-zoom, zoom, zoom, 0, 0);
  vertex( zoom, zoom, zoom, zoom, 0);
  vertex( zoom, zoom, -zoom, zoom, zoom);
  vertex(-zoom, zoom, -zoom, 0, zoom);
  endShape();

  beginShape(QUADS);
  texture(topImage);
  // -Y "top" face
  vertex(-zoom, -zoom, -zoom, 0, 0);
  vertex( zoom, -zoom, -zoom, zoom, 0);
  vertex( zoom, -zoom, zoom, zoom, zoom);
  vertex(-zoom, -zoom, zoom, 0, zoom);
  endShape();
  
  popMatrix();
}
