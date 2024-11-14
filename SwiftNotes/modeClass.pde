class Mode {
  int mode = 0;
  int text = 1;
  color[] modeColor = {color(255), color(0)};
  
  color modeChange(int m) {
    if (m == 0) {
      mode = 0;
      text = 1;
    } else {
      mode = 1;
      text = 0;
    }
    return modeColor[mode];
  }
  
  color textColor() {
    return modeColor[text];
  }
}
