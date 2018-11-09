using System;
using BaleenLib;

namespace MySQL.Baleen
{
    class MainClass
    {
        public static string MySqlStr = "Server=localhost;Database=mysql;Uid=baleen_user;Pwd=8t6er555;SslMode=none;";

        public static void Main(string[] args)
        {
            //TestFileSplitter();
            SimpleTest();
            //TestMysqlConnection();
        }
        static void TestFileSplitter()
        {
            string filePath = "/home/daniel/Desktop/NPI/npi_data_20181108.qcsv";
            int parts = 10;
            string newDirectory = "/home/daniel/Desktop/NPI/split";
            string newFilePrefix = "NPI";
            BaleenLib.FileSplitter.SimpleWithHeader(
            filePath,
            parts,
            newDirectory,
                newFilePrefix);

        }
        static void TestMysqlConnection()
        {
            bool res = BaleenLib.Utility.Tests.TestMysqlConnection(MySqlStr);
        }
        public static void SimpleTest()
        {
            //remember: this uses an admin connection to
            //Mysql to work, it needs to create databases
            AtomSetParser.AtomizeDirectories(
                "/home/daniel/Desktop/NPI/split/",
                true,
                MySqlStr,
                60 * 60 * 12,
                1899,
                2099);
        }
    }
}
