using System;
using System.Data.SqlClient;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Configuration;

namespace BaleenLib.BaleenParse
{
    public class GlobParser
    {
        private static Regex Splits = new Regex(@"(\W+)", RegexOptions.Compiled | RegexOptions.IgnoreCase);
        public static void LoadIndexIncremental(
            string completeBaleenFilePath,
            string DBConnect,
            int loadLineNumber)
        {
            SqlConnection c = null;
            try
            {
                c = new SqlConnection(DBConnect);
                c.Open();
                FileInfo fi = new FileInfo(completeBaleenFilePath);
                StreamReader sr = new StreamReader(completeBaleenFilePath);
                string tmp = fi.Directory.FullName + "\\temp.index";
                StreamWriter sw = new StreamWriter(tmp);
                int lineCount = 0;
                int bytesLoaded = 0;
                while (!sr.EndOfStream)
                {
                    string ln = sr.ReadLine();
                    bytesLoaded += ln.Length;
                    sw.WriteLine(ln);
                    lineCount++;
                    if (lineCount >= loadLineNumber)
                    {
                        sw.Close();
                        lineCount = 0;
                        SqlCommand cmd = new SqlCommand(@"
bulk insert fact_index
from '<<FP>>'
with
(
firstrow = 1
)
".Replace("<<FP>>", tmp), c);
                        cmd.CommandTimeout = 1000;
                        int res = cmd.ExecuteNonQuery();
                        File.Delete(tmp);
                        sw = new StreamWriter(tmp);
                        Console.WriteLine("MB Bytes Loaded: " + FormattedBytesMB(bytesLoaded));
                    }
                }
                sr.Close();
                if (lineCount > 0)
                {
                    sw.Close();
                    lineCount = 0;
                    SqlCommand cmd = new SqlCommand(@"
bulk insert fact_index
from '<<FP>>'
with
(
firstrow = 1
)
".Replace("<<FP>>", tmp), c);
                    cmd.CommandTimeout = 1000;
                    int res = cmd.ExecuteNonQuery();
                    File.Delete(tmp);
                    Console.WriteLine("MB Bytes Loaded: " + FormattedBytesMB(bytesLoaded));
                }
                else
                {
                    if (sw != null) sw.Close();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (c != null) c.Close();
            }
        }
        public static void LoadDataIncremental(
            string completeBaleenFilePath,
            string DBConnect,
            int loadLineNumber)
        {
            SqlConnection c = null;
            try
            {
                c = new SqlConnection(DBConnect);
                c.Open();
                FileInfo fi = new FileInfo(completeBaleenFilePath);
                StreamReader sr = new StreamReader(completeBaleenFilePath);
                string tmp = fi.Directory.FullName + "\\temp.fact";
                StreamWriter sw = new StreamWriter(tmp);
                int lineCount = 0;
                int bytesLoaded = 0;
                while (!sr.EndOfStream)
                {
                    string ln = sr.ReadLine();
                    bytesLoaded += ln.Length;
                    sw.WriteLine(ln);
                    lineCount++;
                    if (lineCount >= loadLineNumber)
                    {
                        sw.Close();
                        lineCount = 0;
                        SqlCommand cmd = new SqlCommand(@"
bulk insert fact
from '<<FP>>'
with
(
firstrow = 1
)
".Replace("<<FP>>", tmp), c);
                        cmd.CommandTimeout = 1000;
                        int res = cmd.ExecuteNonQuery();
                        File.Delete(tmp);
                        sw = new StreamWriter(tmp);
                        Console.WriteLine("MB Bytes Loaded: " + FormattedBytesMB(bytesLoaded));
                    }
                }
                sr.Close();
                if (lineCount > 0)
                {
                    sw.Close();
                    lineCount = 0;
                    SqlCommand cmd = new SqlCommand(@"
bulk insert fact
from '<<FP>>'
with
(
firstrow = 1
)
".Replace("<<FP>>", tmp), c);
                    cmd.CommandTimeout = 1000;
                    int res = cmd.ExecuteNonQuery();
                    File.Delete(tmp);
                    Console.WriteLine("MB Bytes Loaded: " + FormattedBytesMB(bytesLoaded));
                }
                else
                {
                    if (sw != null) sw.Close();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (c != null) c.Close();
            }
        }
        public static string FormattedBytesMB(int bytes)
        {
            double b2 = ((double)bytes) / 1000000;
            return ((int)b2).ToString();
        }
        public static List<string> TokenizeForIndex(string value)
        {
            string loc = value.Trim();
            if (String.IsNullOrEmpty(loc)) return null;
            string[] parts = Splits.Split(loc);
            Dictionary<string, string> dic = new Dictionary<string, string>();
            foreach (string p in parts)
            {
                string k = p.Trim();
                if (String.IsNullOrEmpty(k)) continue;
                if (Char.IsLetterOrDigit(k[0]))
                {
                    if (k.Length > 50)
                    {
                        k = k.Substring(0, 50);
                    }
                    dic[k] = k;
                }
            }
            return dic.Values.ToList<string>();
        }
        public static void LoadIncremental(
            string DataDirectory,
            string dbConnection,
            int incrementLineCount,
            string UserName)
        {
            string fid = Guid.NewGuid().ToString();
            string blnFN = "baleen_" + fid + ".fact";
            string blnID = "baleen_" + fid + ".index";
            DirectoryInfo di = new DirectoryInfo(DataDirectory);
            string bakDir = di.FullName + "\\BAK\\";
            if (!Directory.Exists(bakDir))
            {
                Directory.CreateDirectory(bakDir);
            }
            FileInfo[] fins = di.GetFiles("*.*", SearchOption.TopDirectoryOnly);
            File.WriteAllText(di.FullName + "\\start.time", DateTime.Now.ToString());
            List<FileInfo> fins2 = (from ff in fins
                                    where (
                                    ff.Extension.ToLower() == ".csv" ||
                                    ff.Extension.ToLower() == ".txt" ||
                                    ff.Extension.ToLower() == ".tab" ||
                                    ff.Extension.ToLower() == ".xml" ||
                                    ff.Extension.ToLower() == ".cs" ||
                                    ff.Extension.ToLower() == ".pro") &&
                                    ff.LastWriteTime < DateTime.Now.AddSeconds(-0.5)
                                    orderby ff.Length descending
                                    select ff).ToList<FileInfo>();
            if (fins2.Count < 1) return;
            StreamWriter swi = new StreamWriter(di.FullName + "\\" + blnID);
            StreamWriter sw = new StreamWriter(di.FullName + "\\" + blnFN);
            foreach (FileInfo f in fins2)
            {
                string fn = f.Name.Trim();
                if (fn.Length > 100)
                {
                    fn = fn.Substring(0, 100);
                }
                Console.WriteLine(f.Name);
                int lineCount = 0;
                StreamReader sr = new StreamReader(f.FullName);
                while (!sr.EndOfStream)
                {
                    lineCount++;
                    if (lineCount % 10000 == 0)
                    {
                        Console.WriteLine("Processing File: " + f.Name);
                        Console.WriteLine("Fact Processing Line No: " + lineCount.ToString());
                    }
                    DateTime loadDT = DateTime.Now;
                    string ln = sr.ReadLine().Trim().Replace("'","''");
                    if (String.IsNullOrEmpty(ln)) continue;
                    List<string> idx = TokenizeForIndex(ln);
                    foreach (string i in idx)
                    {
                        swi.Write(fn);
                        swi.Write('\t');
                        swi.Write(lineCount.ToString());
                        swi.Write('\t');
                        swi.WriteLine(i);
                    }
                    sw.Write(fn);
                    sw.Write('\t');
                    sw.Write(lineCount.ToString());
                    sw.Write('\t');
                    sw.Write(loadDT.ToString());
                    sw.Write('\t');
                    sw.Write(UserName);
                    sw.Write('\t');
                    string ln2 = ln.Replace("\t", "<\\t>");
                    sw.WriteLine(ln2);
                }
                sr.Close();
                File.Copy(f.FullName, bakDir + f.Name, true);
                File.Delete(f.FullName);
            }
            if (swi != null) swi.Close();
            if (sw != null) sw.Close();
            LoadDataIncremental(
                di.FullName + "\\" + blnFN, 
                dbConnection, 
                incrementLineCount);
            LoadIndexIncremental(
                di.FullName + "\\" + blnID,
                dbConnection,
                10000);
            File.Copy(di.FullName + "\\" + blnFN, bakDir + blnFN, true);
            File.Copy(di.FullName + "\\" + blnID, bakDir + blnID, true);
            File.Delete(di.FullName + "\\" + blnFN);
            File.Delete(di.FullName + "\\" + blnID);
            File.WriteAllText(di.FullName + "\\end.time", DateTime.Now.ToString());
        }
    }
}
