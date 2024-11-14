
// This file is for the user class
    int goldCoins;
    ArrayList<Note> notes;

    void createNote() {
        Note n = new Note("untitled");
        this.notes.add(n);
    }

    void storage(String fileName, int numTabs) {
      String[] noteContent = loadStrings(fileName);
    }
    
    void updateGoldCoins(){
      for(int i = 0; i <= notes.size(); i++){
      Note x = notes.get(i);
      x.updateWordNum();
      int coinsAdded = wordNum / 20;
      goldCoins += coinsAdded;
    }
