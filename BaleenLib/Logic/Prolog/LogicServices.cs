using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BaleenLib.Logic.Prolog
{
    public class LogicServices
    {
        private string dumpDir = "";
        private string IndexDirectory = "";
        private string DataDirectory = "";
        private int RequestTimeout = 0;
        private string plConExe = "";
        private List<LogicEXE> LogicEngines = null;
        private int numOfEngines = 1;
        public LogicServices(string indexDir, string dataDir, int timeOut, string plCon, int numberOfEngines)
        {
            this.plConExe = plCon;
            this.IndexDirectory = indexDir;
            this.DataDirectory = dataDir + "DATA_DIR\\";
            this.RequestTimeout = timeOut;
            this.dumpDir = this.DataDirectory + "TMP\\";
            if (!Directory.Exists(this.dumpDir)) Directory.CreateDirectory(this.dumpDir);
            this.LogicEngines = new List<LogicEXE>();
            if (numberOfEngines < 1) throw new Exception("Must specify at least one engine.");
            this.numOfEngines = numberOfEngines;
            for (int i = 0; i < numberOfEngines; i++)
            {
                LogicEXE pl = new LogicEXE(this.dumpDir, this.plConExe, timeOut);
                if (File.Exists(this.dumpDir + i.ToString() + "_INDEX.PRO"))
                {
                    Console.WriteLine("Loading PL: " + i.ToString());
                    pl.Consult(this.dumpDir + i.ToString() + "_INDEX.PRO");
                }
                this.LogicEngines.Add(pl);
            }
        }
        public void MergeIndexes()
        {
            DirectoryInfo di = new DirectoryInfo(this.IndexDirectory);
            FileInfo[] fins = di.GetFiles("*.INDEX", SearchOption.TopDirectoryOnly);
            int counter = 0;

            Dictionary<int, StreamWriter> mergeStreams = new Dictionary<int, StreamWriter>();

            foreach (FileInfo f in fins)
            {
                if (counter % 10 == 0) Console.WriteLine(counter.ToString());
                int modi = counter++ % this.numOfEngines;
                if (mergeStreams.ContainsKey(modi))
                {
                    mergeStreams[modi].WriteLine(File.ReadAllText(f.FullName));
                }
                else
                {
                    mergeStreams.Add(modi, new StreamWriter(this.dumpDir + modi.ToString() + "_INDEX.PRO"));
                }
            }

            if (mergeStreams != null)
            {
                foreach (int key in mergeStreams.Keys)
                {
                    if (mergeStreams[key] != null)
                    {
                        mergeStreams[key].Close();
                    }
                }
            }

            //this.LogicEngines[modi].Consult(f.FullName);


        }
    }
}
