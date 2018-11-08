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
    public class GlobParser2
    {
        private static int MaxRecordSize = 400;
        private static Regex Splits = new Regex(@"(\W+)", RegexOptions.Compiled | RegexOptions.IgnoreCase);
        public static void LoadSmallFact(
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
                string tmp = fi.Directory.FullName + "\\temp.small_fact";
                StreamWriter sw = new StreamWriter(tmp);
                long lineCount = 0;
                long bytesLoaded = 0;
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
bulk insert fact_small
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
bulk insert fact_small
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
        public static void LoadLargeFact(
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
                string tmp = fi.Directory.FullName + "\\temp.large_fact";
                StreamWriter sw = new StreamWriter(tmp);
                long lineCount = 0;
                long bytesLoaded = 0;
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
bulk insert fact_large
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
bulk insert fact_large
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
        public static string FormattedBytesMB(long bytes)
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
        public static string Clean(string line)
        {
            string ln = line.Trim();
            if (ln == null || ln.Length < 1) return "";
            StringBuilder sb = new StringBuilder();
            foreach (char c in ln)
            {
                if (c == '\t')
                {
                    sb.Append("<\\t>");
                }
                else if (c == '\'')
                {
                    sb.Append("''");
                }
                else
                {
                    int ci = (int)c;
                    if (ci < 256)
                    {
                        sb.Append(c);
                    }
                    else
                    {
                        sb.Append("<" + ci.ToString() + ">");
                    }
                }
            }
            return sb.ToString();
        }
        public static void LoadIncremental(
            string DataDirectory,
            string dbConnection,
            int incrementLineCount,
            string UserName)
        {
            string fid = Guid.NewGuid().ToString();
            string blnSF = "baleen_" + fid + ".sfact";
            string blnLF = "baleen_" + fid + ".lfact";
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
                                    ff.Extension.ToLower() == ".py" ||
                                    ff.Extension.ToLower() == ".ps1" ||
                                    ff.Extension.ToLower() == ".pro") &&
                                    ff.LastWriteTime < DateTime.Now.AddSeconds(-0.5)
                                    orderby ff.Length descending
                                    select ff).ToList<FileInfo>();
            if (fins2.Count < 1) return;
            StreamWriter sf = new StreamWriter(di.FullName + "\\" + blnSF);
            StreamWriter lf = new StreamWriter(di.FullName + "\\" + blnLF);
            foreach (FileInfo f in fins2)
            {
                string fn = f.Name.Trim();
                if (fn.Length > 100)
                {
                    fn = fn.Substring(0, 100);
                }
                Console.WriteLine(f.Name);
                long lineCount = 0;
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
                    string ln = Clean(sr.ReadLine());
                    if (String.IsNullOrEmpty(ln) || ln.Length < 1) continue;
                    if (ln.Length <= MaxRecordSize)
                    {
                        sf.Write(fn);
                        sf.Write('\t');
                        sf.Write(lineCount.ToString());
                        sf.Write('\t');
                        sf.Write(UserName);
                        sf.Write('\t');
                        sf.Write(loadDT.ToString());
                        sf.Write('\t');
                        sf.Write('\t');
                        sf.WriteLine(ln);
                    }
                    else
                    {
                        lf.Write(fn);
                        lf.Write('\t');
                        lf.Write(lineCount.ToString());
                        lf.Write('\t');
                        lf.Write(UserName);
                        lf.Write('\t');
                        lf.Write(loadDT.ToString());
                        lf.Write('\t');
                        lf.Write('\t');
                        lf.WriteLine(ln);
                    }
                }
                sr.Close();
                File.Copy(f.FullName, bakDir + f.Name, true);
                File.Delete(f.FullName);
            }
            if (sf != null) sf.Close();
            if (lf != null) lf.Close();
            LoadLargeFact(
                di.FullName + "\\" + blnLF,
                dbConnection,
                incrementLineCount);
            LoadSmallFact(
                di.FullName + "\\" + blnSF, 
                dbConnection, 
                incrementLineCount);
            File.Copy(di.FullName + "\\" + blnLF, bakDir + blnLF, true);
            File.Copy(di.FullName + "\\" + blnSF, bakDir + blnSF, true);
            File.Delete(di.FullName + "\\" + blnLF);
            File.Delete(di.FullName + "\\" + blnSF);
            File.WriteAllText(di.FullName + "\\end.time", DateTime.Now.ToString());
        }
    }
}
