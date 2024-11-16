// this file is for functions for passwords

void setNewPassword(String newPass) 
{
  password = newPass;
}

void showAuthenticationScreen() 
{
  // make background a little bit grey
  
  input = new GPassword(this, 200, height / 2 - 100, 200, 50);
  input.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  
  if (firstTime)
  {
    println("confirm");
    confirm = new GPassword(this, 200, height/2 - 50, 200, 50);
    confirm.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  }
  
  submit = new GButton(this, 200, height / 2 + 80, 100, 30, "Submit");
  submit.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  submit.addEventHandler(this, "submitPassword");
  
  Font labelFont = new Font("Arial", Font.PLAIN, 16);
  
  warning = new GLabel(this, 200, height / 2 + 150, 300, 50, "");
  warning.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  warning.setFont(labelFont);
  
}

public void submitPassword(GButton source, GEvent event) 
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
    
    if (confirm != null)
      confirm.dispose();
    
    submit.dispose();
    warning.dispose();

    println("Authentication successful!");

    startApp();
  } 
  
}
