using System;
using BaleenLib;

namespace MySQL.Baleen
{
    class MainClass
    {
        public static string MySqlStr = "Server=localhost;Database=mysql;Uid=baleen_user;Pwd=8t6er555;SslMode=none;";

        public static void Main(string[] args)
        {
            SimpleTest();
            //TestMysqlConnection();
        }
        static void TestMysqlConnection()
        {
            bool res = BaleenLib.Utility.Tests.TestMysqlConnection(MySqlStr);
        }
        public static void SimpleTest()
        {
            //string mysqlConn = "";

            AtomSetParser.AtomizeDirectories(
                @"C:\test\",
                true, 
                MySqlStr,
                60 * 60 * 12,
                1899, 
                2099);


        }
    }
}
