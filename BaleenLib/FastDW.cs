using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Configuration;

namespace BaleenLib
{
    public class FastDW
    {
        private static Regex CSVandQUOTESplit =
           new Regex(@""",""", RegexOptions.Compiled);
        private static string[] CsvQuoteSplit(string ln)
        {
            if (String.IsNullOrEmpty(ln)) return null;
            string ln2 = ln.Trim();
            if (ln2.Length < 1) return null;
            return CSVandQUOTESplit.Split(ln2);
        }
        public static void Run(
            string sourceFile, 
            bool isCSVPlusQuoteDelim, 
            bool firstFieldNoTransform, 
            DateTime lowerLimit, 
            DateTime upperLimit)
        {
            if (!File.Exists(sourceFile)) return;
            FileInfo f = new FileInfo(sourceFile);
            char delim = ' ';

            if (f.Extension.ToLower() == ".csv")
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

            long lineCount = 0;

            long tokenKey = 0;

            Dictionary<string, long> tokens = new Dictionary<string, long>();

            StreamWriter fact = null;
            StreamWriter dtxt = null;
            StreamWriter dtme = null;
            StreamWriter dlng = null;
            StreamWriter ddbl = null;

            fact = new StreamWriter(f.Directory.FullName + "\\" + f.Name.Replace(f.Extension, "") +  "_facts.tab");
            dtxt = new StreamWriter(f.Directory.FullName + "\\" + f.Name.Replace(f.Extension, "") +  "_text.tab");
            dtme = new StreamWriter(f.Directory.FullName + "\\" + f.Name.Replace(f.Extension, "") + "_time.tab");
            dlng = new StreamWriter(f.Directory.FullName + "\\" + f.Name.Replace(f.Extension, "") + "_integer.tab");
            ddbl = new StreamWriter(f.Directory.FullName + "\\" + f.Name.Replace(f.Extension, "") + "_double.tab");

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
            StringBuilder hrec = new StringBuilder();
            for (int i = 0; i < hdr.Length; i++)
            {
                string s2 = hdr[i];
                if (isCSVPlusQuoteDelim)
                {
                    s2 = s2.Replace('"', ' ').Trim();
                }
                if (i == 0 && firstFieldNoTransform)
                {
                    s2 = s2 + "_PK";
                }
                hrec.Append(s2
                    .Replace('(',' ')
                    .Replace(')',' ')
                    .Replace('.',' ')
                    .Replace("  "," ")
                    .Trim()
                    .Replace(' ','_')
                    .ToUpper()).Append('\t');
            }
            string hln = hrec.ToString().Substring(0, hrec.Length - 1);
            fact.WriteLine(hln);
            while (!sr.EndOfStream)
            {
                lineCount++;
                if (lineCount % 1000 == 0)
                {
                    Console.WriteLine("Processing File: " + f.Name);
                    Console.WriteLine("Fact Processing Line No: " + lineCount.ToString());
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
                if (dat != null && hdr != null && hdr.Length == dat.Length)
                {
                    StringBuilder rec = new StringBuilder();
                    for (int i = 0; i < hdr.Length; i++)
                    {
                        string h = hdr[i];
                        string d = dat[i];
                        if (i == 0 && firstFieldNoTransform)
                        {
                            if (isCSVPlusQuoteDelim)
                            {
                                d = d.Replace('"', ' ').Trim();
                            }
                            rec.Append(d);
                            rec.Append('\t');
                            continue;
                        }
                        if (String.IsNullOrEmpty(d))
                        {
                            rec.Append('\t');
                            continue;
                        }
                        if (isCSVPlusQuoteDelim)
                        {
                            h = h.Replace('"', ' ').Trim();
                            d = d.Replace('"', ' ').Trim();
                        }
                        if (d == null)
                        {
                            rec.Append('\t');
                            continue;
                        }
                        d = d.Replace('\t', ' ').Replace('`', ' ').Trim();
                        h = h.Replace('`', ' ').Trim();
                        if (d.Length < 1)
                        {
                            rec.Append('\t');
                            continue;
                        }
                        List<object> data = Utility.UtilityMain.CoalesceObjects(d);
                        string txt = d.ToUpper();
                        long key = -1;
                        if (tokens.Keys.Contains(txt))
                        {
                            key = tokens[txt];
                        }
                        else
                        {
                            tokenKey++;
                            key = tokenKey;
                            tokens[txt] = tokenKey;
                            foreach (object o in data)
                            {
                                if (o is DateTime)
                                {
                                    DateTime od = (DateTime)o;
                                    if (od <= upperLimit && od >= lowerLimit)
                                    {
                                        dtme.Write(tokenKey);
                                        dtme.Write('\t');
                                        dtme.WriteLine(o.ToString());
                                    }
                                }
                                else if (o is long)
                                {
                                    dlng.Write(tokenKey);
                                    dlng.Write('\t');
                                    dlng.WriteLine(o.ToString());
                                }
                                else if (o is double)
                                {
                                    ddbl.Write(tokenKey);
                                    ddbl.Write('\t');
                                    ddbl.WriteLine(o.ToString());
                                }
                            }
                            dtxt.Write(tokenKey);
                            dtxt.Write('\t');
                            dtxt.WriteLine(txt);
                        }
                        if (key > 0)
                        {
                            rec.Append(key.ToString());
                        }
                        rec.Append('\t');
                    }
                    string ln = rec.ToString().Substring(0, rec.Length - 1);
                    fact.WriteLine(ln);
                }
            }
            sr.Close();
            if (fact != null) fact.Close();
            if (dtme != null) dtme.Close();
            if (ddbl != null) ddbl.Close();
            if (dlng != null) dlng.Close();
            if (dtxt != null) dtxt.Close();
        }
    }
}