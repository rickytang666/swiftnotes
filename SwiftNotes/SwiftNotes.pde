
/* 

    Software Name: SwiftNotes
    Author: Youssef, Mariam, Ricky
    Date: November 22nd, 2024

*/

// Importing Packages

import g4p_controls.*;

// Global Variables or Contants

char[] punctuation = {',', '.', ':', ';', '!', '?', '\'', '\"', '(', ')', '-', '_',
 '[', ']', '{', '}', '/', '\\', '|', '&', '*', '@', '#', '$',
  '%', '^', '~', '`', '+', '=', '<', '>', '\n', '\t'};


final String filePath = "NoteStorage.txt";
int goldCoins = 0;
String password;
ArrayList<Note> notes = new ArrayList<Note>();
Note currentNote;
String[] noteTitles = {"No Notes Yet"};

final int buttonHeight = 40;
int scrolledDist = 0;


void setup()
{
  size(1000, 700);
  createGUI();
      
}



void draw()
{
    
}


void exit()
{
  saveNotes();
}
