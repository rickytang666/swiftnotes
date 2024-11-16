
/* 

    Software Name: SwiftNotes
    Author: Youssef, Mariam, Ricky
    Date: November 22nd, 2024

*/

// Importing Packages

import g4p_controls.*;
import java.util.*;
import java.awt.Font;
import java.io.File;
import java.io.IOException;
import java.awt.FontFormatException;


// Global Variables or Contants

char[] punctuation = {',', '.', ':', ';', '!', '?', '\'', '\"', '(', ')', '-', '_',
 '[', ']', '{', '}', '/', '\\', '|', '&', '*', '@', '#', '$',
  '%', '^', '~', '`', '+', '=', '<', '>', '\n', '\t'};


String[] fonts = {"Arial", "Consolas", "Comic Sans MS", "Inter", "Times New Roman"};


final String noteStoragePath = "NoteStorage.txt";
final String userStoragePath = "UserInfo.txt";
final String passwordStoragePath = "Password.txt";
final String separate = "||||||||||";
final int maxSize = 20;
final int minSize = 10;
int goldCoins = 0;
int fontSize = 5;
String noteFontStr = "Arial";
Mode mode = new Mode();

String password;
Boolean authenticated = false;
Boolean firstTime = true;

ArrayList<Note> notes = new ArrayList<Note>();
Note currentNote;
Font UIFont;
Font noteFont = new Font(noteFontStr, Font.PLAIN, fontSize);

final int buttonsUpBound = 40;
final int buttonHeight = 40;
int scrolledDist = 0;


void setup()
{
  
  size(1000, 700);
  
  initializeUIFont();
  
  importPassword();
  
  showAuthenticationScreen();
      
}



void draw()
{
  if (!authenticated)
    background(200, 200, 200);
  else
    background(mode.background);
}


void exit()
{
  
  if (authenticated)
  {
    saveNotes();
    saveUserData();
    storePassword();
  }
}


void startApp()
{
  importUserData();
  importNotes();
  
  saveUserData();
  saveNotes();
  storePassword();
  createGUI();
}
