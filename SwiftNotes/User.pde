
// This file is for the functions of a user

void createNote(String title) {
    Note n = new Note(title);
    notes.add(n);
    currentNote = n;
    updateTitles();
}

void updateTitles()
{
  if(notes.isEmpty())
  {
    noteTitles = new String[]{"No Notes Yet"};
    return;
  }
  
  noteTitles = new String[notes.size()];

  for (int i = 0; i < notes.size(); ++i)
  {
    noteTitles[i] = notes.get(i).title;
  }

  dropList1.setItems(noteTitles, noteTitles.length - 1);
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
