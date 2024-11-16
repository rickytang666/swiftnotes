
/* 

    Software Name: SwiftNotes
    Author: Youssef, Mariam, Ricky
    Date: November 22nd, 2024

*/

// Importing Packages

import g4p_controls.*;
import java.awt.Font;

// Global Variables or Contants

char[] punctuation = {',', '.', ':', ';', '!', '?', '\'', '\"', '(', ')', '-', '_',
 '[', ']', '{', '}', '/', '\\', '|', '&', '*', '@', '#', '$',
  '%', '^', '~', '`', '+', '=', '<', '>', '\n', '\t'};


final String noteStoragePath = "NoteStorage.txt";
final String userStoragePath = "UserInfo.txt";
final String separate = "||||||||||";
final int maxSize = 20;
final int minSize = 10;
int goldCoins = 0;
int fontSize = 5;
String font = "none";
Mode mode = new Mode();
String password;
ArrayList<Note> notes = new ArrayList<Note>();
Note currentNote;
Font globalFont = new Font("Arial", Font.PLAIN, fontSize);

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
    background(mode.background);
}


void exit()
{
  saveNotes();
  saveUserData();
}
