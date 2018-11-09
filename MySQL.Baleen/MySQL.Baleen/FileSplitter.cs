using System;
using System.Collections.Generic;
using System.IO;

namespace BaleenLib
{
    public class FileSplitter
    {
        public static void SimpleWithHeader(
            string filePath, 
            int parts,
            string newDirectory,
            string newFilePrefix
        )
        {
            // important: this parse function assumes
            // a file that has a header row
            Dictionary<int, StreamWriter> writers =
                new Dictionary<int, StreamWriter>();
            StreamReader sr = null;
            try
            {
                DirectoryInfo diNew = new DirectoryInfo(newDirectory);
                FileInfo fiRead = new FileInfo(filePath);
                sr = new StreamReader(filePath);
                int line = 0;
                string headerLine = null;
                while(!sr.EndOfStream)
                {
                    string wl = sr.ReadLine();

                    if(line % 1000 == 0)
                    {
                        Console.WriteLine("Line number: " + line.ToString());
                    }

                    if(line == 0)
                    {
                        headerLine = wl;
                    }
                    else
                    {
                        int bucket = line % parts;

                        if(!writers.ContainsKey(bucket))
                        {
                            string newDir = diNew.FullName + "/" + newFilePrefix +
                                                 "_" + bucket.ToString();
                            Directory.CreateDirectory(newDir);
                            string newCompletePath = newDir + "/" + newFilePrefix +
                                                          "_" + bucket.ToString() + fiRead.Extension;
                            writers[bucket] = new StreamWriter(newCompletePath);
                            writers[bucket].WriteLine(headerLine);
                        }

                        writers[bucket].WriteLine(wl);
                    }

                    line++;
                }
            }
            catch(Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            finally
            {
                foreach(int ikey in writers.Keys)
                {
                    if(writers[ikey] != null)
                    {
                        writers[ikey].Close();
                    }
                }
                if (sr != null) sr.Close();
            }
        }
    }
}
