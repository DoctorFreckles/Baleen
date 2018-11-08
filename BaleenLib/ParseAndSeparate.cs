using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BaleenLib
{
    public class ParseAndSeparate
    {
        public static void Run(DirectoryInfo di, double sizeInMegabytes)
        {
            string outDir = di.FullName + "\\PROCESSED\\" + DateTime.Now.Year.ToString() + "-" +
                DateTime.Now.Month.ToString() + "-" +
                DateTime.Now.Day.ToString() + "-" +
                DateTime.Now.Hour.ToString() + "-" +
                DateTime.Now.Minute.ToString() + "-" +
                DateTime.Now.Second.ToString();
            if (!Directory.Exists(outDir))
            {
                Directory.CreateDirectory(outDir);
            }
            double sizeD = sizeInMegabytes * 1000000;
            long sizeI = (long)sizeD;
            if (sizeInMegabytes < 0) sizeI = 10000000;
            List<FileInfo> textFiles = new List<FileInfo>();
            List<FileInfo> tabFiles = new List<FileInfo>();
            List<FileInfo> csvFiles = new List<FileInfo>();
            foreach (FileInfo f in di.GetFiles())
            {
                Console.WriteLine("Acquiring File: " + f.Name);
                if (f.Extension.ToLower() == ".txt")
                {
                    textFiles.Add(f);
                }
                if (f.Extension.ToLower() == ".tab")
                {
                    tabFiles.Add(f);
                }
                if (f.Extension.ToLower() == ".csv")
                {
                    csvFiles.Add(f);
                }
            }
            foreach (FileInfo f in tabFiles)
            {
                string fName2 = f.Name.ToLower().Replace(f.Extension.ToLower(), "");
                StreamReader sr = new StreamReader(f.FullName);
                long byteCount = 0;
                long lineCount = 0;
                StreamWriter sw = null;
                int fileCount = 0;
                string hdr = sr.ReadLine();
                sw = new StreamWriter(outDir + "\\" + fName2 + "_file_" + (fileCount++).ToString() + ".tab");
                sw.WriteLine(hdr);
                while (!sr.EndOfStream)
                {
                    string ln = sr.ReadLine();
                    lineCount++;
                    if (lineCount % 1000 == 0) Console.WriteLine(fName2 + " Line No: " + lineCount.ToString());
                    byteCount += ln.Length;
                    if (byteCount >= sizeI)
                    {
                        sw = new StreamWriter(outDir + "\\" + fName2 + "_file_" + (fileCount++).ToString() + ".tab");
                        sw.WriteLine(hdr);
                        byteCount = 0;
                    }
                    sw.WriteLine(ln);
                }
                if (sw != null)
                {
                    sw.Close();
                }
                sr.Close();
            }
            foreach (FileInfo f in csvFiles)
            {
                string fName2 = f.Name.ToLower().Replace(f.Extension.ToLower(), "");
                StreamReader sr = new StreamReader(f.FullName);
                long byteCount = 0;
                long lineCount = 0;
                StreamWriter sw = null;
                int fileCount = 0;
                string hdr = sr.ReadLine();
                sw = new StreamWriter(outDir + "\\" + fName2 + "_file_" + (fileCount++).ToString() + ".csv");
                sw.WriteLine(hdr);
                while (!sr.EndOfStream)
                {
                    string ln = sr.ReadLine();
                    lineCount++;
                    if (lineCount % 1000 == 0) Console.WriteLine(fName2 + " Line No: " + lineCount.ToString());
                    byteCount += ln.Length;
                    if (byteCount >= sizeI)
                    {
                        sw = new StreamWriter(outDir + "\\" + fName2 + "_file_" + (fileCount++).ToString() + ".csv");
                        sw.WriteLine(hdr);
                        byteCount = 0;
                    }
                    sw.WriteLine(ln);
                }
                if (sw != null)
                {
                    sw.Close();
                }
                sr.Close();
            }
            foreach (FileInfo f in textFiles)
            {
                string fName2 = f.Name.ToLower().Replace(f.Extension.ToLower(), "");
                StreamReader sr = new StreamReader(f.FullName);
                long byteCount = 0;
                long lineCount = 0;
                StreamWriter sw = null;
                int fileCount = 0;
                sw = new StreamWriter(outDir + "\\" + fName2 + "_file_" + (fileCount++).ToString() + ".txt");
                while (!sr.EndOfStream)
                {
                    string ln = sr.ReadLine();
                    lineCount++;
                    if (lineCount % 1000 == 0) Console.WriteLine(fName2 + " Line No: " + lineCount.ToString());
                    byteCount += ln.Length;
                    if (byteCount >= sizeI)
                    {
                        sw = new StreamWriter(outDir + "\\" + fName2 + "_file_" + (fileCount++).ToString() + ".txt");
                        byteCount = 0;
                    }
                    sw.WriteLine(ln);
                }
                if (sw != null)
                {
                    sw.Close();
                }
                sr.Close();
            }
        }
    }
}
