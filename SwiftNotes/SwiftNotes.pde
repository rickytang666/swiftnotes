
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


final String noteStoragePath = "NoteStorage.txt";
final String userStoragePath = "UserInfo.txt";
final String separate = "||||||||||";
int goldCoins = 0;
int fontSize = 5;
String font = "none";
Boolean darkMode = false;
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
  importUserData();
  
  
  createGUI();
      
}



void draw()
{
    
}


void exit()
{
  saveNotes();
  saveUserData();
}
