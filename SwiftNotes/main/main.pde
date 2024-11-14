String password;

void setup() {
  
}

void draw() {
  createGUI();
}

void setNewPassword(String newPass) {
  password = newPass;
}

int countWordNum(String text) {
  int num = 0;
  String[] wordsWithComma = text.split(" ");
  ArrayList<String> words = new ArrayList<String>();
  
  for (int i = 0; i<wordsWithComma.length; i++) {
    if(checkWord(wordsWithComma, ",")) {
      String[] s = wordsWithComma[i].split(",");
      for (int j = 0; j<s.length; j++) {
        words.add(s[j]);
      }
    } else {
      words.add(wordsWithComma[i]);
    }
  }
  num = words.size();
  return num;
}

boolean checkWord(String[] search, String s) {
  boolean check = false;
  for(int i = 0; i<search.length; i++) {
    if(s.equalsIgnoreCase(search[i])) {
      check = true;
    }
  }
  return check;
}
