using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BaleenLib
{
    public class SplitNPIParse
    {
        public static void Run(string srcFile, int colKey)
        {
            if (!File.Exists(srcFile)) return;
            FileInfo npi = new FileInfo(srcFile);
            string opDir = npi.Directory.FullName + "\\OP_NPI\\";
            if (!Directory.Exists(opDir))
            {
                Directory.CreateDirectory(opDir);
            }
            Dictionary<string, StreamWriter> writers = new Dictionary<string, StreamWriter>();
            StreamReader sr = new StreamReader(srcFile);
            string hdr = sr.ReadLine();
            long lineCount = 0;
            while (!sr.EndOfStream)
            {
                string line = sr.ReadLine();
                string[] dat = Utility.UtilityMain.CsvQuoteSplit(line);
                if (dat.Length != 329)
                {

                }
                string writerKey = Utility.UtilityMain.EncodeString2(dat[31]);
                if (!writers.ContainsKey(writerKey))
                {
                    Console.WriteLine(dat[31]);
                    writers.Add(writerKey, new StreamWriter(opDir + "npi_" + writerKey + ".csv"));
                    writers[writerKey].WriteLine(hdr);
                }
                lineCount++;
                if (lineCount % 1000 == 0) Console.WriteLine("Line: " + lineCount.ToString());
                writers[writerKey].WriteLine(line);
            }
            sr.Close();
            if (writers != null)
            {
                if (writers.Keys.Count > 0)
                {
                    foreach (string key in writers.Keys)
                    {
                        if (writers[key] != null) writers[key].Close();
                    }
                }
            }
        }
    }
}
