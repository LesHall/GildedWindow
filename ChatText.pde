// by Les Hall
// 


ChatText myChat = new ChatText(8, 24, 
  "http://66.25.85.79/SLchat.txt");


class ChatText
{
  String chatFile;
  int numChatLines;
  int fontSize;
  String line;
  
  ChatText(int numLines, int size, String fileName)
  {
    numChatLines = numLines;
    fontSize = size;
    chatFile = fileName;
    line = "";
  }
  
  int getFontSize()
  {
    return fontSize;
  }
  
  void drawChat()
  {
    String[] txt = loadStrings(chatFile);
    int iMax = txt.length;
    int txtLen = min(numChatLines, iMax);
    for (int i=0; i<txtLen; ++i)
      text(txt[iMax-i], -width/2, height/2 - fontSize*(i+1));
    text(line, -width/2, height/2 - fontSize);
  }

  void setLine(String l)
  {
    line = l;
  }
  
  void addLine(String l)
  {
    String[] txtIn = loadStrings(chatFile);
    String[] txtOut = append(txtIn, l);
    saveStrings(chatFile, txtOut);
  }
  
  String getLine()
  {
    return line;
  }
  
  void addChar(char c)
  {
    line += str(c);
  }
  
  void scrollText()
  {
    String[] txt = loadStrings(chatFile);
    txt = append(txt, line);
    line = "";
    saveStrings(chatFile, txt);
  }
} 


void keyPressed()
{
  if (key ==  8)
  {
    String l = myChat.getLine();
    if (l.length() > 0)
    {
      l = l.substring(0, l.length()-1);
      myChat.setLine(l);
    }
  }
  else if ( (key == 13) || (key == 10) )
    myChat.scrollText();
  else if (key == CODED)
  {
  }
  else
    myChat.addChar(key);
}


