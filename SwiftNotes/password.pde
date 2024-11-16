// this file is for functions for passwords

void setNewPassword(String newPass) 
{
  password = newPass;
}

void showAuthenticationScreen() 
{
  // make background a little bit grey
  
  Font labelFont = new Font("Arial", Font.PLAIN, 16);
  
  input = new GPassword(this, 200, height / 2 - 100, 200, 50);
  input.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  
  inputLabel = new GLabel(this, 50, height / 2 - 100, 100, 50, "Enter Password: ");
  inputLabel.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  inputLabel.setFont(labelFont);
  
  if (firstTime)
  {
    println("First time user, needs to confirm password");
    
    confirm = new GPassword(this, 200, height/2 - 50, 200, 50);
    confirm.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
    
    confirmLabel = new GLabel(this, 50, height / 2 - 50, 100, 50, "Confirm Password: ");
    confirmLabel.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
    confirmLabel.setFont(labelFont);
  }
  
  submit = new GButton(this, 200, height / 2 + 80, 100, 30, "Submit");
  submit.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  submit.addEventHandler(this, "submitPassword1");
  
  warning = new GLabel(this, 200, height / 2 + 150, 300, 50, "");
  warning.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  warning.setFont(labelFont);
  
}

public void submitPassword1(GButton source, GEvent event) 
{
  
  if (firstTime)
  {
    if (!input.getPassword().equals(confirm.getPassword()))
    {
      warning.setText("Passwords don't match. Try again.");
    }
    else if (input.getPassword().length() < 3)
    {
      warning.setText("Password has to be at least 3 characters in length");
    }
    else
    {
      authenticated = true;
      password = input.getPassword();
      storePassword();
    }
  }
  else
  {
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
    // Cleanup authentication screen
    input.dispose();
    
    inputLabel.dispose();
    
    if (confirm != null)
      confirm.dispose();
      
    if (confirmLabel != null)
      confirmLabel.dispose();
    
    submit.dispose();
    warning.dispose();

    println("Authentication successful!");

    startApp();
  } 
  
}
