using System;
using System.Xml.Linq; //required for XML & XDocument, XElement, etc...

namespace Create_XML_with_Code
{
    /*
     * https://msdn.microsoft.com/en-us/library/bb338517(v=vs.110).aspx
     * Base Sample of how to create a XML document with Code
     * */
    class CreateXML
    {
        static void Main(string[] args)
        {
            //Create a new XML Document
            XDocument xDoc = new XDocument(
                //Not mandatory to create the declaration
                new XDeclaration("1.0", "utf-8", "yes"),
                new XElement("RootName", //this first level XElement is the root
                    new XElement("Child1", "data1"), //basic child element
                    new XElement("Child2", //child element with attributes, in this case, name attribute and its value
                        new XAttribute("Name", "CodeJunkie"), "MyValue") //the second string is the value between brackets

                )//end of root level XElement
            );
            //save the data into a file name/path.
            xDoc.Save("C:/Users/Joseph.Choi/Source/Repos/Create_XML_with_Code/Create_XML_with_Code/CreatedXMLdoc.xml");
  
            /*************************************************************************************************************************/

            //More indepth XML Document with multiple Attributes
            XDocument xDoc2 = new XDocument(
                new XDeclaration("1.0", "utf-8", "yes"),
                new XElement("RootName", //Create the Root Element with specified Attributes such as Name
                    new XAttribute("Name", "MyRootName"), 

                new XElement("Employee1", //Create first Child that has mutliple Attributes
                    new XAttribute("FullName", "Code Junkie"),
                    new XAttribute("JobRole", "Programmer"),
                    new XAttribute("Salary", "75000")), 

                new XElement("Employee2",
                    new XAttribute("FullName", "Junk Code"),
                    new XAttribute("JobRole", "Data Analyst"),
                    new XAttribute("Salary", "95000"), "Employee02") //the second string is the value between brackets

                    ) //end of Root Element
                );
            //save the data into a file name/path.
            xDoc2.Save("C:/Users/Joseph.Choi/Source/Repos/Create_XML_with_Code/Create_XML_with_Code/InDepthXMLdoc.xml");
        }
    }
}
