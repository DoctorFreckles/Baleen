using System;
using System.Text;
using System.IO;
using MySql.Data.MySqlClient;

namespace MySQL.Baleen
{
    public class LoadMySqlDumpFiles
    {
        public static void SplitDataFile(string fullName, int lines)
        {
            //FileInfo fi = new FileInfo(fullName);

            //string newDir = fi.DirectoryName + "/split_dumps/";

            //if(Directory.Exists(newDir))
            //{
            //    Directory.Delete(newDir, true);
            //}

            //Directory.CreateDirectory(newDir);

            //StreamReader sr = new StreamReader(fullName);

            //int curLine = 0;

            //while(!sr.EndOfStream)
            //{
            //    string ln = sr.ReadLine();
            //    curLine++;

            //}


            //sr.Close();

        }

        public static void LoadFiles(
            string dataFile,
            string dataBase,
            string serverName,
            string port,
            string dbUser,
            string dbPW
        )
        {
            string connStr = $"Server={serverName};Port={port};Database={dataBase};Uid={dbUser};Pwd={dbPW};SslMode=none;";
            MySqlConnection c = null;

            try
            {
                c = new MySqlConnection(connStr);
                c.Open();

                StreamReader srSchema = new StreamReader(dataFile);

                StringBuilder cmds = new StringBuilder();

                int cmdCount = 0;

                while(!srSchema.EndOfStream)
                {
                    string ln = srSchema.ReadLine();

                    if (ln.Trim().Length < 2) continue;

                    string subs = ln.Substring(0, 2);
                
                    if(subs == "--" ||
                      subs == "/*")
                    {
                        continue;
                    }

                    cmds.Append(ln);

                    string ends = ln.Substring(ln.Trim().Length - 1, 1);

                    if(ends == ";")
                    {
                        string strCommand = cmds.ToString();

                        if(!strCommand.StartsWith("CREATE DATABASE", StringComparison.OrdinalIgnoreCase) &&
                           !strCommand.StartsWith("USE ", StringComparison.OrdinalIgnoreCase))
                        {
                            MySqlCommand cmd = new MySqlCommand(strCommand, c);

                            int res = cmd.ExecuteNonQuery();


                            cmdCount++;

                            Console.WriteLine("Cmd exec count: " + cmdCount.ToString() + ", RES: " + res.ToString());

                        }

                        cmds = new StringBuilder();
                    }
                }
            }
            catch(Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            finally
            {
                if (c != null) c.Close();
            }
        }
    }
}
