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
    public class RectangularParser
    {
        private static long tokenID = 0;
        private static Dictionary<string, long> tokens = new Dictionary<string, long>();
        private long GetToken(string value)
        {
            if (String.IsNullOrEmpty(value)) return -1;
            string k = value.ToUpper().Trim();
            if (k.Length < 1) return -1;
            if (tokens.ContainsKey(k))
            {
                return tokens[k];
            }
            else
            {
                tokenID++;
                tokens.Add(k, tokenID);
                return tokenID;
            }
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
                string[] fields = null;
                bool isCsvFile = false;
                bool isTabFile = false;
                if (f.Extension.ToLower().Trim() == ".csv")
                {
                    string ln1 = sr.ReadLine();
                    isCsvFile = true;
                    fields = ln1.Split(',');
                }
                if (f.Extension.ToLower().Trim() == ".tab")
                {
                    string ln1 = sr.ReadLine();
                    isTabFile = true;
                    fields = ln1.Split('\t');
                }
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
                    if (String.IsNullOrEmpty(ln) || ln.Length < 1) continue;
                    if (isCsvFile)
                    {




                    }
                    else if (isTabFile)
                    {

                        string[] dat = ln.Split('\t');

                        for (int i = 0; i < fields.Length; i++)
                        {
                            if (i < dat.Length)
                            {
                                string p = fields[i].Trim().ToUpper();
                                string d = dat[i].Trim().ToUpper();
                                if (d.Length > 0)
                                {





                                }
                            }
                        }


                    }
                    else
                    {

                    }





                    //if (ln.Length <= MaxRecordSize)
                    //{
                    //    sf.Write(fn);
                    //    sf.Write('\t');
                    //    sf.Write(lineCount.ToString());
                    //    sf.Write('\t');
                    //    sf.Write(UserName);
                    //    sf.Write('\t');
                    //    sf.Write(loadDT.ToString());
                    //    sf.Write('\t');
                    //    sf.Write('\t');
                    //    sf.WriteLine(ln);
                    //}
                    //else
                    //{
                    //    lf.Write(fn);
                    //    lf.Write('\t');
                    //    lf.Write(lineCount.ToString());
                    //    lf.Write('\t');
                    //    lf.Write(UserName);
                    //    lf.Write('\t');
                    //    lf.Write(loadDT.ToString());
                    //    lf.Write('\t');
                    //    lf.Write('\t');
                    //    lf.WriteLine(ln);
                    //}
                }
                sr.Close();
                //File.Copy(f.FullName, bakDir + f.Name, true);
                //File.Delete(f.FullName);
            }
            //if (sf != null) sf.Close();
            //if (lf != null) lf.Close();
            //LoadLargeFact(
            //    di.FullName + "\\" + blnLF,
            //    dbConnection,
            //    incrementLineCount);
            //LoadSmallFact(
            //    di.FullName + "\\" + blnSF,
            //    dbConnection,
            //    incrementLineCount);
            //File.Copy(di.FullName + "\\" + blnLF, bakDir + blnLF, true);
            //File.Copy(di.FullName + "\\" + blnSF, bakDir + blnSF, true);
            //File.Delete(di.FullName + "\\" + blnLF);
            //File.Delete(di.FullName + "\\" + blnSF);
            //File.WriteAllText(di.FullName + "\\end.time", DateTime.Now.ToString());
        }
    }
}
