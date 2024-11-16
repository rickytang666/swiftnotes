// This file is for the functions of a user

void createNote(String title) 
{
    Note n = new Note(title);
    notes.add(n);
    currentNote = notes.get(notes.size()-1);
    
    saveNotes();
}


void saveNotes() 
{
  PrintWriter pw = createWriter(noteStoragePath);

  for (Note n : notes)
  {
    pw.println(n.title);
    pw.println(n.createdTime);
    pw.println(n.text);
    pw.println(separate);
  }

  pw.flush();
  pw.close();
  
  //println("saved");
}


void importNotes()
{
  String[] lines = loadStrings(noteStoragePath);
  for (int i = 0; i < lines.length; ++i)
  {
    if (lines[i].equals(separate))
    {
      String title = lines[i - 3];
      String time = lines[i - 2];
      String content = lines[i - 1];

      Note note = new Note(title);
      note.createdTime = time;
      note.text = content;

      notes.add(note);
    }
  }
  
  if (notes.isEmpty())
    println("monkey");
  else
  {
    currentNote = notes.get(0);
  }
}


void updateGoldCoins() {
  for(int i = 0; i < notes.size(); i++){
    Note x = notes.get(i);
    x.updateWordNum();
    goldCoins = floor(x.wordNum / 5);
  }
}


void importUserData()
{
  String[] lines = loadStrings(userStoragePath);
  
  goldCoins = int(lines[0]);
  font = lines[1];
  fontSize = constrain(int(lines[2]), minSize, maxSize);
  mode.setMode(lines[3].equals("true") ? true : false);
}


void saveUserData()
{
  PrintWriter pw = createWriter(userStoragePath);
  
  pw.println(goldCoins);
  pw.println(font);
  pw.println(fontSize);
  pw.println((mode.isDarkMode) ? "true" : "false");
  
  pw.flush();
  pw.close();
}


/*******************************/


void scrollUp()
{
  if (scrolledDist < 0)
  {
    scrolledDist += buttonHeight;
    updateSidebar();
  }
}


void scrollDown()
{
  int maxY = buttonsUpBound + scrolledDist + (notes.size() - 1) * buttonHeight;

  if ( maxY > height - buttonHeight) 
  {
    scrolledDist -= buttonHeight;
    updateSidebar();
  }
}


void scrollBottom()
{
  int maxY = buttonsUpBound + scrolledDist + (notes.size() - 1) * buttonHeight;

  while (maxY > height - buttonHeight)
  {  
    scrolledDist -= buttonHeight;
    maxY = buttonsUpBound + scrolledDist + (notes.size() - 1) * buttonHeight;
  }

  updateSidebar();
}



void scrollTop()
{
  scrolledDist = 0;
  updateSidebar();
}


void updateSidebar() 
{
  // Clear previous buttons to avoid duplicates

  for (GButton button : noteButtons) 
  {
    if (button != null)
    {
      button.dispose();
    }
  }
  noteButtons.clear();

  for (GButton button : delButtons) 
  {
    if (button != null)
    {
      button.dispose();
    }
  }

  delButtons.clear();
  
  // Only add visible notes, considering the scroll distance

  for (int i = 0; i < notes.size(); i++) 
  {
    int yPos = buttonsUpBound + scrolledDist + i * buttonHeight;
    Boolean visible = false;
    
    if (yPos >= buttonsUpBound && yPos <= height - buttonHeight) {
      visible = true;
    }
    
    GButton noteBtn = new GButton(this, 10, yPos, 150, buttonHeight - 10);
    noteBtn.setText(notes.get(i).title);
    noteBtn.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
    noteBtn.addEventHandler(this, "noteButton_clicked");
    noteBtn.setVisible(visible);
    noteButtons.add(noteBtn);

    GButton delBtn = new GButton(this, 170, yPos, 20, buttonHeight - 10);
    delBtn.setText("-");
    delBtn.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
    delBtn.addEventHandler(this, "delButton_clicked");
    delBtn.setVisible(visible);
    delButtons.add(delBtn);
  }
  
  
  for (GButton button : noteButtons) {
    sidebarPanel.addControl(button);
  }

  for (GButton button : delButtons) {
    sidebarPanel.addControl(button);
  }
}



void setColorsMain()
{
  
  sidebarPanel.setLocalColor(5, mode.panelBG);
  sidebarPanel.setLocalColor(1, color(255, 165, 0));

  textfield1.setLocalColor(7, mode.textBG);
  textfield1.setLocalColor(12, mode.foreground);
  textfield1.setLocalColor(2, mode.foreground);
  
  textarea1.setLocalColor(7, mode.textBG);
  textarea1.setLocalColor(12, mode.foreground);
  textarea1.setLocalColor(2, mode.foreground);

  
}


void setColors2()
{
  modeToggle.setLocalColor(2, mode.foreground);
  
}


void updateFontMain()
{
  globalFont = new Font("Arial", Font.PLAIN, fontSize);

  sidebarPanel.setFont(globalFont);
  textfield1.setFont(globalFont);
  textarea1.setFont(globalFont);
  
  for (GButton button : noteButtons)
  {
    button.setFont(globalFont);
  }

  for (GButton button : delButtons)
  {
    button.setFont(globalFont);
  }

  
}


void updateFont2()
{
  globalFont = new Font("Arial", Font.PLAIN, fontSize);

  modeToggle.setFont(globalFont);

  
}
