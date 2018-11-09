using System;
using System.Data;
using MySql.Data.MySqlClient;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Configuration;

namespace BaleenLib
{
    public class AtomSetParser
    {
        public static DirectoryInfo workingDir = new DirectoryInfo("/var/lib/mysql-files/");
        public static string GetCreateBsetTable(string tableName)
        {

        return $@"
       
create table `{tableName}`
(
Line_ID bigint not null,  
As_Short_Text_LTE_400  nvarchar(400),
As_Long_Text_LTE_4000   nvarchar(4000),
As_Year  int,
As_Month int,
As_Day   int,
As_Hour  int,
As_Minute    int,
As_Second    int,
As_Millisecond   int,
As_Double    double,
As_Long  bigint,
As_Bool  TINYINT(1),
YMD_hms_Key int,
PRIMARY KEY (Line_ID)
) ENGINE=MyISAM;

";
        }

        private static Regex CSVandQUOTESplit =
            new Regex(@""",""", RegexOptions.Compiled);
        private static string[] CsvQuoteSplit(string ln)
        {
            if (String.IsNullOrEmpty(ln)) return null;
            string ln2 = ln.Trim();
            if (ln2.Length < 1) return null;
            return CSVandQUOTESplit.Split(ln2);
        }
        public static void BulkLoadAtomizedFiles(
            string loadFolder, 
            string NewDBNameIn, 
            string SqlServerConnection,
            int LoadTimeout)
        {
            if (!Directory.Exists(loadFolder)) return;

            string NewDBName = "BAL_" + NewDBNameIn.Replace("  ", " ").Trim().Replace(' ', '_');

            DirectoryInfo di = new DirectoryInfo(loadFolder);
            List<FileInfo> fins = (from f in di.GetFiles()
                                   orderby f.Length descending
                                   where
                                   f.Extension.ToLower() == ".tab"
                                   select f).ToList<FileInfo>();
            if (fins.Count < 1) return;
            MySqlConnection c = null;
            try
            {
                c = new MySqlConnection(SqlServerConnection);
                c.Open();

                MySqlCommand cmd = new MySqlCommand($"DROP DATABASE if exists `{NewDBName}`;", c);
                int dropi = cmd.ExecuteNonQuery();

                string dbDDL_CreateDB = $@"CREATE DATABASE `{NewDBName}`;";
                cmd = new MySqlCommand(dbDDL_CreateDB, c);
                cmd.CommandTimeout = 1000;
                Console.WriteLine("Creating DB: " + NewDBName);
                int createDBResult = cmd.ExecuteNonQuery();

                System.Threading.Thread.Sleep(500);

                cmd = new MySqlCommand($"use `{NewDBName}`;", c);
                int chg = cmd.ExecuteNonQuery();

                foreach (FileInfo f in fins)
                {
                    string tableName = f.Name.Replace(f.Extension, "");
                    Console.WriteLine("Creating Table: " + tableName);

                    string sqlLoadTable = $@"
                
LOAD DATA local INFILE '{f.FullName}' INTO TABLE `{NewDBName}`.`{tableName}` IGNORE 1 LINES;

";
                    string sqlCreateTable = GetCreateBsetTable(tableName);
                    try
                    {
                        cmd = new MySqlCommand(sqlCreateTable, c);
                        cmd.CommandTimeout = LoadTimeout;
                        int res = cmd.ExecuteNonQuery();
                        System.Threading.Thread.Sleep(500);
                        cmd = new MySqlCommand(sqlLoadTable, c);
                        cmd.CommandTimeout = LoadTimeout;
                        res = cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.Message);
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (c != null)
                {
                    c.Close();
                }
            }
        }
        public static void AtomizeDirectories(
            string dbSourcesPath,
            bool createDB,
            string sqlAdminConnection,
            int loadTimeout,
            int minYear,
            int maxYear)
        {
            if (!Directory.Exists(dbSourcesPath)) return;
            DirectoryInfo di = new DirectoryInfo(dbSourcesPath);
            DirectoryInfo[] dirs = di.GetDirectories();
            foreach (DirectoryInfo d in dirs)
            {
                Console.WriteLine("Building DB:" + d.Name);
                AtomizeDirectory(d.FullName, createDB, sqlAdminConnection, loadTimeout, minYear, maxYear);
            }
        }
        public static void AtomizeDirectory(
            string sourceDirectoryPath, 
            bool createDB,
            string sqlAdminConnection,
            int loadTimeout,
            int minYear,
            int maxYear)
        {
            if (!Directory.Exists(sourceDirectoryPath)) return;
            DirectoryInfo di = new DirectoryInfo(sourceDirectoryPath);
            Dictionary<string, StreamWriter> writers = new Dictionary<string, StreamWriter>();
            long objectID = 0;
            List<FileInfo> fins = (from f in di.GetFiles()
                                   orderby f.Length descending
                                   where 
                                   f.Extension.ToLower() == ".csv" ||
                                   f.Extension.ToLower() == ".qcsv" ||
                                   f.Extension.ToLower() == ".tab" ||
                                   f.Extension.ToLower() == ".pipe" ||
                                   f.Extension.ToLower() == ".hat"
                                   select f).ToList<FileInfo>();

            if (fins.Count < 1) return;

            File.WriteAllText(sourceDirectoryPath + "/create_baleen_sets.start", DateTime.Now.ToString());

            string atomFiles = sourceDirectoryPath + "/baleen/";

            //string atomFiles = workingDir.FullName + "/" + Guid.NewGuid().ToString() + "_";

            foreach (FileInfo f in fins)
            {
                AtomizeFile(f.FullName, ref objectID, writers, atomFiles, minYear, maxYear);
            }

            if (writers.Keys.Count > 0)
            {
                foreach (string key in writers.Keys)
                {
                    if (writers[key] != null)
                    {
                        writers[key].Close();
                    }
                }
            }

            if (createDB)
            {
                BulkLoadAtomizedFiles(atomFiles, di.Name, sqlAdminConnection, loadTimeout);
            }

            File.WriteAllText(sourceDirectoryPath + "/max_object_id.ido", objectID.ToString());
            File.WriteAllText(sourceDirectoryPath + "/create_baleen_sets.end", DateTime.Now.ToString());
        }

        public static object GetConvertedValue(string val, int minYr, int maxYr)
        {
            string v2 = val.Trim().ToUpper();
            string dtm = v2.Replace('"', ' ').Replace("'", "").Trim();
            string number = v2
                .Replace('"', ' ')
                .Replace('(', '-')
                .Replace(')', ' ')
                .Replace('$', ' ')
                .Replace('[', ' ')
                .Replace(']', ' ')
                .Replace('%', ' ')
                .Replace(",", "")
                .Trim();
            if (String.IsNullOrEmpty(v2)) return null;
            double objDbl = 0.0;
            long objLong = 0;
            DateTime objDtm = DateTime.MinValue;
            bool containsAlphas = false;
            foreach (char c in v2)
            {
                if (Char.IsLetter(c) && c != 'E')
                {
                    containsAlphas = true;
                    break;
                }
            }

            if (long.TryParse(number, out objLong) && containsAlphas == false)
            {
                return objLong;
            }
            else if (double.TryParse(number, out objDbl) && containsAlphas == false)
            {
                return objDbl;
            }
            else if (DateTime.TryParse(dtm, out objDtm))
            {
                if ((dtm.Contains('/') ||
                    dtm.Contains('\\') ||
                    dtm.Contains('-')) &&
                    objDtm.Year >= minYr &&
                    objDtm.Year <= maxYr)
                {
                    return objDtm;
                }
                else return null;
            }
            else return null;
        }

        public static void AtomizeFile(
            string sourceFile, 
            ref long objectID, 
            Dictionary<string,StreamWriter> writers,
            string AtomFiles,
            int minYear,
            int maxYear)
        {
            if(Directory.Exists(AtomFiles))
            {
                Directory.Delete(AtomFiles, true);
            }

            Directory.CreateDirectory(AtomFiles);

            FileInfo f = new FileInfo(sourceFile);

            bool isCSVPlusQuoteDelim = false;

            char delim = ' ';

            if (f.Extension.ToLower() == ".qcsv")
            {
                isCSVPlusQuoteDelim = true;
            }
            else if (f.Extension.ToLower() == ".csv")
            {
                delim = ',';
            }
            else if (f.Extension.ToLower() == ".tab")
            {
                delim = '\t';
            }
            else if (f.Extension.ToLower() == ".pipe")
            {
                delim = '|';
            }
            else if (f.Extension.ToLower() == ".hat")
            {
                delim = '^';
            }
            else return;

            string fn = f.Name.Trim();
            
            if (fn.Length > 100)
            {
                fn = fn.Substring(0, 100);
            }
            
            Console.WriteLine(f.Name);
            
            StreamReader sr = new StreamReader(f.FullName);
            
            string hdrLine = sr.ReadLine();
            
            string[] hdr = null;
            
            if (isCSVPlusQuoteDelim)
            {
                hdr = CsvQuoteSplit(hdrLine);
            }
            else
            {
                hdr = hdrLine.Split(delim);
            }

            while (!sr.EndOfStream)
            {
                try
                {
                    objectID++;
                    if (objectID % 1000 == 0)
                    {
                        Console.WriteLine("Processing File: " + f.Name);
                        Console.WriteLine("Fact Processing Object ID: " + objectID.ToString());
                    }
                    string datLine = sr.ReadLine();
                    string[] dat = null;
                    if (isCSVPlusQuoteDelim)
                    {
                        dat = CsvQuoteSplit(datLine);
                    }
                    else
                    {
                        dat = datLine.Split(delim);
                    }

                    if (dat != null && hdr != null && hdr.Length == dat.Length && dat.Length > 0)
                    {
                        for (int i = 0; i < hdr.Length; i++)
                        {
                            string h = hdr[i];
                            string d = dat[i];
                            if (String.IsNullOrEmpty(h)) continue;
                            if (String.IsNullOrEmpty(d)) continue;
                            if (isCSVPlusQuoteDelim)
                            {
                                h = h.Replace('"', ' ').Trim();
                                d = d.Replace('"', ' ').Trim();
                            }
                            if (d == null)
                            {
                                continue;
                            }
                            d = d.Replace('\t', ' ').Replace('`', ' ').Trim().ToUpper();
                            d = d.Replace("NULL", "").Replace("<NULL>", "");
                            d = d.Replace("<UNAVAIL>", "");
                            h = h.Replace('`', ' ').Trim();

                            if (d.Length < 1) continue;

                            string wKey = f.Name
                                .Replace(f.Extension, "")
                                .ToUpper()
                                .Trim()
                                .Replace('-', ' ')
                                .Replace(' ', '_')
                                .Replace("__", "_") + "-" +
                                h.ToUpper()
                                .Replace('-', ' ')
                                .Replace(')', ' ')
                                .Replace('(', ' ')
                                .Replace('.', ' ')
                                .Trim()
                                .Replace(' ', '_')
                                .Replace("__", "_");

                            if (wKey.Length > 64)
                            {
                                //"BSET_NPI_0-PROVIDER_BUSINESS_MAILING_ADDRESS_COUNTRY_CODE_IF_OUTSIDE_U_S"

                                wKey = wKey.Replace("PROVIDER", "PROVDR")
                                           .Replace("BUSINESS", "BUS")
                                           .Replace("MAILING","MAIL")
                                           .Replace("ADDRESS","ADDR")
                                           .Replace("COUNTRY", "CNTRY")
                                           .Replace("OUTSIDE", "OUTSD")
                                           .Replace("PRIMARY", "PRI")
                                           .Replace("LOCATION", "LOC");

                                if(wKey.Length > 64)
                                {
                                    throw new Exception("wKey Table name: " + wKey + ", will be too long.");
                                }
                            }

                            if (!writers.ContainsKey(wKey))
                            {
                                string wn = AtomFiles + "/" + wKey + ".TAB";

                                writers.Add(wKey, new StreamWriter(wn));
                                writers[wKey].Write("Line_ID");
                                writers[wKey].Write('\t');
                                writers[wKey].Write("As_Short_Text_LTE_400");
                                writers[wKey].Write('\t');
                                writers[wKey].Write("As_Long_Text_LTE_4000");
                                writers[wKey].Write('\t');
                                writers[wKey].Write("As_Year");
                                writers[wKey].Write('\t');
                                writers[wKey].Write("As_Month");
                                writers[wKey].Write('\t');
                                writers[wKey].Write("As_Day");
                                writers[wKey].Write('\t');
                                writers[wKey].Write("As_Hour");
                                writers[wKey].Write('\t');
                                writers[wKey].Write("As_Minute");
                                writers[wKey].Write('\t');
                                writers[wKey].Write("As_Second");
                                writers[wKey].Write('\t');
                                writers[wKey].Write("As_Millisecond");
                                writers[wKey].Write('\t');
                                writers[wKey].Write("As_Double");
                                writers[wKey].Write('\t');
                                writers[wKey].Write("As_Long");
                                writers[wKey].Write('\t');
                                writers[wKey].Write("As_Bool");
                                writers[wKey].Write('\t');
                                writers[wKey].Write("YMD_hms_Key");
                                writers[wKey].WriteLine();
                            }

                            writers[wKey].Write(objectID.ToString());
                            writers[wKey].Write('\t');

                            if(d.Length > 400)
                            {
                                writers[wKey].Write('\t');
                                writers[wKey].Write(d);
                                writers[wKey].Write('\t');
                            }
                            else
                            {
                                writers[wKey].Write(d);
                                writers[wKey].Write('\t');
                                writers[wKey].Write('\t');
                            }

                            DateTime dtmVal = DateTime.MinValue;

                            if(DateTime.TryParse(d, out dtmVal))
                            {
                                writers[wKey].Write(dtmVal.Year.ToString());
                                writers[wKey].Write('\t');
                                writers[wKey].Write(dtmVal.Month.ToString());
                                writers[wKey].Write('\t');
                                writers[wKey].Write(dtmVal.Day.ToString());
                                writers[wKey].Write('\t');
                                writers[wKey].Write(dtmVal.Hour.ToString());
                                writers[wKey].Write('\t');
                                writers[wKey].Write(dtmVal.Minute.ToString());
                                writers[wKey].Write('\t');
                                writers[wKey].Write(dtmVal.Second.ToString());
                                writers[wKey].Write('\t');
                                writers[wKey].Write(dtmVal.Millisecond.ToString());
                                writers[wKey].Write('\t');
                            }
                            else
                            {
                                writers[wKey].Write('\t');
                                writers[wKey].Write('\t');
                                writers[wKey].Write('\t');
                                writers[wKey].Write('\t');
                                writers[wKey].Write('\t');
                                writers[wKey].Write('\t');
                                writers[wKey].Write('\t');
                            }

                            string number = d
                                .Replace('"', ' ')
                                .Replace('(', '-')
                                .Replace(')', ' ')
                                .Replace('$', ' ')
                                .Replace('[', ' ')
                                .Replace(']', ' ')
                                .Replace('%', ' ')
                                .Replace(",", "")
                                .Trim();

                            Double dblTest = -1;
                            long lngTest = -1;
                            bool blnTest = false;

                            if(double.TryParse(number, out dblTest))
                            {
                                writers[wKey].Write(dblTest.ToString());
                                writers[wKey].Write('\t');
                            }
                            else
                            {
                                writers[wKey].Write('\t');
                            }

                            if (long.TryParse(number, out lngTest))
                            {
                                writers[wKey].Write(lngTest.ToString());
                                writers[wKey].Write('\t');
                            }
                            else
                            {
                                writers[wKey].Write('\t');
                            }

                            if (bool.TryParse(d, out blnTest))
                            {
                                writers[wKey].Write(blnTest.ToString());
                                writers[wKey].Write('\t');
                            }
                            else
                            {
                                writers[wKey].Write('\t');
                            }

                            string ymdhmsMSkey = "";

                            DateTime dtNow = DateTime.Now;

                            ymdhmsMSkey = dtNow.Year.ToString() +
                                               dtNow.Month.ToString().PadLeft(2, '0') +
                                               dtNow.Day.ToString().PadLeft(2, '0') +
                                               dtNow.Hour.ToString().PadLeft(2, '0') +
                                               dtNow.Minute.ToString().PadLeft(2, '0') +
                                               dtNow.Second.ToString().PadLeft(2, '0');

                            writers[wKey].Write(ymdhmsMSkey);

                            writers[wKey].WriteLine();
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
            sr.Close();
        }
    }
}
