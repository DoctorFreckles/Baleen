using System;
using System.IO;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace BaleenLib
{
    public class ConvertFileToDataTable
    {
        private static Regex CSVandQUOTESplit =
            new Regex(@""",""", RegexOptions.Compiled);
        public static void Run(string directory)
        {
            DirectoryInfo di = new DirectoryInfo(directory);
            string saveDir = di.FullName + "\\SAVEDT\\";
            if (!Directory.Exists(saveDir)) Directory.CreateDirectory(saveDir);
            FileInfo[] fins = di.GetFiles();
            ProcessTXT(fins, 10000, saveDir);
            ProcessCSV(fins, 10000, saveDir);
            ProcessTab(fins, 10000, saveDir);
            ProcessQCSV(fins, 10000, saveDir);
        }
        private static string[] CsvQuoteSplit(string ln)
        {
            if (String.IsNullOrEmpty(ln)) return null;
            string ln2 = ln.Trim();
            if (ln2.Length < 1) return null;
            return CSVandQUOTESplit.Split(ln2);
        }
        public static void ProcessTXT(FileInfo[] fins, int dataTableRows, string saveDir)
        {
            foreach (FileInfo f in fins)
            {
                Console.WriteLine(f.Name);
                int lineCount = 0;
                if (f.Extension.ToUpper() == ".TXT")
                {
                    int fileNo = 0;

                    DataTable dt = new DataTable(f.Name.Replace(f.Extension, "").Trim().Replace(' ', '_') + "_FS" + (++fileNo).ToString());

                    StreamReader sr = new StreamReader(f.FullName);

                    dt.Columns.Add("line_number");
                    dt.Columns.Add("text_value");

                    while (!sr.EndOfStream)
                    {
                        string ln = sr.ReadLine();

                        ln = ln.Trim();

                        if (string.IsNullOrEmpty(ln)) continue;

                        lineCount++;
                        if (lineCount % 10000 == 0) Console.WriteLine("Line Count: " + lineCount.ToString());

                        DataRow dr = dt.NewRow();

                        dr["line_number"] = lineCount.ToString();
                        dr["text_value"] = ln;
                        dt.Rows.Add(dr);

                        if (dt.Rows.Count >= dataTableRows)
                        {
                            dt.WriteXml(saveDir + dt.TableName + ".xml", XmlWriteMode.WriteSchema);
                            dt = new DataTable(f.Name.Replace(f.Extension, "").Trim().Replace(' ', '_') + "_FS" + (++fileNo).ToString());
                            dt.Columns.Add("line_number");
                            dt.Columns.Add("text_value");
                        }
                    }

                    if (dt.Rows.Count > 0)
                    {
                        dt.WriteXml(saveDir + dt.TableName + ".xml", XmlWriteMode.WriteSchema);
                    }

                    sr.Close();
                }
            }
        }
        public static void ProcessCSV(FileInfo[] fins, int dataTableRows, string saveDir)
        {
            foreach (FileInfo f in fins)
            {
                Console.WriteLine(f.Name);
                int lineCount = 0;
                if (f.Extension.ToUpper() == ".CSV")
                {
                    int fileNo = 0;

                    DataTable dt = new DataTable(f.Name.Replace(f.Extension, "").Trim().Replace(' ', '_') + "_FS" + (++fileNo).ToString());

                    StreamReader sr = new StreamReader(f.FullName);
                    string hl = sr.ReadLine();
                    string[] header = hl.Split(',');

                    foreach (string h in header)
                    {
                        dt.Columns.Add(h.ToUpper().Trim().Replace(' ', '_'));
                    }

                    while (!sr.EndOfStream)
                    {
                        string ln = sr.ReadLine();
                        string[] data = ln.Split(',');
                        lineCount++;
                        if (lineCount % 10000 == 0) Console.WriteLine("Line Count: " + lineCount.ToString());
                        if (header.Length <= data.Length)
                        {
                            DataRow dr = dt.NewRow();

                            for (int i = 0; i < header.Length; i++)
                            {
                                string d = data[i].Replace('"', ' ').Trim();
                                string h = header[i].ToUpper().Trim().Replace(' ', '_');
                                if (string.IsNullOrEmpty(d)) continue;
                                dr[h] = d;
                            }

                            dt.Rows.Add(dr);

                        }
                        else
                        {

                        }

                        if (dt.Rows.Count >= dataTableRows)
                        {
                            dt.WriteXml(saveDir + dt.TableName + ".xml", XmlWriteMode.WriteSchema);
                            dt = new DataTable(f.Name.Replace(f.Extension, "").Trim().Replace(' ', '_') + "_FS" + (++fileNo).ToString());
                            foreach (string h in header)
                            {
                                dt.Columns.Add(h.ToUpper().Trim().Replace(' ', '_'));
                            }
                        }
                    }

                    if (dt.Rows.Count > 0)
                    {
                        dt.WriteXml(saveDir + dt.TableName + ".xml", XmlWriteMode.WriteSchema);
                    }

                    sr.Close();
                }
            }
        }
        public static void ProcessTab(FileInfo[] fins, int dataTableRows, string saveDir)
        {
            foreach (FileInfo f in fins)
            {
                Console.WriteLine(f.Name);
                int lineCount = 0;
                if (f.Extension.ToUpper() == ".TAB")
                {
                    int fileNo = 0;

                    DataTable dt = new DataTable(f.Name.Replace(f.Extension, "").Trim().Replace(' ','_') + "_FS" + (++fileNo).ToString());

                    StreamReader sr = new StreamReader(f.FullName);
                    string hl = sr.ReadLine();
                    string[] header = hl.Split('\t');

                    foreach (string h in header)
                    {
                        dt.Columns.Add(h.ToUpper().Trim().Replace(' ', '_'));
                    }

                    while (!sr.EndOfStream)
                    {
                        string ln = sr.ReadLine();
                        string[] data = ln.Split('\t');
                        lineCount++;
                        if (lineCount % 10000 == 0) Console.WriteLine("Line Count: " + lineCount.ToString());
                        if (header.Length == data.Length)
                        {
                            DataRow dr = dt.NewRow();

                            for (int i = 0; i < header.Length; i++)
                            {
                                string d = data[i].Replace('"', ' ').Trim();
                                string h = header[i].ToUpper().Trim().Replace(' ', '_');
                                if (string.IsNullOrEmpty(d)) continue;
                                dr[h] = d;
                            }

                            dt.Rows.Add(dr);

                        }
                        else
                        {

                        }

                        if (dt.Rows.Count >= dataTableRows)
                        {
                            dt.WriteXml(saveDir + dt.TableName + ".xml", XmlWriteMode.WriteSchema);
                            dt = new DataTable(f.Name.Replace(f.Extension, "").Trim().Replace(' ', '_') + "_FS" + (++fileNo).ToString());
                            foreach (string h in header)
                            {
                                dt.Columns.Add(h.ToUpper().Trim().Replace(' ', '_'));
                            }
                        }
                    }

                    if (dt.Rows.Count > 0)
                    {
                        dt.WriteXml(saveDir + dt.TableName + ".xml", XmlWriteMode.WriteSchema);
                    }

                    sr.Close();
                }
            }
        }
        public static void ProcessQCSV(FileInfo[] fins, int dataTableRows, string saveDir)
        {
            foreach (FileInfo f in fins)
            {
                Console.WriteLine(f.Name);
                int lineCount = 0;
                if (f.Extension.ToUpper() == ".QCSV")
                {
                    int fileNo = 0;

                    DataTable dt = new DataTable(f.Name.Replace(f.Extension, "").Trim().Replace(' ', '_') + "_FS" + (++fileNo).ToString());

                    StreamReader sr = new StreamReader(f.FullName);
                    string hl = sr.ReadLine();
                    string[] header = CsvQuoteSplit(hl);

                    foreach (string h in header)
                    {
                        dt.Columns.Add(h.ToUpper().Replace('"',' ').Trim().Replace(' ','_'));
                    }

                    while (!sr.EndOfStream)
                    {
                        string ln = sr.ReadLine();
                        string[] data = CsvQuoteSplit(ln);
                        lineCount++;
                        if (lineCount % 10000 == 0) Console.WriteLine("Line Count: " + lineCount.ToString());
                        if (header.Length == data.Length)
                        {
                            DataRow dr = dt.NewRow();

                            for (int i = 0; i < header.Length; i++)
                            {
                                string d = data[i].Replace('"',' ').Trim();
                                string h = header[i].ToUpper().Replace('"', ' ').Trim().Replace(' ', '_');
                                if (string.IsNullOrEmpty(d)) continue;
                                dr[h] = d;
                            }

                            dt.Rows.Add(dr);

                        }
                        else
                        {

                        }

                        if (dt.Rows.Count >= dataTableRows)
                        {
                            dt.WriteXml(saveDir + dt.TableName + ".xml", XmlWriteMode.WriteSchema);
                            dt = new DataTable(f.Name.Replace(f.Extension, "").Trim().Replace(' ', '_') + "_FS" + (++fileNo).ToString());
                            foreach (string h in header)
                            {
                                dt.Columns.Add(h.ToUpper().Replace('"', ' ').Trim().Replace(' ', '_'));
                            }
                        }
                    }

                    if (dt.Rows.Count > 0)
                    {
                        dt.WriteXml(saveDir + dt.TableName + ".xml", XmlWriteMode.WriteSchema);
                    }

                    sr.Close();
                }
            }
        }
    }
}
