// THIS FILE IS GOR MAJOR GUI LOGICS AND DRAWINGS

public void textarea1_changed(GTextArea source, GEvent event) 
{
  if (currentNote != null)
  {
    currentNote.text = textarea1.getText();
  }
  
  // save import data right away for security

  saveNotes();
  updateGoldCoins();
  saveUserData();
}


public void addButton_clicked(GImageButton source, GEvent event) 
{
  
  // create new note using unique title
  createNote(generateUniqueTitle());


  // clear & display the text editor and jump to currentNote

  textarea1.setVisible(true);
  textarea1.setText("");
  textfield1.setVisible(true);
  textfield1.setText(currentNote.title);
  
  scrollBottom(); // scroll to bottom because the new note is at the bottom and we jump to it
    
}


public void textfield1_change1(GTextField source, GEvent event) 
{
  try
  {
    if (event == GEvent.CHANGED && currentNote != null) // only if the user has notes, and actually changed it
    {

      // Make sure the note title is never exceeding the limit of button size

      currentNote.title = textfield1.getText();
      
      String str = currentNote.title.length() > 25 ? currentNote.title.substring(0, 23) + "..." : currentNote.title;
      noteButtons.get(notes.indexOf(currentNote)).setText(str);

      // save data right away

      saveNotes();
    }
  }
  catch (NullPointerException e)
  {
    println("Nullptr Exception when textfield is changed");
  }
  
  
}


public void noteButton_clicked(GButton source, GEvent event) 
{
  int index = noteButtons.indexOf(source);

  if (index >= 0 && index < notes.size()) 
  {
    // Jump the note that user wants, display every thing the note already has

    currentNote = notes.get(index);
    textfield1.setText(currentNote.title);
    textarea1.setText(currentNote.text);  // Show the note content in the text area
  }
  else
  {
    println("Error: Could not locate the selected note.");
  }
}

public void delButton_clicked(GImageButton source, GEvent event) 
{
  int index = delButtons.indexOf(source);

  if (index >= 0 && index < notes.size()) 
  {
    // Remove the selected note

    notes.remove(index);

    // Update the currentNote and note array

    if (notes.isEmpty()) 
    {
      // if after deletion not more notes, set to initial form

      currentNote = null;
      println("empty");
      textfield1.setText("No notes yet");
      textarea1.setText("");
    } 
    else 
    {
      if (index < notes.size() - 1) 
      {
        // If not deleting the last one jump to the next note

        currentNote = notes.get(index);
      } 
      else 
      {
        // If the last note was deleted, select the new last note

        currentNote = notes.get(notes.size() - 1);

        // Automatically shift other notes down (scroll up) if the notes are still exceeding the height of screen
        if (scrolledDist < 0)
        {
          scrolledDist += buttonHeight;
        }
      }
      

      // set the editors to new jumped note

      textfield1.setText(currentNote.title);
      textarea1.setText(currentNote.text);
    }

    // save the result
    saveNotes();

    // Always update the sidebar to reflect changes
    updateSidebar();
  } 
  else 
  {
    println("Error: Could not locate the selected note.");
  }
}

// These functions are for scrolling (just a function call each)

public void scrollUpButton_clicked(GImageButton source, GEvent event)
{
  scrollUp();
}

public void scrollDownButton_clicked(GImageButton source, GEvent event)
{
  scrollDown();
}

public void scrollTopButton_clicked(GImageButton source, GEvent event)
{
  scrollTop();
}

public void scrollBottomButton_clicked(GImageButton source, GEvent event)
{
  scrollBottom();
}

public void settingsButton_clicked(GImageButton source, GEvent event) 
{

  // Only create the settings window if it does not exist so prevent replication

  if (settingsWindow == null) 
  {
    openSettingsWindow();
  }
  else
  {
    println("settings window already exist");
  }
}

public void openSettingsWindow() 
{
  // Create the secondary window
  settingsWindow = GWindow.getWindow(this, "Settings", 300, 300, 700, 350, JAVA2D);

  // Add drawing and close handlings
  settingsWindow.addDrawHandler(this, "settingsWindow_draw");
  settingsWindow.addOnCloseHandler(this, "settingsWindow_close");

  
  /*
    This sets what happens when the users attempts to close the window.
    There are 3 possible actions depending on the value passed.
    G4P.KEEP_OPEN - ignore attempt to close window (default action),
    G4P.CLOSE_WINDOW - close this window,
    G4P.EXIT_APP - exit the app, this will cause all windows to close.
  */
  
  settingsWindow.setActionOnClose(G4P.CLOSE_WINDOW);

  // Add controls to the settings window

  // For adjusting font size (text label + slider bar)
  
  fontSizeLabel = new GLabel(settingsWindow, 10, 10, 150, 30, "Adjust Text Size");
  fontSizeLabel.setFont(UIFont);
  fontSizeLabel.setLocalColor(2, mode.foreground);
  
  fontSizeSlider = new GCustomSlider(settingsWindow, 10, 50, 150, 60);
  fontSizeSlider.setLimits(fontSize, minSize, maxSize);
  fontSizeSlider.setNumberFormat(G4P.INTEGER, 0); // force the font size to integer
  fontSizeSlider.addEventHandler(this, "fontSizeSlider_dragged");
  fontSizeSlider.setShowLimits(true);
  fontSizeSlider.setOpaque(true);
  
  // A option toggle for switching light/dark mode
  
  modeToggle = new GOption(settingsWindow, 10, 150, 150, 40);
  modeToggle.setText("Open Dark Mode");
  modeToggle.setSelected(mode.isDarkMode);
  modeToggle.addEventHandler(this, "modeToggle_changed");
  modeToggle.setFont(UIFont);

  // For selecting font family for text editing (text label + droplist)
  
  fontSelect = new GLabel(settingsWindow, 200, 10, 200, 30, "Select Font");
  fontSelect.setFont(UIFont);
  fontSelect.setLocalColor(2, mode.foreground);
  
  
  fontDropList = new GDropList(settingsWindow, 200, 50, 200, 200, 4, 20);
  fontDropList.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  ArrayList<String> temp = new ArrayList<String>(Arrays.asList(fonts)); // turn array to arraylist to use find index
  fontDropList.setItems(fonts, temp.indexOf(noteFontStr)); // put the font array to the droplist
  fontDropList.addEventHandler(this, "fontDropList_clicked");
  fontDropList.setLocalColor(3, color(0));
  fontDropList.setLocalColor(15, color(0, 0, 255));
  fontDropList.setFont(UIFont);

  // For resetting password (text labels + password fields + button)
  // As you can see we reused the variables we used in authentication screen (we just dispose, reuse, and so on)
  
  resetPass = new GLabel(settingsWindow, 450, 10, 200, 30, "Reset Password");
  resetPass.setFont(UIFont);
  resetPass.setLocalColor(2, mode.foreground);
  
  inputLabel = new GLabel(settingsWindow, 450, 40, 200, 30, "Enter New Password: ");
  inputLabel.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  inputLabel.setFont(UIFont);
  
  input = new GPassword(settingsWindow, 450, 90, 200, 50);
  input.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  input.setFont(UIFont);
    
  confirmLabel = new GLabel(settingsWindow, 450, 160, 200, 30, "Confirm Password: ");
  confirmLabel.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  confirmLabel.setFont(UIFont);
  
  confirm = new GPassword(settingsWindow, 450, 210, 200, 50);
  confirm.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  confirm.setFont(UIFont);
    
  submit = new GButton(settingsWindow, 450, 270, 100, 30, "Submit");
  submit.addEventHandler(this, "submitPassword2");
  submit.setFont(UIFont);
  
  warning = new GLabel(settingsWindow, 450, 300, 200, 50, "");
  warning.setFont(UIFont);
  
  setColors2(); // fill the colors for settings window (based on light/dark mode)
}


public void settingsWindow_draw(PApplet appc, GWinData data) 
{
  // set the background & foreground color for drawing
  appc.background(mode.background);
  appc.fill(mode.foreground);
}

public void settingsWindow_close(GWindow window) 
{
  window.dispose(); // Explicitly dispose of the GWindow instance (dispose all the controls in the window so we don't need to call them)
  settingsWindow = null; // Dereference to allow reopening later
}

public void fontSizeSlider_dragged(GCustomSlider source, GEvent event) 
{
  try 
  {
    fontSize = source.getValueI(); // Update the font size
    //println("Font size updated to: " + fontSize);
    updateFont(); // Update text editor fonts
    saveUserData(); // Save changes right away
  } 
  catch (IndexOutOfBoundsException e) 
  {
    println("Index out of bounds while updating font size: " + e.getMessage());
  } 
  catch (Exception e) {
    println("Unexpected error in fontSizeSlider_dragged: " + e.getMessage());
  }
}


public void modeToggle_changed(GOption source, GEvent event) 
{

  // Switch mode accordingly

  mode.setMode(source.isSelected());
  
  // Update the colors and save data right away

  setColorsMain();
  setColors2();
  saveUserData();
}

public void fontDropList_clicked(GDropList source, GEvent event) 
{
  noteFontStr = source.getSelectedText();
  //println(font);

  // Get the font and update & save it right away.
  updateFont();
  saveUserData(); 
}


public void submitPassword2(GButton source, GEvent event) 
{

  // check if the new password is valid for reset
  if (!input.getPassword().equals(confirm.getPassword()))
  {
    warning.setText("Passwords don't match. Try again.");
  }
  else if (input.getPassword().length() < 3)
  {
    warning.setText("Password has to be at least 3 characters in length");
  }
  else
  {
    warning.setText("Password Sucessfully Set!");

    // If no trouble we update and save it to txt immediately
    password = input.getPassword();
    storePassword();
  }
}


/***** CREATE GUI FUNCTION *****/

public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.ORANGE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("SwiftNotes App");

  // Text area like word document, for editing note contents

  textarea1 = new GTextArea(this, sidebarWidth + 10, buttonsUpBound + 80, 650, 500, G4P.SCROLLBARS_BOTH);
  textarea1.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  textarea1.setOpaque(true);
  textarea1.addEventHandler(this, "textarea1_changed");
  textarea1.setText("");
  textarea1.setVisible(false); // initially set it to invisible until user clicks a note
  

  // Add button (for adding new note)

  addButton = new GImageButton(this, 90, 30, 60, 60, new String[]{"Add Button.png"}); // using string array of file paths to determine the image shown on button
  addButton.addEventHandler(this, "addButton_clicked");
  

  // Text field for editing title

  textfield1 = new GTextField(this, sidebarWidth + 10, buttonsUpBound, 650, 50, G4P.SCROLLBARS_HORIZONTAL_ONLY);
  textfield1.setOpaque(true);
  textfield1.addEventHandler(this, "textfield1_change1");
  
  if (!notes.isEmpty()) 
  {
    textfield1.setVisible(true); // This works for the text field
    textarea1.setVisible(true); // Ensure the text area is also visible
    textarea1.setText(currentNote.text); // Populate the text area
    textfield1.setText(currentNote.title);
  } 
  else 
  {
    // If the user has no notes we don't display the editors

    textfield1.setVisible(false);
    textarea1.setVisible(false);
  }

  // All the scrolling buttons
  // Same theory (use string[] with file paths to refer the image shown)
  
  scrollUpButton = new GImageButton(this, 10, 30, 60, 60, new String[]{"Scroll Up Button.png"});
  scrollUpButton.addEventHandler(this, "scrollUpButton_clicked");
  
  scrollDownButton = new GImageButton(this, 10, 620, 60, 60, new String[]{"Scroll Down Button.png"});
  scrollDownButton.addEventHandler(this, "scrollDownButton_clicked");
  
  scrollTopButton = new GImageButton(this, 170, 30, 60, 60, new String[]{"Scroll Top Button.png"});
  scrollTopButton.addEventHandler(this, "scrollTopButton_clicked");
  
  scrollBottomButton = new GImageButton(this, 170, 620, 60, 60, new String[]{"Scroll Bottom Button.png"});
  scrollBottomButton.addEventHandler(this, "scrollBottomButton_clicked");
  

  // The side bar panel

  sidebarPanel = new GPanel(this, 0, 0, sidebarWidth, height);
  sidebarPanel.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  sidebarPanel.setOpaque(true);
  sidebarPanel.setCollapsed(false);
  sidebarPanel.setVisible(true);
  sidebarPanel.setText("Side Bar");
  sidebarPanel.setCollapsible(false); // make it static and never collapse
  sidebarPanel.setFont(UIFont);
  sidebarPanel.setLocalColor(2, color(0));
  sidebarPanel.setTextBold();
  
  // Add all scrolling & adding buttons to the side panel to activiate all the controls
  
  sidebarPanel.addControl(addButton);
  sidebarPanel.addControl(scrollUpButton);
  sidebarPanel.addControl(scrollDownButton);
  sidebarPanel.addControl(scrollTopButton);
  sidebarPanel.addControl(scrollBottomButton);

  // Settings button (apple settings icon)

  settingsButton = new GImageButton(this, width - 80, 10, 60, 60, new String[]{"Settings Button.png"});
  settingsButton.addEventHandler(this, "settingsButton_clicked");
  

  // Update the side bar (in case the user has a lot of data already)

  updateSidebar();

  // update the stylings

  setColorsMain();
  updateFont();
}



/***** VARIABLE DECLARATIONS *****/

GTextArea textarea1; 
GPanel sidebarPanel; 
GImageButton addButton;
GTextField textfield1;
ArrayList<GButton> noteButtons = new ArrayList<GButton>();
ArrayList<GImageButton> delButtons = new ArrayList<GImageButton>();
GImageButton scrollUpButton, scrollDownButton, scrollTopButton, scrollBottomButton;
GImageButton settingsButton;
GWindow settingsWindow;
GLabel fontSizeLabel;
GLabel fontSelect;
GLabel resetPass;
GCustomSlider fontSizeSlider;
GOption modeToggle;
GDropList fontDropList;

GPassword input;
GPassword confirm;
GButton submit;
GLabel inputLabel, confirmLabel, welcome, warning;
