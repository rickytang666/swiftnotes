/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void textarea1_changed(GTextArea source, GEvent event) { //_CODE_:textarea1:266170:
  if (currentNote != null)
  {
    currentNote.text = textarea1.getText();
  }
  
  saveNotes();
  updateGoldCoins();
  saveUserData();
} //_CODE_:textarea1:266170:


public void addButton_clicked(GImageButton source, GEvent event) { //_CODE_:addButton:563243:

  createNote(generateUniqueTitle());
  textarea1.setVisible(true);
  textarea1.setText("");
  textfield1.setVisible(true);
  textfield1.setText(currentNote.title);
  
  scrollBottom();
  
  
} //_CODE_:addButton:563243:


public void textfield1_change1(GTextField source, GEvent event) { //_CODE_:textfield1:837306:
  try
  {
    if (event == GEvent.CHANGED && currentNote != null)
    {
      currentNote.title = textfield1.getText();
      String str = currentNote.title.length() > 25 ? currentNote.title.substring(0, 23) + "..." : currentNote.title;
      noteButtons.get(notes.indexOf(currentNote)).setText(str);
      saveNotes();
    }
  }
  catch (NullPointerException e)
  {
    println("monkey");
  }
  
  
} //_CODE_:textfield1:837306:


public void noteButton_clicked(GButton source, GEvent event) 
{
  int index = noteButtons.indexOf(source);

  if (index >= 0 && index < notes.size()) 
  {
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

    // Update the currentNote
    if (notes.isEmpty()) 
    {
      currentNote = null;
      println("empty");
      textfield1.setText("No notes yet");
      textarea1.setText("");
    } 
    else 
    {
      if (index < notes.size() - 1) 
      {
        // Select the note now at the same index
        currentNote = notes.get(index);
      } 
      else 
      {
        // If the last note was deleted, select the new last note
        currentNote = notes.get(notes.size() - 1);
        if (scrolledDist < 0)
        {
          scrolledDist += buttonHeight;
        }
      }
      
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

public void settingsButton_clicked(GImageButton source, GEvent event) {
  if (settingsWindow == null) 
  {
    openSettingsWindow();
  }
  else
  {
    println("what");
  }
}

public void openSettingsWindow() {
  // Create the secondary window
  settingsWindow = GWindow.getWindow(this, "Settings", 300, 300, 700, 400, JAVA2D);
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

  
  fontSizeSlider = new GCustomSlider(settingsWindow, 10, 50, 150, 60);
  fontSizeSlider.setLimits(fontSize, minSize, maxSize);
  fontSizeSlider.setNumberFormat(G4P.INTEGER, 0);
  fontSizeSlider.addEventHandler(this, "fontSizeSlider_dragged");
  fontSizeSlider.setShowLimits(true);
  fontSizeSlider.setOpaque(true);
  
  
  modeToggle = new GOption(settingsWindow, 10, 150, 150, 40);
  modeToggle.setText("Open Dark Mode");
  modeToggle.setSelected(mode.isDarkMode);
  modeToggle.addEventHandler(this, "modeToggle_changed");
  modeToggle.setFont(UIFont);
  
  fontDropList = new GDropList(settingsWindow, 200, 50, 200, 200, 4, 20);
  fontDropList.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  ArrayList<String> temp = new ArrayList<String>(Arrays.asList(fonts));
  fontDropList.setItems(fonts, temp.indexOf(noteFontStr));
  fontDropList.addEventHandler(this, "fontDropList_clicked");
  fontDropList.setLocalColor(3, color(0));
  fontDropList.setLocalColor(15, color(0, 0, 255));
  fontDropList.setFont(UIFont);
  
  inputLabel = new GLabel(settingsWindow, 450, 10, 200, 30, "Enter New Password: ");
  inputLabel.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  inputLabel.setFont(UIFont);
  
  input = new GPassword(settingsWindow, 450, 60, 200, 50);
  input.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  input.setFont(UIFont);
    
  confirmLabel = new GLabel(settingsWindow, 450, 130, 200, 30, "Confirm Password: ");
  confirmLabel.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  confirmLabel.setFont(UIFont);
  
  confirm = new GPassword(settingsWindow, 450, 180, 200, 50);
  confirm.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  confirm.setFont(UIFont);
    
  
  submit = new GButton(settingsWindow, 450, 250, 100, 30, "Submit");
  submit.addEventHandler(this, "submitPassword2");
  submit.setFont(UIFont);
  
  warning = new GLabel(settingsWindow, 450, 300, 200, 100, "");
  
  setColors2();
}


public void settingsWindow_draw(PApplet appc, GWinData data) {
  appc.background(mode.background);
  appc.fill(mode.foreground);
}

public void settingsWindow_close(GWindow window) {
  window.dispose(); // Explicitly dispose of the GWindow instance
  settingsWindow = null; // Dereference to allow reopening later
}

public void fontSizeSlider_dragged(GCustomSlider source, GEvent event) {
  try {
    fontSize = source.getValueI(); // Update the font size
    //println("Font size updated to: " + fontSize);
    updateFont(); // Update main window fonts
    saveUserData(); // Save changes
  } catch (IndexOutOfBoundsException e) {
    println("Index out of bounds while updating font size: " + e.getMessage());
  } catch (Exception e) {
    println("Unexpected error in fontSizeSlider_dragged: " + e.getMessage());
  }
}


public void modeToggle_changed(GOption source, GEvent event) {
  mode.setMode(source.isSelected());
  
  setColorsMain();
  setColors2();
  saveUserData();
}

public void fontDropList_clicked(GDropList source, GEvent event) 
{
  noteFontStr = source.getSelectedText();
  //println(font);
  updateFont();
  saveUserData(); 
}


public void submitPassword2(GButton source, GEvent event) 
{
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
    password = input.getPassword();
    storePassword();
  }
}


// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.ORANGE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("SwiftNotes App");
  textarea1 = new GTextArea(this, sidebarWidth + 10, buttonsUpBound + 80, 650, 500, G4P.SCROLLBARS_BOTH);
  textarea1.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  textarea1.setOpaque(true);
  textarea1.addEventHandler(this, "textarea1_changed");
  textarea1.setText("");
  textarea1.setVisible(false);
  
  addButton = new GImageButton(this, 90, 30, 60, 60, new String[]{"Add Button.png"});
  addButton.addEventHandler(this, "addButton_clicked");
  
  textfield1 = new GTextField(this, sidebarWidth + 10, buttonsUpBound, 650, 50, G4P.SCROLLBARS_HORIZONTAL_ONLY);
  textfield1.setOpaque(true);
  textfield1.addEventHandler(this, "textfield1_change1");
  
  if (!notes.isEmpty()) {
    textfield1.setVisible(true); // This works for the text field
    textarea1.setVisible(true); // Ensure the text area is also visible
    textarea1.setText(currentNote.text); // Populate the text area
    textfield1.setText(currentNote.title);
  } else {
      textfield1.setVisible(false);
      textarea1.setVisible(false);
  }
  
  scrollUpButton = new GImageButton(this, 10, 30, 60, 60, new String[]{"Scroll Up Button.png"});
  scrollUpButton.addEventHandler(this, "scrollUpButton_clicked");
  
  scrollDownButton = new GImageButton(this, 10, 620, 60, 60, new String[]{"Scroll Down Button.png"});
  scrollDownButton.addEventHandler(this, "scrollDownButton_clicked");
  
  scrollTopButton = new GImageButton(this, 170, 30, 60, 60, new String[]{"Scroll Top Button.png"});
  scrollTopButton.addEventHandler(this, "scrollTopButton_clicked");
  
  scrollBottomButton = new GImageButton(this, 170, 620, 60, 60, new String[]{"Scroll Bottom Button.png"});
  scrollBottomButton.addEventHandler(this, "scrollBottomButton_clicked");
  
  sidebarPanel = new GPanel(this, 0, 0, sidebarWidth, height);
  sidebarPanel.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  sidebarPanel.setOpaque(true);
  sidebarPanel.setCollapsed(false);
  sidebarPanel.setVisible(true);
  sidebarPanel.setText("Side Bar");
  sidebarPanel.setCollapsible(false);
  sidebarPanel.setFont(UIFont);
  sidebarPanel.setLocalColor(2, color(0));
  sidebarPanel.setTextBold();
  
  sidebarPanel.addControl(addButton);
  sidebarPanel.addControl(scrollUpButton);
  sidebarPanel.addControl(scrollDownButton);
  sidebarPanel.addControl(scrollTopButton);
  sidebarPanel.addControl(scrollBottomButton);

  settingsButton = new GImageButton(this, width - 80, 10, 60, 60, new String[]{"Settings Button.png"});
  settingsButton.addEventHandler(this, "settingsButton_clicked");
  
  updateSidebar();
  setColorsMain();
  updateFont();
}

// Variable declarations 
// autogenerated do not edit
GTextArea textarea1; 
GPanel sidebarPanel; 
GImageButton addButton;
GTextField textfield1;
ArrayList<GButton> noteButtons = new ArrayList<GButton>();
ArrayList<GImageButton> delButtons = new ArrayList<GImageButton>();
GImageButton scrollUpButton, scrollDownButton, scrollTopButton, scrollBottomButton;
GImageButton settingsButton;
GWindow settingsWindow;
GCustomSlider fontSizeSlider;
GOption modeToggle;
GDropList fontDropList;

GPassword input;
GPassword confirm;
GButton submit;
GLabel inputLabel, confirmLabel, warning;
