using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Configuration;

namespace BaleenLib
{
    public class PredicateParser
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
        public static void Run(string sourceFile, bool isCSVPlusQuoteDelim, int predFileSizeMB)
        {
            long maxFileSize = predFileSizeMB * 1000000;
            long currFileSize = 0;
            Dictionary<string, List<object>> dict = new Dictionary<string, List<object>>();
            Dictionary<string, long> dictCount = new Dictionary<string, long>();
            Dictionary<string, long> dictID = new Dictionary<string, long>();
            long tokenID = 0;
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
            int fileCount = 0;
            long objectID = 0;

            StreamWriter fa = null;
            StreamWriter df = null;

            fileCount++;
            fa = new StreamWriter(f.Directory.FullName + "\\" + f.Name.Replace(f.Extension, "") + "_" + (fileCount).ToString() + ".fact");
            df = new StreamWriter(f.Directory.FullName + "\\" + f.Name.Replace(f.Extension, "") + "_" + (fileCount).ToString() + ".dict");

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
            currFileSize += hdrLine.Length;
            while (!sr.EndOfStream)
            {
                lineCount++;
                if (lineCount % 1000 == 0)
                {
                    Console.WriteLine("Processing File: " + f.Name);
                    Console.WriteLine("Fact Processing Line No: " + lineCount.ToString());
                }
                string datLine = sr.ReadLine();
                currFileSize += datLine.Length;
                string[] dat = null;
                if (isCSVPlusQuoteDelim)
                {
                    dat = CsvQuoteSplit(datLine);
                }
                else
                {
                    dat = datLine.Split(delim);
                }
                Dictionary<string, List<object>> record = new Dictionary<string, List<object>>();
                if (dat != null && hdr != null && hdr.Length == dat.Length)
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
                        d = d.Replace('\t', ' ').Replace('`',' ').Trim();
                        h = h.Replace('`', ' ').Trim();
                        if (d.Length < 1) continue;
                        record[h] = Utility.UtilityMain.CoalesceObjects(d);
                    }

                    if (record.Keys.Count > 0)
                    {
                        objectID++;
                        foreach (string key in record.Keys)
                        {
                            string k = key;
                            List<object> vals = record[key];
                            string PredicateKey = k.Replace('^','_').ToUpper().Trim() + '^' + (from v in vals
                                                             where v is string
                                                             select v).FirstOrDefault();
                            if (dict.ContainsKey(PredicateKey))
                            {
                                dictCount[PredicateKey]++;
                            }
                            else
                            {
                                dict.Add(PredicateKey, vals);
                                dictCount.Add(PredicateKey, 1);
                                dictID.Add(PredicateKey, ++tokenID);
                            }
                            fa.Write(objectID.ToString());
                            fa.Write('\t');
                            fa.Write(dictID[PredicateKey].ToString());
                            fa.WriteLine('\t');
                        }
                    }
                }

                if (currFileSize >= maxFileSize)
                {
                    foreach (string key in dict.Keys)
                    {
                        long k = dictID[key];
                        long c = dictCount[key];
                        List<object> vals = dict[key];

                        long? lng = null;
                        double? dbl = null;
                        DateTime? dtm = null;
                        string str = null;

                        lng = (from v in vals
                               where v is long
                               select v as long?).FirstOrDefault();
                        dbl = (from v in vals
                               where v is double
                               select v as double?).FirstOrDefault();
                        dtm = (from v in vals
                               where v is DateTime
                               select v as DateTime?).FirstOrDefault();
                        str = (from v in vals
                               where v is string
                               select v as string).FirstOrDefault();

                        string[] parts = key.Split('^');

                        string hVAL = "";

                        if (parts.Length >= 2)
                        {
                            hVAL = parts[0];
                        }
                        else
                        {
                            throw new Exception("Unknown predicate exception Line No: " + lineCount.ToString());
                        }

                        df.Write(dictID[key].ToString());
                        df.Write('\t');
                        df.Write(hVAL.Replace("'", "''"));
                        df.Write('\t');
                        if (!String.IsNullOrEmpty(str))
                        {
                            df.Write(str.Replace("'", "''"));
                        }
                        df.Write('\t');
                        df.Write(dictCount[key].ToString());
                        df.Write('\t');
                        if (lng.HasValue)
                        {
                            df.Write(lng.Value.ToString());
                        }
                        df.Write('\t');
                        if (dbl.HasValue)
                        {
                            df.Write(dbl.Value.ToString());
                        }
                        df.Write('\t');
                        if (dtm.HasValue)
                        {
                            df.Write(dtm.Value.Year.ToString());
                            df.Write('\t');
                            df.Write(dtm.Value.Month.ToString());
                            df.Write('\t');
                            df.Write(dtm.Value.Day.ToString());
                            df.Write('\t');
                            df.Write(dtm.Value.Hour.ToString());
                            df.Write('\t');
                            df.Write(dtm.Value.Minute.ToString());
                            df.Write('\t');
                            df.Write(dtm.Value.Second.ToString());
                            df.Write('\t');
                            df.Write(dtm.Value.Millisecond.ToString());
                        }
                        else
                        {
                            df.Write('\t');
                            df.Write('\t');
                            df.Write('\t');
                            df.Write('\t');
                            df.Write('\t');
                            df.Write('\t');
                        }
                        df.WriteLine();
                    }
                    df.Close();
                    fa.Close();
                    dict = new Dictionary<string, List<object>>();
                    dictID = new Dictionary<string, long>();
                    dictCount = new Dictionary<string, long>();
                    tokenID = 0;
                    currFileSize = 0;
                    objectID = 0;
                    fileCount++;
                    fa = new StreamWriter(f.Directory.FullName + "\\" + f.Name.Replace(f.Extension, "") + "_" + (fileCount).ToString() + ".fact");
                    df = new StreamWriter(f.Directory.FullName + "\\" + f.Name.Replace(f.Extension, "") + "_" + (fileCount).ToString() + ".dict");
                }
            }
            sr.Close();
            if (dict != null && dict.Keys.Count > 0)
            {
                foreach (string key in dict.Keys)
                {
                    long k = dictID[key];
                    long c = dictCount[key];
                    List<object> vals = dict[key];

                    long? lng = null;
                    double? dbl = null;
                    DateTime? dtm = null;
                    string str = null;

                    lng = (from v in vals
                           where v is long
                           select v as long?).FirstOrDefault();
                    dbl = (from v in vals
                           where v is double
                           select v as double?).FirstOrDefault();
                    dtm = (from v in vals
                           where v is DateTime
                           select v as DateTime?).FirstOrDefault();
                    str = (from v in vals
                           where v is string
                           select v as string).FirstOrDefault();

                    string[] parts = key.Split('^');

                    string hVAL = "";

                    if (parts.Length >= 2)
                    {
                        hVAL = parts[0];
                    }
                    else
                    {
                        throw new Exception("Unknown predicate exception Line No: " + lineCount.ToString());
                    }

                    df.Write(dictID[key].ToString());
                    df.Write('\t');
                    df.Write(hVAL.Replace("'", "''"));
                    df.Write('\t');
                    if (!String.IsNullOrEmpty(str))
                    {
                        df.Write(str.Replace("'", "''"));
                    }
                    df.Write('\t');
                    df.Write(dictCount[key].ToString());
                    df.Write('\t');
                    if (lng.HasValue)
                    {
                        df.Write(lng.Value.ToString());
                    }
                    df.Write('\t');
                    if (dbl.HasValue)
                    {
                        df.Write(dbl.Value.ToString());
                    }
                    df.Write('\t');
                    if (dtm.HasValue)
                    {
                        df.Write(dtm.Value.Year.ToString());
                        df.Write('\t');
                        df.Write(dtm.Value.Month.ToString());
                        df.Write('\t');
                        df.Write(dtm.Value.Day.ToString());
                        df.Write('\t');
                        df.Write(dtm.Value.Hour.ToString());
                        df.Write('\t');
                        df.Write(dtm.Value.Minute.ToString());
                        df.Write('\t');
                        df.Write(dtm.Value.Second.ToString());
                        df.Write('\t');
                        df.Write(dtm.Value.Millisecond.ToString());
                    }
                    else
                    {
                        df.Write('\t');
                        df.Write('\t');
                        df.Write('\t');
                        df.Write('\t');
                        df.Write('\t');
                        df.Write('\t');
                    }
                    df.WriteLine();
                }
            }
            if (df != null) df.Close();
            if (fa != null) fa.Close();
        }
    }
}