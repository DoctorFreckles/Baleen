using System;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Collections.Generic;
using BaleenLib;

namespace BaleenProcess
{
    class Program
    {
        static void Main(string[] Args)
        {

            //StreamReader sr = new StreamReader(@"C:\TEST\OP_NPI\ORDERED_NPI\BAK2\b1096dee-c4ac-4b81-b607-0db38f5243f3_facts.tab");

            //long lnCount = 0;


            //while (!sr.EndOfStream)
            //{
            //    lnCount++;
            //    if (lnCount == 5156)
            //    {

            //    }
            //    string ln = sr.ReadLine();

            //}

            //sr.Close();
            //FastDW.Run(@"C:\TEST\OP_NPI\ORDERED_NPI\b1096dee-c4ac-4b81-b607-0db38f5243f3.csv", true, true,
            //    DateTime.Parse("1/1/1900"), DateTime.Parse("1/1/2078"));
            //long.Parse("54.55");
            //BaleenAgent.JoinDataFiles(@"C:\TEST\OP_NPI\");

            //SplitNPIParse.Run(@"C:\TEST\npidata_20050523-20120109.csv", 31);
            //PredicateParser.Run(@"C:\TEST\OP_NPI\ORDERED_NPI\b1096dee-c4ac-4b81-b607-0db38f5243f3.csv", true, 500);
            //BaleenAgent.StringArgs = Args;
            //BaleenAgent.Run();



            //SetEngineParser.Atomize(@"C:\TEST\OP_NPI\ORDERED_NPI\national provider index cms.csv",
            //    true,ref objectID);


            //SetEngineParser.LoadTimeout = 60 * 60 * 12;
            //SetEngineParser.NewDBName = @"BLNS_PROVIDER_RESEARCH";
            //SetEngineParser.MDFLocation = @"O:\DBFiles\";
            //SetEngineParser.SqlServerConnection = @"Data Source=localhost;Initial Catalog=master;User Id=sa;Password=4t9er555;Connect Timeout=1000;";
            //SetEngineParser.AtomizeDirectory(@"O:\RAW_SNP_FILES\DBSNP_PARSED\", false);
            //GenerateBaleenMetaData.Run(
            //        @"Data Source=localhost;Initial Catalog=master;User Id=sa;Password=4t9er555;Connect Timeout=1000;",
            //        @"C:\DATA_IN\bln_meta.tab"
            //        , "BLNS_", "BSET_");

            //AutoGenBaleenSetView.RunSimple(@"Data Source=localhost;Initial Catalog=master;User Id=sa;Password=4t9er555;Connect Timeout=1000;",
            //    "BLNS_PROVIDER_RESEARCH", "dbo", "BSET_NPI-NPI", 0.97, @"C:\DATA_IN\bln_meta.tab", true);

//            AutoGenBaleenSetView.RunSimple(@"Data Source=localhost;Initial Catalog=master;User Id=sa;Password=4t9er555;Connect Timeout=1000;",
//    "BLNS_PROVIDER_RESEARCH", "dbo", "BSET_ZIPCODE-ZIPCODE", 0.97, @"C:\DATA_IN\bln_meta.tab");

//            AutoGenBaleenSetView.RunSimple(@"Data Source=localhost;Initial Catalog=master;User Id=sa;Password=4t9er555;Connect Timeout=1000;",
//"BLNS_PROVIDER_RESEARCH", "dbo", "BSET_TAXONOMY-CODE", 0.97, @"C:\DATA_IN\bln_meta.tab");


            //Dictionary<string, StreamWriter> writers = new Dictionary<string, StreamWriter>();

            //SetEngineParser2.LoadTimeout = 60 * 60 * 12;
            //SetEngineParser2.NewDBName = @"BLNS_TEST";
            //SetEngineParser2.MDFLocation = @"O:\DBFiles\";
            //SetEngineParser2.SqlServerConnection = @"Data Source=localhost;Initial Catalog=master;User Id=sa;Password=4t9er555;Connect Timeout=1000;";
            //SetEngineParser2.AtomizeDirectory(@"C:\test\", true);

            //AtomSetParser.AtomizeDirectories(@"C:\test\", true, @"Data Source=localhost;Initial Catalog=master;User Id=sa;Password=4t9er555;Connect Timeout=1000;", 60 * 60 * 12, 1899, 2099);


            //Double x = Double.Parse("8.9999999999999997E-2");


            //GenerateFieldListing.Run(@"C:\TEST\wiki\");


            //ParseWarDiary.RunAfghan(@"C:\PROJECTS\DATA\afghan war diary.txt", @"C:\PROJECTS\DATA\OUTPUT\");

            //ParseWarDiary.RunIraq(@"C:\PROJECTS\DATA\iraq war diary.txt", @"C:\PROJECTS\DATA\OUTPUT\");

            //BuildKWFile();

            //BuildWikiLeakFile();

            //AtomSetParser.AtomizeDirectories(@"C:\TEST\RUN\", true, @"Data Source=localhost;Initial Catalog=master;User Id=sa;Password=4t9er555;Connect Timeout=1000;", 60 * 60 * 12, 1899, 2099);

            //BSETViewGenerator.Run2();





            ConvertFileToDataTable.Run(@"C:\PROJECTS\DATA\provider_db\");
        }
        static void BuildWikiLeakFile()
        {
            //C:\TEST\wiki\Wiki Diplomatic
            DirectoryInfo di = new DirectoryInfo(@"C:\TEST\wiki\Wiki Diplomatic\");

            StreamWriter sw = new StreamWriter(@"C:\TEST\wiki\wiki diplomatic.tab");

            sw.Write("File");
            sw.Write('\t');
            sw.Write("Line Number");
            sw.Write('\t');
            sw.WriteLine("Line Content");

            FileInfo[] fins = di.GetFiles();

            foreach (FileInfo f in fins)
            {
                string[] lines = File.ReadAllLines(f.FullName);

                int line = 0;

                foreach (string l in lines)
                {
                    string ln = l.Trim();
                    if (!string.IsNullOrEmpty(ln))
                    {
                        sw.Write(f.Name.Replace(f.Extension,""));
                        sw.Write('\t');
                        sw.Write(line.ToString());
                        sw.Write('\t');
                        sw.WriteLine(ln);


                        line++;

                    }
                }


            }

            sw.Close();

        }
        static void BuildKWFile()
        {
            //C:\TEST\wiki\War Diaries

            Regex r = new Regex(@"(\W+(?<WRD>[A-Z]+)\W+)", RegexOptions.IgnoreCase | RegexOptions.Compiled);

            DirectoryInfo di = new DirectoryInfo(@"C:\PROJECTS\DATA\wd\");

            FileInfo[] fins = di.GetFiles();

            StreamWriter sw = new StreamWriter(@"C:\PROJECTS\DATA\wd\war diary keyword.tab");

            sw.Write("War Diary");
            sw.Write('\t');
            sw.Write("Line Number");
            sw.Write('\t');
            sw.Write("Latitude");
            sw.Write('\t');
            sw.Write("Longitude");
            sw.Write('\t');
            sw.Write("Incident Date");
            sw.Write('\t');
            sw.WriteLine("Key Word");

            int lno = 0;

            foreach (FileInfo f in fins)
            {
                Console.WriteLine(f.Name);

                StreamReader sr = new StreamReader(f.FullName);

                sr.ReadLine();

                while (!sr.EndOfStream)
                {
                    lno++;

                    if (lno % 1000 == 0) Console.WriteLine("Line No: " + lno.ToString());

                    string ln = sr.ReadLine();

                    string[] parts = ln.Split('\t');

                    if (parts.Length == 5)
                    {
                        //Console.WriteLine(parts[0]);

                        string lnn = parts[0];
                        string lat = parts[1];
                        string lng = parts[2];
                        string dtm = parts[3];

                        MatchCollection mc = r.Matches(parts[4].ToUpper());

                        Dictionary<string, string> mtch = new Dictionary<string, string>();

                        foreach (Match m in mc)
                        {
                            if (m.Groups["WRD"].Value.Length > 1)
                            {
                                mtch[m.Groups["WRD"].Value] = "";
                                //mtch[m.Value] = "";
                            }
                        }

                        foreach (string key in mtch.Keys)
                        {
                            sw.Write(f.Name.Replace(f.Extension, ""));
                            sw.Write('\t');
                            sw.Write(lnn);
                            sw.Write('\t');
                            sw.Write(lat);
                            sw.Write('\t');
                            sw.Write(lng);
                            sw.Write('\t');
                            sw.Write(dtm);
                            sw.Write('\t');
                            sw.WriteLine(key);
                        }


                    }
                    else
                    {

                    }
                }

                sr.Close();
            }

            sw.Close();
        }
    }
}
