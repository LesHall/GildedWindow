// by Les Hall
// began this Thor's Day in the eleventh month of the year two thousand and fourteen
// A day of Thanksgiving on which I begin to open a window in Cyberspace
// between those on the spider's web and those who choose to live a seconde life
// 


int bgRed = 192;
int bgGreen = 192;
int bgBlue = jsBlue;

void setup()
{
  // make it big
  size(1024, 768, P3D);
}


void draw()
{
  // display the environment
  // 
  // make it golden
  background(bgRed, bgGreen, bgBlue);
  fill(128, 0, 255);
  stroke(0, 255, 128);
  textAlign(LEFT, CENTER);
  textSize(42);
  // 
  // look into it
  camera(0, 0, (height/2.0) / tan(PI*60.0 / 360.0), 0, 0, 0, 0, 1, 0);
  // 
  // light it up
  lights();
  
  // get the inworld information
  // 
  // get the land profile
  // 
  // get the avatar descriptions
  // 
  // get the STL model inf
  
  // draw the scene
  // 
  // display the avatars
  // 
  // display the STL models
  stl.drawSTL(frameCount);
  //
  // display the chat text
  myChat.drawText();
}
