using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BaleenLib.BaleenParse
{
    public class FileSplit
    {
        public static void Run(string dataDirectory, int maxFileSizeMB)
        {
            int mxf = maxFileSizeMB * 1000000;
            DirectoryInfo di = new DirectoryInfo(dataDirectory);
            string splitDir = di.FullName + "\\SPLIT\\";
            if (!Directory.Exists(splitDir))
            {
                Directory.CreateDirectory(splitDir);
            }
            FileInfo[] fins = di.GetFiles("*.*", SearchOption.TopDirectoryOnly);
            List<FileInfo> fins2 = (from ff in fins
                                    where (
                                    ff.Extension.ToLower() == ".csv" ||
                                    ff.Extension.ToLower() == ".txt" ||
                                    ff.Extension.ToLower() == ".tab" ||
                                    ff.Extension.ToLower() == ".xml" ||
                                    ff.Extension.ToLower() == ".hat" ||
                                    ff.Extension.ToLower() == ".pipe" ||
                                    ff.Extension.ToLower() == ".cs" ||
                                    ff.Extension.ToLower() == ".pro") &&
                                    ff.LastWriteTime < DateTime.Now.AddSeconds(-0.5)
                                    orderby ff.Length descending
                                    select ff).ToList<FileInfo>();
            if (fins2.Count < 1) return;
            foreach (FileInfo f in fins2)
            {
                int lineCount = 0;
                int fileCount = 0;
                int curFileSize = 0;
                Console.WriteLine(f.Name);
                StreamReader sr = new StreamReader(f.FullName);
                StreamWriter sw = new StreamWriter(splitDir + f.Name.Replace(".", "_") + f.Extension);
                string ln1 = sr.ReadLine();
                curFileSize += ln1.Length;
                sw.WriteLine(ln1);
                while (!sr.EndOfStream)
                {
                    lineCount++;
                    if (lineCount % 1000 == 0) Console.WriteLine("Line: " + lineCount.ToString());
                    string line = sr.ReadLine();
                    curFileSize += line.Length;
                    sw.WriteLine(line);
                    if (curFileSize >= mxf)
                    {
                        sw.Close();
                        curFileSize = 0;
                        sw = new StreamWriter(splitDir + f.Name.Replace(".", "_") + "_" + (fileCount++).ToString() + f.Extension);
                        sw.WriteLine(ln1);
                    }
                }
                if (sw != null) sw.Close();
                sr.Close();
            }
        }
    }
}
