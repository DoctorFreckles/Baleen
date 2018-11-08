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
    public class GenerateFieldListing
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
        public static void Run(string SourceDirectory)
        {
            if (!Directory.Exists(SourceDirectory)) return;
            DirectoryInfo di = new DirectoryInfo(SourceDirectory);
            DirectoryInfo[] dirs = di.GetDirectories();
            StreamWriter sw = new StreamWriter(SourceDirectory + "header.fld");
            foreach (DirectoryInfo d in dirs)
            {
                Console.WriteLine("Building DB:" + d.Name);
                ParseDirectory(d.FullName, sw);
            }
            sw.Close();
        }
        public static void ParseDirectory(string sourceDirectoryPath, StreamWriter sw)
        {
            if (!Directory.Exists(sourceDirectoryPath)) return;
            DirectoryInfo di = new DirectoryInfo(sourceDirectoryPath);
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
            foreach (FileInfo f in fins)
            {
                Console.WriteLine("File: " + f.Name);
                ParseHeader(f.FullName, sw);
            }
        }
        public static void ParseHeader(string sourceFile, StreamWriter sw)
        {
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

            sr.Close();

            string[] hdr = null;
            if (isCSVPlusQuoteDelim)
            {
                hdr = CsvQuoteSplit(hdrLine);
            }
            else
            {
                hdr = hdrLine.Split(delim);
            }
            for (int i = 0; i < hdr.Length; i++)
            {
                string h = hdr[i];
                if (String.IsNullOrEmpty(h)) continue;
                if (isCSVPlusQuoteDelim)
                {
                    h = h.Replace('"', ' ').Trim();
                }
                h = h.Replace('`', ' ').Trim();
                string wKey = "BSET_" + f.Name
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
                sw.WriteLine(wKey);
            }
        }
    }
}
