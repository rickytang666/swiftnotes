/* THIS FILE IS FOR THE FUNCTIONS OF A USER */


// Function for creating new Note

void createNote(String title) 
{
  // Append the note object
  
  Note n = new Note(title);
  notes.add(n);

  // Jump to the new created note (in order to give convenience)

  currentNote = notes.get(notes.size() - 1);
  
  // Save data for security

  saveNotes();
}

// Function for saving the user's notes to ensure the user doesn't lose them

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

  pw.flush(); // make sure no character remained in buffer
  pw.close();
  
  //println("saved");
}

//Loads the notes that the user has saved after opening the program

void importNotes()
{
  String[] lines = loadStrings(noteStoragePath);

  // Loop through every line of the txt file

  for (int i = 0; i < lines.length; ++i)
  {
    if (lines[i].equals(separate)) // every time we meet a seperate string, we check the note contents before
    {
      String title = lines[i - 3];
      String time = lines[i - 2];
      String content = lines[i - 1];

      Note note = new Note(title);
      note.createdTime = time;
      note.text = content;
      note.updateWordNum(); // update the word num right away

      notes.add(note);
    }
  }
  
  // If the user already has some notes, we jump to the first note

  if (notes.isEmpty())
  {
    println("The notes are empty");
  }
  else
  {
    currentNote = notes.get(0);
  }
}

//Updates the amount of gold coins that the user has received

void updateGoldCoins() 
{
  // every 5 words we give 1 coin

  int num = 0;
  
  for(int i = 0; i < notes.size(); i++)
  {

    // iteraate through the note array and count the word number

    Note x = notes.get(i);
    x.updateWordNum();
    num += x.wordNum;
    
  }
  
  goldCoins = floor(num / 5);
}

//Loads the user's previously set settings (Font, Font size, Dark mode) as well as their gold coins

void importUserData()
{
  String[] lines = loadStrings(userStoragePath);
  
  if (lines == null)
  {
    // if the file is empty, we don't import any data
    return;
  }
  
  goldCoins = int(lines[0]);
  noteFontStr = lines[1];
  fontSize = constrain(int(lines[2]), minSize, maxSize); // Use contrain to prevent someone made font too large in the txt file
  mode.setMode(lines[3].equals("true") ? true : false);
}

//Loads the user's previously set password to use to open the program

void importPassword()
{
  String[] lines = loadStrings(passwordStoragePath);
  
  if (lines == null || lines.length < 1 || lines[0].length() < 3)
  {
    // An empty file or a too short password is treated as new user

    firstTime = true;
    notes.clear();
    goldCoins = 0;
  }
  else
  {
    firstTime = false;
    password = lines[0];
  }
}

//Autosaves the user's settings

void saveUserData()
{
  PrintWriter pw = createWriter(userStoragePath);
  
  pw.println(goldCoins);
  pw.println(noteFontStr);
  pw.println(fontSize);
  pw.println((mode.isDarkMode) ? "true" : "false");
  
  pw.flush();
  pw.close();
}

//Stores the user's new password whenever they set it

void storePassword()
{
  PrintWriter pw = createWriter(passwordStoragePath);
  
  pw.println(password);
  
  pw.flush();
  pw.close();
}


/*******************************/

//Scrolls up the panel

void scrollUp()
{
  // We need to make sure we don't exceed the scrolling distance (when we scroll to the top it can't scroll more)
  if (scrolledDist < 0)
  {
    scrolledDist += buttonHeight;
    updateSidebar();
  }
}

//Scrolls down the panel

void scrollDown()
{

  // calculate the last note (is it exceeding?) if so we can scroll

  int maxY = buttonsUpBound + scrolledDist + (notes.size() - 1) * buttonHeight;

  if ( maxY > height - buttonHeight - paddingDown) 
  {
    scrolledDist -= buttonHeight;
    updateSidebar();
  }
}

//Scrolls all the way to the bottom of the panel

void scrollBottom()
{

  // Same logic for scrolling down but uses a while loop to repeat

  int maxY = buttonsUpBound + scrolledDist + (notes.size() - 1) * buttonHeight;

  while (maxY > height - buttonHeight - paddingDown)
  {  
    scrolledDist -= buttonHeight;
    maxY = buttonsUpBound + scrolledDist + (notes.size() - 1) * buttonHeight;
  }

  updateSidebar();
}


//Scrolls all the way to the top of the panel

void scrollTop()
{
  // easy, just set it to zero so that it automatically scrolled to top (like we never scrolled before)

  scrolledDist = 0;
  updateSidebar();
}

//Updates the panel to include new or removed note tabs (or scroll displacement)

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

  for (GImageButton button : delButtons) 
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

    // calculate the y position and check if the note is in visible range

    int yPos = buttonsUpBound + scrolledDist + i * buttonHeight;
    Boolean visible = false;
    
    if (yPos >= buttonsUpBound && yPos <= height - buttonHeight - paddingDown) 
    {
      visible = true;
    }

    // Add note button
    
    GButton noteBtn = new GButton(this, 10, yPos, buttonWidth, buttonHeight - 10);
        
    // prevent a too long title overflows the buttons
    String str = notes.get(i).title.length() > 25 ? notes.get(i).title.substring(0, 23) + "..." : notes.get(i).title; 

    noteBtn.setText(str);
    noteBtn.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
    noteBtn.setLocalColor(2, color(0));
    noteBtn.addEventHandler(this, "noteButton_clicked");
    noteBtn.setVisible(visible);
    noteBtn.setFont(UIFont);
    noteButtons.add(noteBtn);

    // Use a string array (index 0 is static form, index 1 is hovered form) to show that if you hover it is red, else it is white (much cooler)

    GImageButton delBtn = new GImageButton(this, buttonWidth + 20, yPos, buttonHeight - 10, buttonHeight - 10, new String[]{"Delete Button 1.png", "Delete Button 2.png"});
    delBtn.addEventHandler(this, "delButton_clicked");
    delBtn.setVisible(visible);
    delButtons.add(delBtn);
  }
  
  // Link all the buttons to the side panel control
  
  for (GButton button : noteButtons) {
    sidebarPanel.addControl(button);
  }

  for (GImageButton button : delButtons) {
    sidebarPanel.addControl(button);
  }
}


//Sets the primary colour accents (for the main window) of the program

void setColorsMain()
{
  
  sidebarPanel.setLocalColor(5, mode.panelBG); // 5 controls the panel background

  // 7 controls text editor background, 2 controls text color, 12 controls the jumping insertion color
  
  textfield1.setLocalColor(7, mode.textBG); 
  textfield1.setLocalColor(12, mode.foreground);
  textfield1.setLocalColor(2, mode.foreground);
  
  textarea1.setLocalColor(7, mode.textBG);
  textarea1.setLocalColor(12, mode.foreground);
  textarea1.setLocalColor(2, mode.foreground);

  
}

//Sets the secondary colour accents (for the small settings window) of the program

void setColors2()
{
  
  // 7 controls text editor background, 2 controls text color, 12 controls the jumping insertion color
  
  modeToggle.setLocalColor(2, mode.foreground);
  
  input.setLocalColor(7, mode.textBG);
  input.setLocalColor(12, mode.foreground);
  input.setLocalColor(2, mode.foreground);
  
  confirm.setLocalColor(7, mode.textBG);
  confirm.setLocalColor(12, mode.foreground);
  confirm.setLocalColor(2, mode.foreground);
  
  
  inputLabel.setLocalColor(2, mode.foreground);
  confirmLabel.setLocalColor(2, mode.foreground);
  warning.setLocalColor(2, mode.foreground);
  
}

//Initializes the UI font (for buttons, labels, panels, etc.) of the program

void initializeUIFont()
{
  UIFont = new Font("Inter", Font.PLAIN, 17);
}

//Updates the workplace font (for text editing and titles) that the user has set from the settings menu

void updateFont()
{
  noteFont = new Font(noteFontStr, Font.PLAIN, fontSize);
  
  textfield1.setFont(noteFont);
  textarea1.setFont(noteFont);
}
