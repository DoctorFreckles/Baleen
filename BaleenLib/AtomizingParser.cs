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
    public class AtomizingParser
    {
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
                string tmp = fi.Directory.FullName + "\\temp.tmp";
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
        public static void LoadData(string completeBaleenFilePath, string DBConnect)
        {
            SqlConnection c = null;
            try
            {
                c = new SqlConnection(DBConnect);
                c.Open();
                SqlCommand cmd = new SqlCommand(@"
bulk insert fact
from '<<FP>>'
with
(
firstrow = 2
)
".Replace("<<FP>>", completeBaleenFilePath), c);
                cmd.CommandTimeout = 1000;
                int res = cmd.ExecuteNonQuery();
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
        public static void LoadIncremental(
            string DataDirectory,
            string dbConnection,
            int incrementLineCount)
        {
            string fid = Guid.NewGuid().ToString();
            string blnFN = "baleen_" + fid + ".fact";
            int tokenSequenceLen = 20;
            int maxTokenLen = 30;
            DirectoryInfo di = new DirectoryInfo(DataDirectory);
            string bakDir = di.FullName + "\\BAK\\";
            if (!Directory.Exists(bakDir))
            {
                Directory.CreateDirectory(bakDir);
            }
            FileInfo[] fins = di.GetFiles("*.*", SearchOption.TopDirectoryOnly);
            File.WriteAllText(di.FullName + "\\start.time", DateTime.Now.ToString());
            List<FileInfo> fins2 = (from ff in fins
                                    where (ff.Extension == ".csv" ||
                                    ff.Extension == ".txt" ||
                                    ff.Extension == ".tab") &&
                                    ff.LastWriteTime < DateTime.Now.AddSeconds(-0.5)
                                    orderby ff.Length descending
                                    select ff).ToList<FileInfo>();

            if (fins2.Count < 1) return;

            StreamWriter sw = new StreamWriter(di.FullName + "\\" + blnFN);
            foreach (FileInfo f in fins2)
            {
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
                    string ln = sr.ReadLine();
                    List<string> parts = Tokenize(ln, maxTokenLen);
                    if (parts == null || parts.Count < 1) continue;
                    List<string> fact = new List<string>();
                    int seqNo = 0;
                    foreach (string p in parts)
                    {
                        if (String.IsNullOrEmpty(p))
                        {
                            continue;
                        }
                        fact.Add(p);
                        if (fact.Count == tokenSequenceLen)
                        {
                            sw.Write(f.Name);
                            sw.Write('\t');
                            sw.Write(lineCount.ToString());
                            sw.Write('\t');
                            sw.Write(seqNo.ToString());
                            foreach (string s in fact)
                            {
                                sw.Write('\t');
                                sw.Write(s);
                            }
                            sw.Write('\t');
                            sw.Write("system_bulk_load");
                            sw.Write('\t');
                            sw.Write(loadDT.ToString());
                            sw.WriteLine();
                            seqNo++;
                            fact = new List<string>();
                        }
                    }
                    if (fact.Count > 0)
                    {
                        sw.Write(f.Name);
                        sw.Write('\t');
                        sw.Write(lineCount.ToString());
                        sw.Write('\t');
                        sw.Write(seqNo.ToString());
                        for (int i = 0; i < tokenSequenceLen; i++)
                        {
                            if (i < fact.Count)
                            {
                                sw.Write('\t');
                                sw.Write(fact[i]);
                            }
                            else
                            {
                                sw.Write('\t');
                                sw.Write("");
                            }
                        }
                        sw.Write('\t');

                        sw.Write("system_bulk_load");
                        sw.Write('\t');
                        sw.Write(loadDT.ToString());
                        sw.WriteLine();
                    }
                }
                sr.Close();
                File.Copy(f.FullName, bakDir + f.Name, true);
                File.Delete(f.FullName);
            }
            if (sw != null) sw.Close();
            LoadDataIncremental(di.FullName + "\\" + blnFN, dbConnection, incrementLineCount);
            File.Copy(di.FullName + "\\" + blnFN, bakDir + blnFN, true);
            File.Delete(di.FullName + "\\" + blnFN);
            File.WriteAllText(di.FullName + "\\end.time", DateTime.Now.ToString());
        }
        public static void Load(
            string DataDirectory,
            string dbConnection)
        {
            string fid = Guid.NewGuid().ToString();
            string blnFN = "baleen_" + fid + ".fact";
            int tokenSequenceLen = 20;
            int maxTokenLen = 30;
            DirectoryInfo di = new DirectoryInfo(DataDirectory);
            string bakDir = di.FullName + "\\BAK\\";
            if (!Directory.Exists(bakDir))
            {
                Directory.CreateDirectory(bakDir);
            }
            FileInfo[] fins = di.GetFiles("*.*", SearchOption.TopDirectoryOnly);
            File.WriteAllText(di.FullName + "\\start.time", DateTime.Now.ToString());
            List<FileInfo> fins2 = (from ff in fins
                                    where ff.Extension == ".csv" ||
                                    ff.Extension == ".txt" ||
                                    ff.Extension == ".tab"
                                    orderby ff.Length descending
                                    select ff).ToList<FileInfo>();
            StreamWriter sw = new StreamWriter(di.FullName + "\\" + blnFN);
            sw.Write("file_name");
            sw.Write('\t');
            sw.Write("line_number");
            sw.Write('\t');
            sw.Write("sequence_number");
            for (int i = 0; i < tokenSequenceLen; i++)
            {
                sw.Write('\t');
                sw.Write("token_" + i.ToString());
            }
            sw.Write('\t');
            sw.Write("user_key");
            sw.Write('\t');
            sw.Write("created_on");
            sw.WriteLine();
            foreach (FileInfo f in fins2)
            {
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
                    string ln = sr.ReadLine();
                    List<string> parts = Tokenize(ln, maxTokenLen);
                    if (parts == null || parts.Count < 1) continue;
                    List<string> fact = new List<string>();
                    int seqNo = 0;
                    foreach (string p in parts)
                    {
                        if (String.IsNullOrEmpty(p))
                        {
                            continue;
                        }
                        fact.Add(p);
                        if (fact.Count == tokenSequenceLen)
                        {
                            sw.Write(f.Name);
                            sw.Write('\t');
                            sw.Write(lineCount.ToString());
                            sw.Write('\t');
                            sw.Write(seqNo.ToString());
                            foreach (string s in fact)
                            {
                                sw.Write('\t');
                                sw.Write(s);
                            }
                            sw.Write('\t');
                            sw.Write("system_bulk_load");
                            sw.Write('\t');
                            sw.Write(loadDT.ToString());
                            sw.WriteLine();
                            seqNo++;
                            fact = new List<string>();
                        }
                    }
                    if (fact.Count > 0)
                    {
                        sw.Write(f.Name);
                        sw.Write('\t');
                        sw.Write(lineCount.ToString());
                        sw.Write('\t');
                        sw.Write(seqNo.ToString());
                        for (int i = 0; i < tokenSequenceLen; i++)
                        {
                            if (i < fact.Count)
                            {
                                sw.Write('\t');
                                sw.Write(fact[i]);
                            }
                            else
                            {
                                sw.Write('\t');
                                sw.Write("");
                            }
                        }
                        sw.Write('\t');

                        sw.Write("system_bulk_load");
                        sw.Write('\t');
                        sw.Write(loadDT.ToString());
                        sw.WriteLine();
                    }
                }
                sr.Close();
                File.Copy(f.FullName, bakDir + f.Name, true);
                File.Delete(f.FullName);
            }
            if (sw != null) sw.Close();
            LoadData(di.FullName + "\\" + blnFN, dbConnection);
            File.Copy(di.FullName + "\\" + blnFN, bakDir + blnFN, true);
            File.Delete(di.FullName + "\\" + blnFN);
            File.WriteAllText(di.FullName + "\\end.time", DateTime.Now.ToString());
        }
        public static void ProcessFiles(
            int tokenSequenceLen, 
            int maxTokenLen, 
            int maxFileSizeMB,
            string DataDirectory)
        {
            DirectoryInfo di = new DirectoryInfo(DataDirectory);
            FileInfo[] fins = di.GetFiles("*.*", SearchOption.AllDirectories);
            File.WriteAllText(di.FullName + "\\start.time", DateTime.Now.ToString());
            List<FileInfo> fins2 = (from ff in fins
                                    where ff.Extension == ".csv" ||
                                    ff.Extension == ".txt" ||
                                    ff.Extension == ".tab"
                                    orderby ff.Length descending
                                    select ff).ToList<FileInfo>();

            StreamWriter sw = new StreamWriter(di.FullName + "\\baleen_0.fact");
            int curFileSize = 0;
            int fileCount = 0;
            sw.Write("file_name");
            sw.Write('\t');
            sw.Write("line_number");
            sw.Write('\t');
            sw.Write("sequence_number");
            for (int i = 0; i < tokenSequenceLen; i++)
            {
                sw.Write('\t');
                sw.Write("token_" + i.ToString());
            }
            sw.Write('\t');
            sw.Write("user_key");
            sw.Write('\t');
            sw.Write("created_on");
            sw.WriteLine();
            curFileSize += 30;
            foreach (FileInfo f in fins2)
            {
                Console.WriteLine(f.Name);
                File.WriteAllText(di.FullName + "\\" + f.Name.Replace('.', '_') + ".fact_start", DateTime.Now.ToString());
                int lineCount = 0;
                StreamReader sr = new StreamReader(f.FullName);
                while (!sr.EndOfStream)
                {
                    lineCount++;
                    if (lineCount % 10000 == 0)
                    {
                        Console.WriteLine("Processing File: " + f.Name);
                        Console.WriteLine("Fact Processing Line No: " + lineCount.ToString());
                        Console.WriteLine("Current File Size: " + curFileSize.ToString());
                    }
                    DateTime loadDT = DateTime.Now;
                    string ln = sr.ReadLine();
                    List<string> parts = Tokenize(ln, maxTokenLen);
                    if (parts == null || parts.Count < 1) continue;
                    List<string> fact = new List<string>();
                    int seqNo = 0;
                    foreach (string p in parts)
                    {
                        if (String.IsNullOrEmpty(p))
                        {
                            continue;
                        }
                        fact.Add(p);
                        if (fact.Count == tokenSequenceLen)
                        {
                            curFileSize += f.Name.Length + 1;
                            sw.Write(f.Name);
                            sw.Write('\t');
                            curFileSize += lineCount.ToString().Length + 1;
                            sw.Write(lineCount.ToString());
                            sw.Write('\t');
                            curFileSize += seqNo.ToString().Length + 1;
                            sw.Write(seqNo.ToString());
                            foreach (string s in fact)
                            {
                                sw.Write('\t');
                                sw.Write(s);
                                curFileSize += s.Length + 1;
                            }
                            sw.Write('\t');
                            curFileSize += "system_bulk_load".Length + 1;
                            sw.Write("system_bulk_load");
                            sw.Write('\t');
                            curFileSize += loadDT.ToString().Length + 1;
                            sw.Write(loadDT.ToString());
                            sw.WriteLine();
                            seqNo++;
                            fact = new List<string>();
                        }
                    }
                    if (fact.Count > 0)
                    {
                        curFileSize += f.Name.Length + 1;
                        sw.Write(f.Name);
                        sw.Write('\t');
                        curFileSize += lineCount.ToString().Length + 1;
                        sw.Write(lineCount.ToString());
                        sw.Write('\t');
                        curFileSize += seqNo.ToString().Length + 1;
                        sw.Write(seqNo.ToString());
                        for (int i = 0; i < tokenSequenceLen; i++)
                        {
                            if (i < fact.Count)
                            {
                                sw.Write('\t');
                                sw.Write(fact[i]);
                                curFileSize += fact[i].Length + 1;
                            }
                            else
                            {
                                curFileSize += 1;
                                sw.Write('\t');
                                sw.Write("");
                            }
                        }
                        sw.Write('\t');

                        curFileSize += "system_bulk_load".Length + 1;
                        sw.Write("system_bulk_load");
                        sw.Write('\t');
                        curFileSize += loadDT.ToString().Length + 1;
                        sw.Write(loadDT.ToString());
                        sw.WriteLine();
                    }

                    if (maxFileSizeMB * 1000000 <= curFileSize)
                    {
                        fileCount++;
                        sw.Close();
                        curFileSize = 0;
                        sw = new StreamWriter(di.FullName + "\\baleen_" + fileCount.ToString() + ".fact");
                        sw.Write("file_name");
                        sw.Write('\t');
                        sw.Write("line_number");
                        sw.Write('\t');
                        sw.Write("sequence_number");
                        for (int i = 0; i < tokenSequenceLen; i++)
                        {
                            sw.Write('\t');
                            sw.Write("token_" + i.ToString());
                        }
                        sw.Write('\t');
                        sw.Write("user_key");
                        sw.Write('\t');
                        sw.Write("created_on");
                        sw.WriteLine();
                        curFileSize += 30;
                    }
                }
                sr.Close();
                File.WriteAllText(di.FullName + "\\" + f.Name.Replace('.', '_') + ".fact_end", DateTime.Now.ToString());
            }
            if (sw != null) sw.Close();
            File.WriteAllText(di.FullName + "\\end.time", DateTime.Now.ToString());
        }
        public static List<string> Tokenize(string value, int width)
        {
            StringBuilder sb = new StringBuilder();
            foreach (char c in value)
            {
                int ci = (int)c;
                if (Char.IsLetterOrDigit(c) && ci < 256)
                {
                    sb.Append(c);
                }
                else
                {
                    sb.Append(' ');
                    sb.Append('<');
                    sb.Append(((int)c).ToString());
                    sb.Append('>');
                    sb.Append(' ');
                }
            }
            string[] lst = sb.ToString().Split(' '); //splitter.Split(sb.ToString());
            List<string> rsl = new List<string>();
            foreach (string s in lst)
            {
                if (String.IsNullOrEmpty(s)) continue;
                if (s.Length > width)
                {
                    StringBuilder sb2 = new StringBuilder();
                    foreach (char c in s)
                    {
                        sb2.Append(c);
                        if (sb2.Length == width)
                        {
                            rsl.Add(sb2.ToString());
                            sb2 = new StringBuilder();
                        }
                    }
                    if (sb2.Length > 0)
                    {
                        rsl.Add(sb2.ToString());
                    }
                }
                else
                {
                    rsl.Add(s);
                }
            }
            return rsl;
        }
    }
}
