
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
final String separate = "||||||||||";
int goldCoins = 0;
String password;
ArrayList<Note> notes = new ArrayList<Note>();
Note currentNote;

final int buttonsUpBound = 40;
final int buttonHeight = 40;
int scrolledDist = 0;


void setup()
{
  size(1000, 700);
  importNotes();
  
  
  createGUI();
      
}



void draw()
{
    
}


void exit()
{
  saveNotes();
}
