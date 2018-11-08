using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Timers;
using System.Text.RegularExpressions;

namespace BaleenLib
{
    public class BaleenAgent
    {
        public static string[] StringArgs = null;
        private static int MaxFileSize = 0;
        private static string UserName = "";
        private static Timer FileWatchTimer = null;
        private static string DataDirectory = "";
        private static string ProcessMode = "";
        private static string DBServerConnect = "";
        public static string DBReadOnlyUser = "";
        private static int IncrementalLines = 0;
        private static bool ContinueLoop = false;
        private static int TimerTickSecs = 10;
        private static bool ToUpperCase = false;
        private static int SubtractYearLimit = 100;
        private static int AddYearLimit = 50;
        private static int TextLineWidth = 50;
        private static int ReportLineCountInterval = 1;
        private static bool IsCSVPlusQuoteDelim = false;
        private static bool RemoveAllQuotesFromTextFiles = false;
        private static string WarDiaryFile = "";
        static BaleenAgent()
        {
            RemoveAllQuotesFromTextFiles = bool.Parse(ConfigurationManager.AppSettings["RemoveAllQuotesFromTextFiles"]);
            MaxFileSize = int.Parse(ConfigurationManager.AppSettings["MaxFileSizeMB"]);
            UserName = ConfigurationManager.AppSettings["UserName"];
            DataDirectory = ConfigurationManager.AppSettings["DataDirectory"];
            ProcessMode = ConfigurationManager.AppSettings["ProcessMode"].Trim().ToLower();
            DBServerConnect = ConfigurationManager.AppSettings["DBServerConnect"];
            DBReadOnlyUser = ConfigurationManager.AppSettings["DBReadOnly"];
            IncrementalLines = int.Parse(ConfigurationManager.AppSettings["IncrementalLoadLineCount"]);
            TimerTickSecs = int.Parse(ConfigurationManager.AppSettings["TimerTickSeconds"]);
            ToUpperCase = bool.Parse(ConfigurationManager.AppSettings["ToUpperCase"]);
            SubtractYearLimit = int.Parse(ConfigurationManager.AppSettings["SubtractYearLimit"]);
            AddYearLimit = int.Parse(ConfigurationManager.AppSettings["AddYearLimit"]);
            TextLineWidth = int.Parse(ConfigurationManager.AppSettings["TextLineWidth"]);
            ReportLineCountInterval = int.Parse(ConfigurationManager.AppSettings["ReportLineCountInterval"]);
            IsCSVPlusQuoteDelim = bool.Parse(ConfigurationManager.AppSettings["IsCSVPlusQuoteDelim"]);
            WarDiaryFile = ConfigurationManager.AppSettings["WarDiaryFile"];
        }
        public static void Run()
        {
            if (ProcessMode == "npi_column_split") NPIColumnSplit();
            if (ProcessMode == "incremental") IncrementalLoad();
            if (ProcessMode == "load") Load();
            if (ProcessMode == "query") Query();
            if (ProcessMode == "loadwatch") LoadWatch();
            if (ProcessMode == "loadglobwatch") LoadGlobWatch();
            if (ProcessMode == "loadglobwatch2") LoadGlobWatch2();
            if (ProcessMode == "filesplit") SplitFile();
            if (ProcessMode == "rectangular") LoadRectangle();
            if (ProcessMode == "askthedude_drop") AskTheDude_drop();
            if (ProcessMode == "askthedude_response") AskTheDude_response();
            if (ProcessMode == "baleen_vectora") BaleenVectora();
            if (ProcessMode == "hub_and_spoke") HubAndSpoke();
            if (ProcessMode == "parse_war_diary") ParseWarDiary();
            if (ProcessMode == "parse_and_separate") ParseAndSeparateFiles();
            if (ProcessMode == "simple_index") SimpleIndexRun();
            if (ProcessMode == "predicate_parser") RunPredicateParser();
            if (ProcessMode == "npi_query_response") NPIQueryResponseProcess();
            if (ProcessMode == "email_response_cycle") EmailResponseCycle();
        }
        private static void NPIQueryResponseProcess()
        {
            DataTable dt = DictionaryQueries.GetProviders("orthopedic johnson seattle wa", DBServerConnect);
        }
        public static void JoinDataFiles(string dir)
        {
            DirectoryInfo di = new DirectoryInfo(dir);
            FileInfo[] fins = di.GetFiles();

            List<FileInfo> fins2 = (from f in fins
                                    orderby f.Length descending
                                    select f).ToList<FileInfo>();
            StreamReader srH = new StreamReader(fins[0].FullName);
            string hdr = srH.ReadLine();
            srH.Close();
            long lineCount = 0;
            StreamWriter sw = new StreamWriter(dir + "\\" + Guid.NewGuid().ToString() + ".joined");
            sw.WriteLine(hdr);
            foreach (FileInfo f in fins2)
            {
                StreamReader sr = new StreamReader(f.FullName);
                sr.ReadLine();
                while (!sr.EndOfStream)
                {
                    lineCount++;
                    if (lineCount % 1000 == 0) Console.WriteLine("Line: " + lineCount.ToString());
                    string ln = sr.ReadLine();
                    sw.WriteLine(ln);
                }
                sr.Close();
            }
            sw.Close();
        }
        private static void RunPredicateParser()
        {

        }
        private static void SimpleIndexRun()
        {
            if (StringArgs != null)
            {
                if (StringArgs.Length == 1)
                {
                    if (StringArgs[0] != null)
                    {
                        if (Directory.Exists(StringArgs[0]))
                        {
                            DirectoryInfo di = new DirectoryInfo(StringArgs[0]);
                            SimpleIndex.Run(di);
                        }
                    }
                }
            }
        }
        private static void ParseAndSeparateFiles()
        {
            if (StringArgs != null)
            {
                if (StringArgs.Length == 2)
                {
                    if (StringArgs[0] != null)
                    {
                        if (Directory.Exists(StringArgs[0]))
                        {
                            DirectoryInfo di = new DirectoryInfo(StringArgs[0]);

                            if (StringArgs[1] != null)
                            {
                                double d = 0;
                                if (double.TryParse(StringArgs[1], out d))
                                {
                                    ParseAndSeparate.Run(di, d);
                                }
                                else
                                {
                                    ParseAndSeparate.Run(di, -1);
                                }
                            }
                            else
                            {
                                ParseAndSeparate.Run(di, -1);
                            }
                        }
                    }
                }
            }
        }
        private static void ParseWarDiary()
        {
            FileInfo fi = new FileInfo(WarDiaryFile);
            StreamReader srClean = new StreamReader(WarDiaryFile);
            long lnCount1 = 0;
            string fn = Guid.NewGuid().ToString() + ".txt";
            string wfile1 = fi.Directory.FullName + "\\" + fn;
            StreamWriter sw1 = new StreamWriter(wfile1);
            while (!srClean.EndOfStream)
            {
                string ln = srClean.ReadLine().Trim();
                if (ln.Length > 0)
                {
                    lnCount1++;
                    if (lnCount1 % 1000 == 0) Console.WriteLine("Line: " + lnCount1.ToString());
                    string[] sar = ln.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                    int len = 0;
                    foreach (string s in sar)
                    {
                        string s2 = s.Trim();
                        if (s2.Length < 1) continue;
                        len += s2.Length;
                        sw1.Write(s2);
                        sw1.Write(' ');
                        if (len > 150)
                        {
                            sw1.WriteLine();
                            len = 0;
                        }
                    }
                    if (len > 0)
                    {
                        sw1.WriteLine();
                    }
                }
            }
            sw1.Close();
            srClean.Close();

            StreamReader sr = new StreamReader(wfile1);

            string wfile = fi.Directory.FullName + "\\" + fi.Name.Replace('.', '_') + ".hat";
            StreamWriter sw = new StreamWriter(wfile);
            long lineCount = 0;

            sw.Write("Line_Count");
            sw.Write('^');
            sw.Write("Date_Time");
            sw.Write('^');
            sw.Write("Lat");
            sw.Write('^');
            sw.Write("Long");
            sw.Write('^');
            sw.WriteLine("Line_Text");
            while (!sr.EndOfStream)
            {
                string ln = sr.ReadLine().Trim();
                if (ln.Length > 0)
                {
                    DateTime? currDtm = null;
                    float? curLong = null;
                    float? curLat = null;

                    lineCount++;
                    if (lineCount % 1000 == 0) Console.WriteLine("Line: " + lineCount.ToString());
                    string lnP = ln.Replace("\"", "");
                    string[] sar = lnP.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                    if (sar.Length > 1)
                    {
                        foreach (string s in sar)
                        {
                            string s2 = s.Replace('"', ' ').Trim();
                            if (s2.Length > 5 && s2.Contains("-"))
                            {
                                DateTime dt = DateTime.MinValue;
                                if (DateTime.TryParse(s2, out dt))
                                {
                                    currDtm = dt;
                                    break;
                                }
                            }
                        }

                        for (int i = 1; i < sar.Length; i++)
                        {
                            string s1 = sar[i - 1].Replace('"',' ').Trim();
                            string s2 = sar[i].Replace('"',' ').Trim();
                            if (s1.Length < 2 || s2.Length < 2) continue;
                            float r1 = 0;
                            float r2 = 0;
                            if (float.TryParse(s1, out r1) &&
                                float.TryParse(s2, out r2))
                            {
                                curLat = r1;
                                curLong = r2;
                                break;
                            }
                        }
                    }
                    sw.Write(lineCount.ToString());
                    sw.Write('^');
                    if (currDtm.HasValue)
                    {
                        sw.Write(currDtm.Value.ToString());
                    }
                    sw.Write('^');
                    if (curLat.HasValue)
                    {
                        sw.Write(curLat.Value.ToString());
                    }
                    sw.Write('^');
                    if (curLong.HasValue)
                    {
                        sw.Write(curLong.Value.ToString());
                    }
                    sw.Write('^');
                    sw.WriteLine(ln.Replace('^', '_'));
                }
            }
            sr.Close();
            sw.Close();
        }
        private static void HubAndSpoke()
        {
            FileWatchTimer = new Timer(1000 * TimerTickSecs);
            FileWatchTimer.Elapsed += new ElapsedEventHandler(FileWatchTimerHubAndSpoke_Elapsed);
            ContinueLoop = true;
            HubAndSpokeParser.Init(DBServerConnect);
            FileWatchTimer.Start();
            while (ContinueLoop) { }
        }
        private static void NPIColumnSplit()
        {
            string infile = @"C:\LOAD_DATA\npi\SPLIT\npidata_20050523-20120109_csv.csv";
            string odir = @"C:\LOAD_DATA\npi\SPLIT\OUT\";
            StreamReader sr = new StreamReader(infile);
            StreamWriter sw1 = new StreamWriter(odir + "npi_1.csv");
            StreamWriter sw2 = new StreamWriter(odir + "npi_2.csv");
            string hdr = sr.ReadLine();
            string[] ha = hdr.Split(',');
            long lineNumber = 0;
            while (!sr.EndOfStream)
            {
                string ln = sr.ReadLine();
                string[] la = ln.Split(',');
                lineNumber++;
                if (lineNumber % 1000 == 0)
                {
                    Console.WriteLine("Line: " + lineNumber.ToString());
                }
                string npi = la[0];
                if (la.Length == ha.Length)
                {

                }
            }
            sr.Close();
            sw1.Close();
            sw2.Close();
        }
        private static void BaleenVectora()
        {
            FileWatchTimer = new Timer(1000 * TimerTickSecs);
            FileWatchTimer.Elapsed += new ElapsedEventHandler(FileWatchTimerBaleenVectora_Elapsed);
            ContinueLoop = true;
            FileWatchTimer.Start();
            while (ContinueLoop) { }
        }
        private static void LoadRectangle()
        {
            FileWatchTimer = new Timer(1000 * TimerTickSecs);
            FileWatchTimer.Elapsed += new ElapsedEventHandler(FileWatchTimerRectangleLoad_Elapsed);
            ContinueLoop = true;
            FileWatchTimer.Start();
            while (ContinueLoop) { }
        }
        private static void AskTheDude_response()
        {
            //List<string> availSubjects = BaleenQuery.GetSubjects();
            //DataTable dt = BaleenQuery.GetAvailableDBs();
            //BaleenQuery.Init(DBServerConnect);
            //DataSet dtst = BaleenQuery.Query(new List<string> { "murder", "gun", "hitman", "california" }, "WIKI LEAKS", DBServerConnect);



        }
        private static void EmailResponseCycle()
        {
            EmailAgent.Start();
            while (true) { }
        }
        private static void AskTheDude_drop()
        {
            //EmailAgent.Start();
            //while (true) { }



        }
        private static void SplitFile()
        {
            BaleenParse.FileSplit.Run(DataDirectory, MaxFileSize);
        }
        private static void IncrementalLoad()
        {
            BaleenLib.BaleenParse.AtomizingParser.LoadIncremental(
                DataDirectory,
                DBServerConnect,
                IncrementalLines);
            Console.Clear();
        }
        private static void Load()
        {
            BaleenLib.BaleenParse.AtomizingParser.Load(DataDirectory, DBServerConnect);
        }
        private static void LoadWatch()
        {
            FileWatchTimer = new Timer(1000 * TimerTickSecs);
            FileWatchTimer.Elapsed += new ElapsedEventHandler(FileWatchTimerLoad_Elapsed);
            ContinueLoop = true;
            FileWatchTimer.Start();
            while (ContinueLoop) { }
        }
        private static void LoadGlobWatch()
        {
            FileWatchTimer = new Timer(1000 * TimerTickSecs);
            FileWatchTimer.Elapsed += new ElapsedEventHandler(FileWatchTimerLoadGlobby_Elapsed);
            ContinueLoop = true;
            FileWatchTimer.Start();
            while (ContinueLoop) { }
        }
        private static void LoadGlobWatch2()
        {
            FileWatchTimer = new Timer(1000 * TimerTickSecs);
            FileWatchTimer.Elapsed += new ElapsedEventHandler(FileWatchTimerLoadGlobby2_Elapsed);
            ContinueLoop = true;
            FileWatchTimer.Start();
            while (ContinueLoop) { }
        }
        static void FileWatchTimerHubAndSpoke_Elapsed(object sender, ElapsedEventArgs e)
        {
            FileWatchTimer.Stop();
            if (File.Exists(DataDirectory + "stop.bln"))
            {
                ContinueLoop = false;
            }
            else
            {
                HubAndSpokeParser.Run(
                    DataDirectory,
                    DBServerConnect,
                    UserName,
                    ToUpperCase,
                    SubtractYearLimit,
                    AddYearLimit,
                    TextLineWidth,
                    ReportLineCountInterval,
                    IsCSVPlusQuoteDelim,
                    RemoveAllQuotesFromTextFiles);
            }
            FileWatchTimer.Start();
        }
        static void FileWatchTimerBaleenVectora_Elapsed(object sender, ElapsedEventArgs e)
        {
            FileWatchTimer.Stop();
            if (File.Exists(DataDirectory + "stop.bln"))
            {
                ContinueLoop = false;
            }
            else
            {
                VectoraParser.Run(
                    DataDirectory,
                    DBServerConnect,
                    UserName,
                    ToUpperCase,
                    SubtractYearLimit,
                    AddYearLimit,
                    TextLineWidth,
                    ReportLineCountInterval,
                    IsCSVPlusQuoteDelim,
                    RemoveAllQuotesFromTextFiles);
            }
            FileWatchTimer.Start();
        }
        static void FileWatchTimerLoadGlobby2_Elapsed(object sender, ElapsedEventArgs e)
        {
            FileWatchTimer.Stop();
            if (File.Exists(DataDirectory + "stop.bln"))
            {
                ContinueLoop = false;
            }
            else
            {
                BaleenLib.BaleenParse.GlobParser2.LoadIncremental(
                        DataDirectory,
                        DBServerConnect,
                        IncrementalLines,
                        UserName);
            }
            FileWatchTimer.Start();
        }
        static void FileWatchTimerLoadGlobby_Elapsed(object sender, ElapsedEventArgs e)
        {
            FileWatchTimer.Stop();
            if (File.Exists(DataDirectory + "stop.bln"))
            {
                ContinueLoop = false;
            }
            else
            {
                BaleenLib.BaleenParse.GlobParser.LoadIncremental(
                        DataDirectory,
                        DBServerConnect,
                        IncrementalLines,
                        UserName);
            }
            FileWatchTimer.Start();
        }
        static void FileWatchTimerLoad_Elapsed(object sender, ElapsedEventArgs e)
        {
            FileWatchTimer.Stop();
            if (File.Exists(DataDirectory + "stop.bln"))
            {
                ContinueLoop = false;
            }
            else
            {
                BaleenLib.BaleenParse.AtomizingParser.LoadIncremental(
                        DataDirectory,
                        DBServerConnect,
                        IncrementalLines);
            }
            FileWatchTimer.Start();
        }
        static void FileWatchTimerRectangleLoad_Elapsed(object sender, ElapsedEventArgs e)
        {
            FileWatchTimer.Stop();
            if (File.Exists(DataDirectory + "stop.bln"))
            {
                ContinueLoop = false;
            }
            else
            {
                BaleenLib.BaleenParse.RectangularParser.LoadIncremental(
                        DataDirectory,
                        DBServerConnect,
                        IncrementalLines,
                        UserName);
            }
            FileWatchTimer.Start();
        }
        private static void Query()
        {

        }
    }
}
