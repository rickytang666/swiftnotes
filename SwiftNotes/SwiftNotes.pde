
/* 

    Software Name: SwiftNotes
    Author: Youssef, Mariam, Ricky
    Date: November 22nd, 2024

*/

// Importing Packages
import g4p_controls.*;

// Global Variables/Contants

char[] punctuation = {',', '.', ':', ';', '!', '?', '\'', '\"', '(', ')', '-', '_',
 '[', ']', '{', '}', '/', '\\', '|', '&', '*', '@', '#', '$',
  '%', '^', '~', '`', '+', '=', '<', '>', '\n', '\t'};


String defaultFilePath = "SaveNotes.txt";
PrintWriter writer = createWriter(defaultFilePath);


void setup()
{
    size(1000, 700);
    createGUI();
}



void draw()
{
    
}
