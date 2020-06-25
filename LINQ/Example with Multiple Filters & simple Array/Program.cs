using System;
using System.Linq;

namespace LINQ_Queries_Video
{
    class Program
    {
        //1. Data Source
        //2. Query Creation
        //3. Query Execution
        static void Main(string[] args)
        {
            //1. Data Source
            int[] sampleArray = new int[10] { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };

            //2. Query Creation
            var usingANDfilter = from number in sampleArray
                              where number % 2 == 1 && number < 5
                              select number;

            var usingMultiWHEREfilter = from number in sampleArray
                                    where number % 2 == 1
                                    where number < 5
                                    select number;

            //3. Query Execution
            foreach (int number in usingANDfilter)
            {
                Console.WriteLine(number);
            }
            foreach (int number in usingMultiWHEREfilter)
            {
                Console.WriteLine(number);
            }

        }
    }
}
