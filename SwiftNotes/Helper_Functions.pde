// THIS FILE IS FOR FUNCTIONS OF GENERAL ALGORITHMS OR USEFUL FUNCTIONS

//Function counts the number of words

int countWordNum(String input)
{
    // go through the punctuations array, and replace any punctuations in the text as space
    for (char c : punctuation)
    {
        input = input.replace(c, ' ');
    }

    // split the text by spaces, and count the number of fragments

    String[] words = splitTokens(input, " ");

    return words.length;
}

// Generate a unique (not overlapping) name for a new note

String generateUniqueTitle() 
{
    int count = 1;

    //initial title is Untitled_

    String baseTitle = "Untitled_";
    String newTitle = baseTitle + str(count);

    // Check if the title already exists in the note list

    while (isTitleExists(newTitle)) 
    {
        // If already exists, we neet to change a number
        count++;
        newTitle = baseTitle + str(count);
    }

    return newTitle;
}



Boolean isTitleExists(String title)
{

    // This function goes through the notes and check if a title already exists in any note

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

    // Generate the create time string for a new create note
    
    String timeStr = str(year()) + "-" + str(month()) + "-" + str(day()) + " "
    + str(hour()) + ":" + str(minute()) + ":" + str(second());

    return timeStr;
}
