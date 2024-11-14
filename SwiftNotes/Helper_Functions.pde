
int countWordNum(String input)
{
    for (char c : punctuation)
    {
        input = input.replace(c, ' ');
    }

    String[] words = splitTokens(input, " ");

    return words.length;
}



void clearFile()
{
    
}
