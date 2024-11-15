// This file is for the functions of a user

void createNote(String title) {
    Note n = new Note(title);
    notes.add(n);
    currentNote = n;
    updateSidebar();
    
    
}

void updateSidebar() {
  // Clear previous buttons to avoid duplicates
  noteButtons.clear();
  
  // Only add visible notes, considering the scroll distance
  for (int i = 0; i < notes.size(); i++) {
    int yPos = buttonHeight + scrolledDist + i * buttonHeight;
    // Only show buttons within the visible area
    if (yPos >= buttonHeight && yPos <= height - buttonHeight) {
      GButton newButton = new GButton(this, 31, yPos, 157, 30);
      newButton.setText(notes.get(i).title);
      newButton.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
      newButton.addEventHandler(this, "noteButton_clicked");
      noteButtons.add(newButton);
    }
  }
}


void saveNotes() 
{
  PrintWriter pw = createWriter(filePath);

  for (Note n : notes)
  {
    pw.println(n.title);
    pw.println(n.createdTime);
    pw.println(n.text);
    pw.println("*****");
  }

  pw.flush();
  pw.close();
  
  //println("saved");
}

void updateGoldCoins() {
  for(int i = 0; i < notes.size(); i++){
    Note x = notes.get(i);
    x.updateWordNum();
    int coinsAdded = x.wordNum / 20;
    goldCoins += coinsAdded;
  }
}
