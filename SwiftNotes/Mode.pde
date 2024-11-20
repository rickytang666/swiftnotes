class Mode 
{
  //Fields
  Boolean isDarkMode;
  color foreground;
  color background;
  color panelBG;
  color textBG;

  Mode() //Constructor
  {
    //Checks whether dark mode is on or off
    this.isDarkMode = false;

    this.foreground = color(46, 51, 56);
    this.background = color(255, 255, 255);
    this.panelBG = color(242, 243, 245);
    this.textBG = color(248, 249, 249);
  }
  
  //Sets the mode to dark mode depending on the boolean DarkMode
  void setMode(Boolean darkmode)
  {
    this.isDarkMode = darkmode;

    if (this.isDarkMode)
    {
      this.foreground = color(255, 255, 255);
      this.background = color(43, 45, 49);
      this.panelBG = color(30, 30, 30);
      this.textBG = color(54, 57, 63);
    }
    else
    {
      this.foreground = color(46, 51, 56);
      this.background = color(250, 250, 250);
      this.panelBG = color(220, 220, 220);
      this.textBG = color(245, 245, 245);
    }
  }
}
