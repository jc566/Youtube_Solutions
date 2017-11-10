using System;
//include these other assemblies
using System.Linq; //for LINQ...
using System.Collections; //for Collections...
using System.Xml.Linq; //these are needed for XML related stuff 
using System.Collections.Generic; //these are needed for XML related stuff 
using System.Data; //for Datatable & Datasets
using System.Data.SqlClient; //for SQL...
using System.Diagnostics; //for outputting messages to VS output window


/*
 * MSDN Documentaion page for LINQ :
 * https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/linq/introduction-to-linq-queries
* There are 3 parts to a LINQ query.
* 1. Data Source
* 2. Query Creation
* 3. Query Execution
* */

namespace Learning_LINQ
{


    class LINQ_Examples
    {
        //A WHERE filter can use a function that returns bools in addition to the other 2 common filter methods.
        static bool GetGermany(string myString)
        {
            string Germany = "Germany";

            if (myString.ToLower().Equals(Germany.ToLower()))
                return true;
            else
                return false;
        }
    

    static void Main(string[] args)
        {
            #region MSDN Example

            //Uncomment this region to see an example similar to the one MSDN provided.

            /* 
             
            //1.Data Source
            int[] sampleArray = new int[10] { 1,2,3,4,5,6,7,8,9,10 }; //this is the array we will use to practice some LINQ queries

            //2. Query Creation
            var divBy2query = from number in sampleArray //query to find the numbers divisible by 2
                              where number % 2 == 0
                              select number;

            var greaterThan5query = from number in sampleArray //query to find numbers larger than 5
                                    where number > 5
                                    select number;

            //Console.WriteLine(divBy2query.GetType()); //Uncomment to see what type divBy2query is

            //*Using Multiple Filters aka WHERE clauses. These are 2 common implementations you can use.*
            //Filter Method 1 : Using AND operator
            var usingANDfilter = from number in sampleArray
                                       where number % 2 == 1 && number < 5
                                       select number;

            //Filter Method 2 : Using multiple WHERE clauses
            var usingMultiWHEREfilter = from number in sampleArray
                                        where number % 2 == 1
                                        where number < 5
                                        select number;



            //3.Query Execution
            Console.WriteLine("Output for divBy2query execution is : \n"); 
            foreach(int number in divBy2query)
            {
                Console.WriteLine("{0}", number); 
            }
            Console.WriteLine("\nOutput for greaterThan5query execution is : \n");
            foreach (int number in greaterThan5query)
            {
                Console.WriteLine("{0}", number); 
            }
            Console.WriteLine("\nOutput for usingANDfilter execution is : \n");
            foreach (int number in usingANDfilter)
            {
                Console.WriteLine("{0}", number);
            }
            Console.WriteLine("\nOutput for usingMultiWHEREfilter execution is : \n");
            foreach (int number in usingMultiWHEREfilter)
            {
                Console.WriteLine("{0}", number);
            }

            */

            #endregion

            #region String Examples
            //Uncomment this region to see some examples of LINQ with strings

            /* 

            //1.Data Source
            string[] myCountries = new string[5] { "United States", "China", "Germany", "Iceland", "India" };

            //2. Query Creation
            var containsLetterI = from country in myCountries //query to find strings that have the letter I in them
                                  where (country.ToLower().Contains('i')) //its Case Sensitive so remember to use .ToLower() to match
                                  select country;

            var beginsWithI = from country in myCountries     //query to find the strings that begin with the letter I
                              where (country.ToLower().First()) == 'i'
                              select country;

            var matchesString = from country in myCountries   //query to find strings that are equal to string X
                                where (country.Equals("United States")) //has to be an exact match
                                select country;


            //*Using Functions with LINQ
            var usingFunctionFilter = from country in myCountries //query to see if string is Germany
                                      where GetGermany(country)
                                      select country;



            //3. Query Execution
            Console.WriteLine("Output for containsLetterI execution is : \n");
            foreach (string country in containsLetterI)
            {
                Console.WriteLine(country);
            }
            Console.WriteLine("\nOutput for beginsWithI execution is : \n");
            foreach (string country in beginsWithI)
            {
                Console.WriteLine(country);
            }
            Console.WriteLine("\nOutput for matchesString execution is : \n");
            foreach (string country in matchesString)
            {
                Console.WriteLine(country);
            }
            Console.WriteLine("Output for usingFunctionFilter execution is : \n");
            foreach (string country in usingFunctionFilter)
            {
                Console.WriteLine(country);
            }

            */

            #endregion

            #region XML Examples
            /* Get a sample XML Document from MSDN :
             * https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/linq/sample-xml-file-typical-purchase-order-linq-to-xml-1
             * or any other example from here :
             * https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/linq/sample-xml-documents-linq-to-xml
             */

            //Uncomment this region to see some examples of LINQ with XML documents/data

            /* 

            //1. Data Source
            XDocument xmlDoc =  XDocument.Load("C:/Users/Joseph.Choi/Source/Repos/Learning_LINQ/sampleXML.xml"); //file path of xml doc

            //2. Query Creation
            IEnumerable<string> listOfNames = from item in xmlDoc.Descendants("Name") //query that gets the value of the <Name> attributes
                                              select (string)item;

            IEnumerable<string> listOfAddressTypes = from item in xmlDoc.Descendants("Address") //query that gets the <Address Type="var">
                                       select (string)item.Attribute("Type");

            IEnumerable<string> lessThan40 = from item in xmlDoc.Descendants("Item") //query that selects products under the price of $40
                                             where (float)item.Element("USPrice") < 40.0f //condition to be under $40
                                             orderby (string)item.Element("ProductName") //sort the values
                                             select (string)item.Element("ProductName"); //select only the product name to display

            //3. Query Execution
            Console.WriteLine("Output for listOfNames execution is : \n");
            foreach (string name in listOfNames)
            {
                Console.WriteLine(name);
            }
            Console.WriteLine("\nOutput for listOfAddressTypes execution is : \n");
            foreach (string value in listOfAddressTypes)
            {
                Console.WriteLine(value);
            }
            Console.WriteLine("\nOutput for lessThan40 execution is : \n");
            foreach(string value in lessThan40)
            {
                Console.WriteLine(value);
            }

            */

            #endregion

            #region DataTable Examples

            //Uncomment this region to see some examples of LINQ with dataTables

            /* 
            //1. Data Source
            DataTable dogs = new DataTable(); //create a new data table
            dogs.Columns.Add("Breed"); //create the columns
            dogs.Columns.Add("Age");
            dogs.Columns.Add("Name");

            dogs.Rows.Add("Great Dane", 48, "Scooby Doo"); //enter values for rows
            dogs.Rows.Add("Kryptonian", 62, "Krypto");
            dogs.Rows.Add("German Shepard", 62, "Ace");
            dogs.Rows.Add("Shiba Inu", 4, "Doge");
            dogs.Rows.Add("Great Dane", 38, "Scrappy Doo");

            //2. Query Creation
            var isADoo = from dog in dogs.AsEnumerable()  //query that searches for names that contains "Doo"
                             where dog.Field<String>("Name").ToLower().Contains("doo")
                             select dog;

            var superDog = from dog in dogs.AsEnumerable() //query that finds the Kryptonian
                           where dog.Field<string>("Breed") == "Kryptonian"
                           select dog;

            var youngestDog = from dog in dogs.AsEnumerable() //find the youngest dog but not the "proper" way
                              where int.Parse(dog.Field<string>("Age")) < 38 //make sure to convert the value to a integer
                              select dog;

            //3. Query Execution
            Console.WriteLine("\nOutput for isADoo execution is : \n");
            foreach (DataRow row in isADoo)
            {
                Console.WriteLine(row["Name"]);
            }
            Console.WriteLine("\nOutput for superDog execution is : \n");
            foreach (DataRow row in superDog)
            {
                Console.WriteLine(row["Name"] + " is a " + row["Breed"]);
            }
            Console.WriteLine("\nOutput for youngestDog execution is : \n");
            foreach (DataRow row in youngestDog)
            {
                Console.WriteLine(row["Name"] + " is " + row["Age"] + " years old");
            }

            */

            #endregion



            #region SQL Examples

            //Uncomment this region to see some examples of LINQ with SQL

            /* 



            string connectionString = "Data Source=localhost;Initial Catalog=DevOpsTraining;Integrated Security=True; MultipleActiveResultSets=True;";

            try
            {
                SqlConnection connection = new SqlConnection(connectionString); //used for cloud service

                connection.Open();

                //Confirm that DB connection is made.
                if (connection.State == System.Data.ConnectionState.Open)
                {
                    Console.WriteLine("Successfully Connected to Database!\n");

                }
                else
                {
                    Console.WriteLine("Failed to connect to Database!\n");

                }

                Console.WriteLine("You are connected to database called : " + connection.Database);

            }
            //if Connection has failed Print the Error Message
            catch (Exception ex)
            {
                Console.WriteLine("Error: Failed to create a database connection.\n" + ex.Message + "...\n");

                return;
            }

    */

            #endregion

        }
    }
}
