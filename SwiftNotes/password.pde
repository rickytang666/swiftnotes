// THIS FILE IS FOR FUNCTIONS FOR PASSWORDS


//Displays the authentication screen before letting the user to enter the note app

void showAuthenticationScreen() 
{
  
  // The welcome text

  String welcomeStr = "Welcome to SwiftNotes – your all-in-one note-taking app with customization, tabs, and fun rewards for staying productive!";
  welcome = new GLabel(this, (width - width/1.5)/2, 80, width/1.5, 150, welcomeStr);
  welcome.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  Font welcomeFont = new Font("Georgia", Font.BOLD, 20);
  welcome.setFont(welcomeFont);
  welcome.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  
  // Password field

  input = new GPassword(this, 405, height / 2 - 80, 200, 30);
  input.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  
  // First time user is create password, while old user just enter password

  String str = (firstTime ? "Create" : "Enter") + " Password:";
  
  inputLabel = new GLabel(this, (width - 150)/2, 222, 150, 50, str);
  inputLabel.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  inputLabel.setFont(UIFont);
  
  if (firstTime)
  {
    println("First time user, needs to confirm password");

    // First time user needs to add another field for confirming password
    

    // Label for reminder

    confirmLabel = new GLabel(this, 425, 306, 200, 30, "Confirm Password: ");
    confirmLabel.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
    confirmLabel.setFont(UIFont);
    
    // Actual input field

    confirm = new GPassword(this, 405, height/2 - 10, 200, 30);
    confirm.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
       
  } 
  
  // Submit password button

  submit = new GButton(this, 450, height / 2 + 80, 100, 30, "Submit");
  submit.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  submit.addEventHandler(this, "submitPassword1");
  submit.setFont(UIFont);
  

  // The label for warning if the password has problems

  warning = new GLabel(this, 380, height / 2 + 150, 300, 50, "");
  warning.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  warning.setFont(UIFont);
  
}

// Used to check if the password is valid

public void submitPassword1(GButton source, GEvent event) 
{
  
  if (firstTime)
  {
    if (!input.getPassword().equals(confirm.getPassword())) // for first time the confirm must match
    {
      warning.setText("Passwords don't match. Try again.");
    }
    else if (input.getPassword().length() < 3) // require at least 3 char in length
    {
      warning.setText("Password has to be at least 3 characters in length");
    }
    else
    {
      authenticated = true;
      password = input.getPassword();
      
    }
  }
  else
  {
    // For old user just compare with the actual password

    if (!input.getPassword().equals(password))
    {
      warning.setText("Incorrect Password");
    }
    else
    {
      authenticated = true;
    }
  }
  
  if (authenticated) 
  {
    // Cleanup authentication screen (dispose the GUI)

    welcome.dispose();
    
    input.dispose();
    inputLabel.dispose();
    
    if (confirm != null)
      confirm.dispose();
      
    if (confirmLabel != null)
      confirmLabel.dispose();
    
    submit.dispose();
    warning.dispose();

    println("Authentication successful!");

    // After sucessful authentication, start the note app for user

    startApp();
  } 
  
}
