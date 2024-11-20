
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
import java.lang.NullPointerException;


// Global Variables or Contants

char[] punctuation = {',', '.', ':', ';', '!', '?', '\'', '\"', '(', ')', '-', '_',
 '[', ']', '{', '}', '/', '\\', '|', '&', '*', '@', '#', '$',
  '%', '^', '~', '`', '+', '=', '<', '>', '\n', '\t'};

//Available fonts to choose from
String[] fonts = {"Arial", "Consolas", "Comic Sans MS", "Inter", "Times New Roman"};

//Global variables
final String noteStoragePath = "NoteStorage.txt";
final String userStoragePath = "UserInfo.txt";
final String passwordStoragePath = "Password.txt";
final String separate = "||||||||||";
final int maxSize = 20;
final int minSize = 10;
PImage coin;
int goldCoins = 0;
int fontSize = 12;
String noteFontStr = "Arial";
Mode mode = new Mode();
String password;
Boolean authenticated = false;
Boolean firstTime = true;
ArrayList<Note> notes = new ArrayList<Note>();
Note currentNote;
Font UIFont;
Font noteFont = new Font(noteFontStr, Font.PLAIN, fontSize);
PImage logo;
final int buttonsUpBound = 100;
final int paddingDown = 80;
final int buttonHeight = 40;
final int sidebarWidth = 300;
final int buttonWidth = sidebarWidth - 70;
int scrolledDist = 0;

//setup
void setup()
{
  
  size(1000, 700);
  //Loading the SwiftNotes Logo
  logo = loadImage("SwiftNotes Logo.png");
  logo.resize(150, 75);
  //Loading the coin image next to gold coin count
  coin = loadImage("Gold Coin.png");
  coin.resize(75,60);
  //UI Font initialized
  initializeUIFont();
  //Uses the password set by the user
  importPassword();
  //Displays the password screen
  showAuthenticationScreen();
      
}


//Draw loop
void draw()
{
  //Only if password is incorrect
  if (!authenticated)
  {
    background(200, 200, 200);
    image(logo, (width - logo.width)/2, 5);
  }
  else
   //Will display the notes window
  {
    //background determined by light/dark mode
    background(mode.background);
    //Logo display
    image(logo, ((sidebarWidth + width) - logo.width)/2, 5);
    //Coin display
    image(coin, 350, 20);
    //fill determined by light/dark mode
    fill(mode.foreground);
    //General Text Size
    textSize(40);
    //gold coin count
    text("\u00D7 " + str(goldCoins), 420, 60);
  }
  
}

//exit the draw loop
void exit()
{
  //if password was correct
  if (authenticated)
  {
    //save the notes, user data, and password set
    saveNotes();
    saveUserData();
    storePassword();
  }
}

//When program starts running
void startApp()
{
  //import user data and notes
  if(!firstTime) {
    importUserData();
    importNotes();
  }
  //save the notes, user data, and password set, and creates the GUI
  saveUserData();
  saveNotes();
  storePassword();
  createGUI();
}
