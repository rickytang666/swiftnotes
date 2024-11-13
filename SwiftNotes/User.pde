// This file is for the user class

class User 
{
    int goldCoins;
    ArrayList<Note> notes;

    void createNote() {
        Note n = new Note("untitled");
        this.notes.add(n);
    }

    void storage(String fileName, int numTabs) {
        String[] noteContent = loadStrings(fileName);
    }
}
