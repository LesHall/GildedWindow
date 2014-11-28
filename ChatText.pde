// by Les Hall
// 


ChatText myChat = new ChatText();


class ChatText
{
  String[] lines =  new String[5];
  
  ChatText()
  {
    for(int i=0; i<lines.length; ++i)
      lines[i] = "";
  }
  
  void drawText()
  {
    for (int i=0; i<lines.length; ++i)
      text(lines[i], -width/2, height/2 - 42*(i+1));
  }

  void setLine(String l)
  {
    lines[0] = l;
  }
  
  String getLine()
  {
    return lines[0];
  }
  
  void addChar(char c)
  {
    lines[0] += str(c);
  }
  
  void scrollText()
  {
    for (int i=1; i<lines.length; ++i)
      lines[lines.length-i] = lines[lines.length-1-i];
    lines[0] = "";
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


