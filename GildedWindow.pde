// by Les Hall
// began this Thor's Day in the eleventh month of the year two thousand and fourteen
// A day of Thanksgiving on which I begin to open a window in Cyberspace
// between those on the spider's web and those who choose to live a seconde life
// 

int numBoxes;
String boxesFile;

void setup()
{
  // make it big
  size(1024, 768, P3D);
  
  numBoxes = 0;
  boxesFile = "http://66.25.85.79/SLboxes.txt";
}


void draw()
{
  // display the environment
  // 
  // make it golden
  background(192, 192, 64);
  fill(128, 0, 255);
  stroke(0, 255, 128);
  textAlign(LEFT, CENTER);
  textSize(myChat.getFontSize());
  // 
  // look into it
  camera(0, 0, (height/2.0) / tan(PI*60.0 / 360.0), 0, 0, 0, 0, 1, 0);
  // 
  // light it up
  lights();
  
  // get the inworld information
  // 
  // get the url and key of the last box rezzed and write it to the screen
  String[] boxes = loadStrings(boxesFile);
  if (boxes.length > numBoxes)
  {
    numBoxes = boxes.length;
    String tokens = boxes[boxes.length-1];
    int marker = tokens.indexOf(" ");
    String boxURL = tokens.substring(0, marker-1);
    String boxKey = tokens.substring(marker+1);
    myChat.addLine(boxURL);
    myChat.addLine(boxKey);
  }
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
  // get the chat and write it to the screen
  myChat.drawChat();
}
