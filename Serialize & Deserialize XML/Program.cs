using System;
using System.IO; //Used for Stream/Text Writer...
using System.Xml.Serialization; //used for XML Serialization...
using System.Xml; //used for XMLReader...

/*
 * XML serialization serializes only the public fields and property values of an object into an XML stream. 
 * https://docs.microsoft.com/en-us/dotnet/standard/serialization/introducing-xml-serialization
 * */

    [XmlRoot ("Employeez", Namespace="www.employee.com")]
    public class Employee
    {
        [XmlAttribute("EmployeeID")]
        public int id { get; set; }
        [XmlElement("FullName")]
        public string Name { get; set; }

        public DateTime DoB { get; set; }
        /*
         * This variable and section is to show how to ignore/exclude an item from serialization
        [XmlIgnore]  
        public string IgnoredString { get; set; }
        */
    }
    class Program
    {
        static void Main(string[] args)
        {
            Employee emp = new Employee();

        /* ------------------------------------------------------------------------------------------------------------------------------*/

            /*Uncomment/Comment this section to Serialize */

            emp.id = 1; //populate data
            emp.Name = "code junkie"; //populate data
            emp.DoB = DateTime.Now; //populate data

            Console.WriteLine(emp.id + " " + emp.Name + " " + emp.DoB); //Uncomment to verify that there are valid values

            TextWriter writer = new StreamWriter("FilePath + FileName");

            XmlSerializer ser = new XmlSerializer(typeof(Employee)); //create serializer
            ser.Serialize(writer, emp); //serialize
            writer.Close(); //close serializer

            //Console.WriteLine(emp.GetType()); //Uncomment to confirm the type of Object --should be Employee in this case.

        /* ------------------------------------------------------------------------------------------------------------------------------*/

            /*Uncomment/Comment this Section to Deserialize */

            XmlSerializer des = new XmlSerializer(typeof(Employee)); //create serializer
                using (XmlReader reader = XmlReader.Create("FilePath + FileName"))
                {
                    emp = (Employee)des.Deserialize(reader); //deserialize
                    Console.WriteLine(emp.id + " " + emp.Name + " " + emp.DoB); //Uncomment to verify that there are valid values
                }
            }
    }

