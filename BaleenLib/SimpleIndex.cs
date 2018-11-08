using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace BaleenLib
{
    public class SimpleIndex
    {
        private static Regex matchNum = new Regex(@"(\d+)", RegexOptions.IgnoreCase | RegexOptions.Compiled);
        private static Regex matchAlpha = new Regex(@"([a-zA-Z]+)", RegexOptions.Compiled | RegexOptions.IgnoreCase);
        private static Regex matchEmail = new Regex(@"\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*", RegexOptions.Compiled | RegexOptions.IgnoreCase);
        private static Regex matchAlphaNum =
            new Regex(@"(\w+)", RegexOptions.IgnoreCase | RegexOptions.Compiled);
        private static Regex matchDate =
            new Regex(@"(\d{1,4}[-/\\]\d{1,2}[-/\\]\d{1,4})", RegexOptions.Compiled | RegexOptions.IgnoreCase);
        private static Regex matchLatLong =
            new Regex(@"([""]?[-]?\d+[.]\d*[""]?[,\t][""]?[-]?\d+[.]\d*[""]?)", RegexOptions.Compiled | RegexOptions.IgnoreCase);
        public static void Run(DirectoryInfo di)
        {
            string outDir = di.FullName + "\\INDEX";
            if (!Directory.Exists(outDir))
            {
                Directory.CreateDirectory(outDir);
            }
            StreamWriter latLongIndex = new StreamWriter(di.FullName + "\\INDEX\\" + "lat_long.index");
            latLongIndex.Write("File Name");
            latLongIndex.Write('\t');
            latLongIndex.Write("LAT");
            latLongIndex.Write('\t');
            latLongIndex.WriteLine("LONG");
            StreamWriter dateIndex = new StreamWriter(di.FullName + "\\INDEX\\" + "date.index");
            dateIndex.Write("File Name");
            dateIndex.Write('\t');
            dateIndex.WriteLine("Date");
            StreamWriter emailIndex = new StreamWriter(di.FullName + "\\INDEX\\" + "email.index");
            emailIndex.Write("File Name");
            emailIndex.Write('\t');
            emailIndex.WriteLine("Email");
            StreamWriter alphaIndex = new StreamWriter(di.FullName + "\\INDEX\\" + "alpha.index");
            alphaIndex.Write("File Name");
            alphaIndex.Write('\t');
            alphaIndex.WriteLine("Alpha");
            StreamWriter numberIndex = new StreamWriter(di.FullName + "\\INDEX\\" + "number.index");
            numberIndex.Write("File Name");
            numberIndex.Write('\t');
            numberIndex.WriteLine("Number");
            foreach (FileInfo f in di.GetFiles())
            {
                Console.WriteLine(f.Name);
                StreamReader sr = new StreamReader(f.FullName);
                if (f.Extension.ToLower() == ".csv" ||
                    f.Extension.ToLower() == ".tab") sr.ReadLine();
                Dictionary<string, string> uniqueLatLong = new Dictionary<string, string>();
                Dictionary<string, string> uniqueDate = new Dictionary<string, string>();
                Dictionary<string, string> uniqueAlpha = new Dictionary<string, string>();
                Dictionary<string, string> uniqueNumber = new Dictionary<string, string>();
                Dictionary<string, string> uniqueEmail = new Dictionary<string, string>();
                while (!sr.EndOfStream)
                {
                    string ln = sr.ReadLine();
                    string l2 = ln.Replace(" ", "");
                    MatchCollection mc = matchDate.Matches(l2);
                    if (mc.Count > 0)
                    {
                        foreach (Match m in mc)
                        {
                            string m1 = m.Captures[0].Value.ToUpper();
                            DateTime dt = DateTime.MinValue;
                            if (DateTime.TryParse(m1, out dt))
                            {
                                if (dt.Year >= 1800 && dt.Year <= 2500)
                                {
                                    uniqueDate[dt.ToString()] = "";
                                }
                            }
                        }
                    }
                    mc = matchLatLong.Matches(l2);
                    if (mc.Count > 0)
                    {
                        foreach (Match m in mc)
                        {
                            string m1 = m.Captures[0].Value.ToUpper();
                            uniqueLatLong[m1] = "";
                        }
                    }
                    string[] parts = ln.Split(new char[] { ',', ' ', '&', '=', '?', '/', '\\', '(', ')', '<', '>', '-', '{', '}', '+' }, StringSplitOptions.RemoveEmptyEntries);
                    foreach (string p in parts)
                    {
                        if (p.Contains('@') && p.Contains('.'))
                        {
                            string eml = p
                                .Replace("<", "")
                                .Replace(">", "")
                                .Replace("\"", "")
                                .Replace(";","")
                                .Replace("'","")
                                .Trim();
                            uniqueEmail[eml] = "";
                        }
                    }
                    mc = matchAlpha.Matches(ln);
                    if (mc.Count > 0)
                    {
                        foreach (Match m in mc)
                        {
                            string m1 = m.Captures[0].Value.ToUpper();
                            string val = m1.Trim().ToUpper();
                            if (val.Length < 1) continue;
                            uniqueAlpha[val] = "";
                        }
                    }
                    mc = matchNum.Matches(ln);
                    if (mc.Count > 0)
                    {
                        foreach (Match m in mc)
                        {
                            string m1 = m.Captures[0].Value.ToUpper();
                            uniqueNumber[m1] = "";
                        }
                    }
                }
                foreach (string key in uniqueEmail.Keys)
                {
                    emailIndex.Write(f.Name);
                    emailIndex.Write('\t');
                    emailIndex.WriteLine(key);
                }
                foreach (string key in uniqueAlpha.Keys)
                {
                    alphaIndex.Write(f.Name);
                    alphaIndex.Write('\t');
                    alphaIndex.WriteLine(key);
                }
                foreach (string key in uniqueNumber.Keys)
                {
                    numberIndex.Write(f.Name);
                    numberIndex.Write('\t');
                    numberIndex.WriteLine(key);
                }
                foreach (string key in uniqueDate.Keys)
                {
                    dateIndex.Write(f.Name);
                    dateIndex.Write('\t');
                    dateIndex.WriteLine(key);
                }
                foreach (string key in uniqueLatLong.Keys)
                {
                    string key2 = "";
                    key2 = key.Replace(',', '\t').Replace('"', ' ');
                    latLongIndex.Write(f.Name);
                    latLongIndex.Write('\t');
                    latLongIndex.WriteLine(key2);
                }
                sr.Close();
            }
            emailIndex.Close();
            alphaIndex.Close();
            numberIndex.Close();
            dateIndex.Close();
            latLongIndex.Close();
        }
    }
}
