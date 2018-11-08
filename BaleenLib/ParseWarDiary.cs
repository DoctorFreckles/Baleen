using System;
using System.Data.SqlClient;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Configuration;

namespace BaleenLib
{
    public class ParseWarDiary
    {
        //2009-04-23 12:30:00
        //\d{4,4}-\d{2,2}-\d{2,2}\s\d{2,2}:\d{2,2}:\d{2,2}
        //^d+,\w{1,16},[^,]{1,15}-[^,]{1,15}-[^,]{1,15}
        //1,IRQ20090423n51,D2CE5ECC-D8A7-2A8E-0F0141A253E70E6B,2009-04-23 12:30:00,Friendly Action,Confiscation,20090423123038SMB,(FRIENDLY ACTION) CONFISCATION RPT   --  : %%% INJ/DAM,***%%% NATION REPORT***

        static Regex grabDate = new Regex(@"(?<DTM>\d{4,4}-\d{2,2}-\d{2,2}\s\d{2,2}:\d{2,2}:\d{2,2})",
            RegexOptions.Compiled |
            RegexOptions.IgnoreCase);

        static Regex irq = new Regex(@"^\d+\s*,\s*IRQ",
    RegexOptions.Compiled |
    RegexOptions.IgnoreCase);
        
        static Regex s4 = new Regex(@",(?<LL>[234]\d+(\.\d+)?,[34567]\d+(\.\d+)?),",
    RegexOptions.Compiled |
    RegexOptions.IgnoreCase);

        static Regex s3 = new Regex(@"^([^,]{1,15}-[^,]{1,15}-[^,]{1,15}-[^,]{1,15}-[^,]{1,15}\s*[,])",
            RegexOptions.Compiled |
            RegexOptions.IgnoreCase);
        public static void RunIraq(string fileLoc, string dropLoc)
        {
            StreamReader sr = new StreamReader(fileLoc);

            StringBuilder sb = new StringBuilder();

            FileInfo f = new FileInfo(fileLoc);

            string step1 = f.Directory.FullName + "\\step1.p";
            string step2 = f.Directory.FullName + "\\step2.p";

            StreamWriter sw = null;

            sw = new StreamWriter(step1);

            int lineCount = 0;

            StringBuilder splt = new StringBuilder();

            splt.Append('\r').Append('\n');

            sr.ReadLine();

            while (!sr.EndOfStream)
            {
                string ln = sr.ReadLine();

                if (ln.Length < 1) continue;

                ln = ln.Replace('\t', ' ').Replace('\r', ' ').Replace('\n', ' ').Replace("\"","").Trim();

                if (string.IsNullOrEmpty(ln)) continue;

                ln = irq.Replace(ln, splt.ToString());

                sw.Write(ln);

                lineCount++;
                if (lineCount % 1000 == 0)
                {
                    Console.WriteLine("Line: " + lineCount.ToString());
                }
                //if (lineCount > 200)
                //{
                //    break;
                //}
            }

            sw.Close();
            sr.Close();

            sr = new StreamReader(step1);

            sw = new StreamWriter(dropLoc + f.Name);
            sw.Write("Line Number");
            sw.Write('\t');
            sw.Write("Latitude");
            sw.Write('\t');
            sw.Write("Longitude");
            sw.Write('\t');
            sw.Write("Incident_Date");
            sw.Write('\t');
            sw.WriteLine("Event_Text");

            sb = new StringBuilder();

            int lineNo = 0;

            while (!sr.EndOfStream)
            {
                string ln = sr.ReadLine();

                ln = ln.Trim();

                if (string.IsNullOrEmpty(ln)) continue;

                MatchCollection mc = s4.Matches(ln);

                MatchCollection md = grabDate.Matches(ln);

                Match mr = null;

                foreach (Match m in mc)
                {
                    if (m.Groups["LL"].Success)
                    {
                        mr = m;
                        break;
                    }
                }

                Match mrd = null;

                foreach (Match m in md)
                {
                    if (m.Groups["DTM"].Success)
                    {
                        mrd = m;
                        break;
                    }
                }

                string dtms = "";

                if (mrd != null)
                {
                    dtms = mrd.Groups["DTM"].Value;
                }
                else
                {
                    dtms = "";
                }

                string pref = "";

                if (mr != null)
                {
                    pref = mr.Groups["LL"].Value + ",";
                }
                else
                {
                    pref = "0.0,0.0,";
                }

                string ln2 = pref + ln;

                string[] ln3 = ln2.Split(',');


                if (ln3.Length > 3)
                {
                    string lat = ln3[0];
                    string lng = ln3[1];
                    string dtm = ln3[2];

                    StringBuilder sb2 = new StringBuilder();

                    for (int i = 3; i < ln3.Length; i++)
                    {
                        sb2.Append(ln3[i]).Append('|');
                    }

                    sw.Write((lineNo++).ToString());
                    sw.Write('\t');
                    sw.Write(lat);
                    sw.Write('\t');
                    sw.Write(lng);
                    sw.Write('\t');
                    sw.Write(dtms);
                    sw.Write('\t');
                    sw.WriteLine(sb2.ToString());
                }
            }

            sw.Close();
            sr.Close();
        }
        public static void RunAfghan(string fileLoc, string dropLoc)
        {
            StreamReader sr = new StreamReader(fileLoc);

            StringBuilder sb = new StringBuilder();

            FileInfo f = new FileInfo(fileLoc);

            string step1 = f.Directory.FullName + "\\step1.p";
            string step2 = f.Directory.FullName + "\\step2.p";

            StreamWriter sw = null;

            sw = new StreamWriter(step1);

            int lineCount = 0;

            StringBuilder splt = new StringBuilder();

            splt.Append('\r').Append('\n');

            sr.ReadLine();

            while (!sr.EndOfStream)
            {
                string ln = sr.ReadLine();

                if (ln.Length < 1) continue;

                ln = ln.Replace('\t', ' ').Replace('\r', ' ').Replace('\n', ' ').Trim();

                if (string.IsNullOrEmpty(ln)) continue;

                ln = s3.Replace(ln, splt.ToString());

                sw.Write(ln);

                lineCount++;
                if (lineCount % 1000 == 0)
                {
                    Console.WriteLine("Line: " + lineCount.ToString());
                }
            }

            sw.Close();
            sr.Close();

            sr = new StreamReader(step1);

            sw = new StreamWriter(dropLoc + f.Name);

            sw.Write("Line Number");
            sw.Write('\t');
            sw.Write("Latitude");
            sw.Write('\t');
            sw.Write("Longitude");
            sw.Write('\t');
            sw.Write("Incident_Date");
            sw.Write('\t');
            sw.WriteLine("Event_Text");

            sb = new StringBuilder();

            int lineNo = 0;

            while (!sr.EndOfStream)
            {
                string ln = sr.ReadLine();

                ln = ln.Trim();

                if (string.IsNullOrEmpty(ln)) continue;

                MatchCollection mc = s4.Matches(ln);

                Match mr = null;

                foreach (Match m in mc)
                {
                    if (m.Groups["LL"].Success)
                    {
                        mr = m;
                        break;
                    }
                }

                string pref = "";

                if (mr != null)
                {
                    pref = mr.Groups["LL"].Value + ",";
                }
                else
                {
                    pref = "0.0,0.0,";
                }

                string ln2 = pref + ln;

                string[] ln3 = ln2.Split(',');


                if (ln3.Length > 3)
                {
                    string lat = ln3[0];
                    string lng = ln3[1];
                    string dtm = ln3[2];

                    StringBuilder sb2 = new StringBuilder();

                    for (int i = 3; i < ln3.Length; i++)
                    {
                        sb2.Append(ln3[i]).Append('|');
                    }

                    sw.Write((lineNo++).ToString());
                    sw.Write('\t');
                    sw.Write(lat);
                    sw.Write('\t');
                    sw.Write(lng);
                    sw.Write('\t');
                    sw.Write(dtm);
                    sw.Write('\t');
                    sw.WriteLine(sb2.ToString());
                }
            }

            sw.Close();
            sr.Close();
        }
    }
}
