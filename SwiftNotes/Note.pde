class Note
{
    // FIELDS

    String title;
    String createdTime;
    String text;
    int wordNum;



    // CONSTRUCTOR

    Note(String t)
    {
        this.title = t;
        this.createdTime = getTimeStr();
        this.text = "";
        this.wordNum = 0;
    }



    // METHODS
    
    void updateWordNum()
    {
        // call the count word num to update its word number
        this.wordNum = countWordNum(this.text);
    }
}
