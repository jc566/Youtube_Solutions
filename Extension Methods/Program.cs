//Link to Youtube Video https://www.youtube.com/watch?v=UGJ2LIgFRN8&feature=youtu.be
using System;
/**************************************************************************************
 * Extension methods are useful especially when you need to reuse a method frequently.*
 * For example, .ToString() is an extension method.                                   *
 * We will cover 2 simple examples of how to create and use an Extension Method.      *
 *************************************************************************************/
    public static class ExtensionMethods
    {
        //This method replaces the value of a string that was sent to it
        public static string ReplaceStringValue(this string value)
        {
            value = "I am going to replace whatever the original value was\n"; //give a new data for value variable
            return value; //return it
        }       

        public static string UppercaseFirstLetter(this string value)
        {
            char[] array = value.ToCharArray(); //convert value to a character array
            array[0] = char.ToUpper(array[0]); //set the first element of char array to an uppercase
            return new string(array); //return a new instance of this array as a string
        }
    }
    class Program
    {
        static void Main(string[] args)
        {
            //result set for ReplaceStringValue Method
            string myString = "This string should not be in console output";
            myString = myString.ReplaceStringValue();
            Console.WriteLine(myString);
            
            //result set for UppercaseFirstLetter Method
            string lowercaseString = "lowercase";
            lowercaseString = lowercaseString.UppercaseFirstLetter();
            Console.WriteLine(lowercaseString + "\n");
        }
    }

