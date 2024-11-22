
/* 

    Software Name: SwiftNotes
    Author: Youssef, Mariam, Ricky
    Date: November 22nd, 2024

*/

// IMPORTING NECESSARY PACKAGES

import g4p_controls.*;
import java.util.*;
import java.awt.Font;
import java.io.File;
import java.io.IOException;
import java.awt.FontFormatException;
import java.lang.NullPointerException;


// GLOBAL VARIABLES, ARRAYS OR CONSTANTS

// Arrays

char[] punctuation = {',', '.', ':', ';', '!', '?', '\'', '\"', '(', ')', '-', '_',
 '[', ']', '{', '}', '/', '\\', '|', '&', '*', '@', '#', '$',
  '%', '^', '~', '`', '+', '=', '<', '>', '\n', '\t'};

String[] fonts = {"Arial", "Consolas", "Comic Sans MS", "Inter", "Times New Roman"};

// Storage & input/output related

final String noteStoragePath = "NoteStorage.txt";
final String userStoragePath = "UserInfo.txt";
final String passwordStoragePath = "Password.txt";
final String separate = "||||||||||";
ArrayList<Note> notes = new ArrayList<Note>();
Note currentNote;

// User related

int goldCoins = 0;
String password;
Boolean authenticated = false;
Boolean firstTime = true;

// UI Related

final int maxSize = 20; // max font size
final int minSize = 10; // min font size
int fontSize = 15;
String noteFontStr = "Arial";
Font UIFont;
Font noteFont = new Font(noteFontStr, Font.PLAIN, fontSize);

Mode mode = new Mode();

PImage coin;
PImage logo;

// Scrolling Related

final int buttonsUpBound = 100;
final int paddingDown = 80;
final int buttonHeight = 40;
final int sidebarWidth = 300;
final int buttonWidth = sidebarWidth - 70;

// When we scroll up we minus, vice versa
int scrolledDist = 0; // Tracks how far the user scrolled (0 is top and we have a limit of a negative number which is buttom(based on the notes))

// CORE FUNCTIONS


void setup()
{
  
  size(1000, 700);

  // Loading the SwiftNotes Logo

  logo = loadImage("SwiftNotes Logo.png");
  logo.resize(150, 75);

  // Loading the coin image next to gold coin count
  coin = loadImage("Gold Coin.png");
  coin.resize(75,60);

  // UI Font initialized

  initializeUIFont();

  // Import the password and get ready for authentication

  importPassword();

  //Displays the autentication screen before creating GUI

  showAuthenticationScreen();
      
}



void draw()
{
  // If the user has not entered the note app

  if (!authenticated)
  {
    background(200, 200, 200);
    image(logo, (width - logo.width)/2, 5);
  }
  else // After authentication will display the notes window
  {
    //background determined by light/dark mode
    background(mode.background);

    //Logo display
    image(logo, ((sidebarWidth + width) - logo.width)/2, 5);

    //Coin display
    image(coin, 350, 20);

    //fill determined by light/dark mode
    fill(mode.foreground);

    //Text size for displaying gold coins
    textSize(40);

    //gold coin count text
    text("\u00D7 " + str(goldCoins), 420, 60);
  }
  
}

// WHEN THE USER CLICKS THE CLOSE

void exit()
{
  // if the user is an authenticated user we save their data
  if (authenticated)
  {
    //save the notes, user data, and password set
    saveNotes();
    saveUserData();
    storePassword();
  }
}

// START THE NOTES APP (ENTER THE NOTE INTERFACE)

void startApp()
{
  //import user data and notes (if old user)

  if(!firstTime) 
  {
    importUserData();
    importNotes();
  }

  //save the notes, user data, and password set, and creates the GUI

  saveUserData();
  saveNotes();
  storePassword();
  createGUI();
}
