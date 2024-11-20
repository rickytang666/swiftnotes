//Function counts the number of words
int countWordNum(String input)
{
    for (char c : punctuation)
    {
        input = input.replace(c, ' ');
    }

    String[] words = splitTokens(input, " ");

    return words.length;
}

//Displays the name of the note
String generateUniqueTitle() 
{
    int count = 1;
    //initial title is untitled_
    String baseTitle = "Untitled_";
    String newTitle = baseTitle + str(count);

    // Check if the title already exists in the ArrayList
    while (isTitleExists(newTitle)) 
    {
        count++;
        newTitle = baseTitle + count;
    }

    return newTitle;
}



Boolean isTitleExists(String title)
{
    for (Note n : notes)
    {
        if (n.title.equals(title))
        {
            return true;
        }
    }

    return false;
}



String getTimeStr()
{
    String timeStr = str(year()) + "-" + str(month()) + "-" + str(day()) + " "
    + str(hour()) + ":" + str(minute()) + ":" + str(second());

    return timeStr;
}
