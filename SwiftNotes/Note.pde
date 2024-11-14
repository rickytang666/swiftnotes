class Note
{
    // FIELDS

    String title;
    String createdDate;
    String text;
    int wordNum;



    // CONSTRUCTOR

    Note(String t)
    {
        this.title = t;
        this.text = "";
        this.wordNum = 0;
    }



    // METHODS

    void saveNote()
    {
        // Empty for now
    }


    
    void updateWordNum()
    {
        this.wordNum = countWordNum(this.text);
    }
}
