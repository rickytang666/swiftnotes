class Mode 
{
  //Fields
  Boolean isDarkMode;
  color foreground; // for UI font color
  color background; // for general window background
  color panelBG; // for side panel background
  color textBG; // for workplace note text background


  // Construtor

  Mode()
  {
    // set light mode as default

    this.isDarkMode = false;

    this.foreground = color(46, 51, 56);
    this.background = color(255, 255, 255);
    this.panelBG = color(242, 243, 245);
    this.textBG = color(248, 249, 249);
  }
  
  //Sets the mode to dark mode or light mode depends on the boolean

  void setMode(Boolean darkmode)
  {
    this.isDarkMode = darkmode;

    if (this.isDarkMode)
    {
      // Set the color pallete to dark mode version

      this.foreground = color(255, 255, 255);
      this.background = color(43, 45, 49);
      this.panelBG = color(30, 30, 30);
      this.textBG = color(54, 57, 63);
    }
    else
    {

      // Set the color pallete to light mode version
      
      this.foreground = color(46, 51, 56);
      this.background = color(250, 250, 250);
      this.panelBG = color(220, 220, 220);
      this.textBG = color(245, 245, 245);
    }
  }
}
