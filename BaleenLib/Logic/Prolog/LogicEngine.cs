using System;
using System.Diagnostics;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;

namespace BaleenLib.Logic.Prolog
{
    public class LogicEXE
    {
        public Process p = null;
        public int PID = -999;
        private string _dumpDir;
        private string _plcon;
        private int _timeOut;
        private string logicServiceID = "";
        public string ServiceID
        {
            get
            {
                return this.logicServiceID;
            }
        }
        public LogicEXE(string dumpDir, string plCon, int timeoutSeconds)
        {
            this.logicServiceID = Guid.NewGuid().ToString();
            this._timeOut = timeoutSeconds * 1000;
            this.p = new Process();
            this.p.StartInfo.FileName = plCon;
            this.p.StartInfo.RedirectStandardInput = true;
            this.p.StartInfo.UseShellExecute = false;
            this.p.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
            this.p.StartInfo.CreateNoWindow = true;
            this._dumpDir = dumpDir;
            this._plcon = plCon;
            this.p.Start();
            this.PID = this.p.Id;
        }
        public string ReStart()
        {
            this.p = new Process();
            this.p.StartInfo.FileName = this._plcon;
            this.p.StartInfo.RedirectStandardInput = true;
            this.p.StartInfo.UseShellExecute = false;
            this.p.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
            this.p.StartInfo.CreateNoWindow = true;
            this.p.Start();
            this.PID = this.p.Id;
            return "Restarted service.";
        }
        public void Write(string statement)
        {
            this.p.StandardInput.WriteLine(statement);
        }
        public string Stop()
        {
            this.p.Close();
            return "Process Stopped.";
        }
        public string Assert(string query)
        {
            this.Write("assert(" + query + ").");
            return "Assert performed.";
        }
        public string Call(string execString)
        {
            execString = execString.Replace('.',' ');
            string sres = Guid.NewGuid().ToString();
            Write("tell('" + this._dumpDir.Replace('\\', '/') + sres + "').");
            this.Write("call(" + execString + ") -> write('Call Succeeded') ; write('Call Failed').");
            Write("told.");
            string rstr = string.Empty;
            rstr = SpinAndWaitRead(this._dumpDir + sres);
            return rstr;
        }
        public void Consult(string file)
        {
            this.Write("consult('" + file.Replace('\\', '/') + "').");
        }
        public string Save(string fileNamePath)
        {
            Write("tell('" + fileNamePath.Replace("\\","/") + "').");
            Write("listing.");
            Write("told.");
            return "Save Accomplished";
        }
        public bool IsTrue(string query)
        {
            query = query.Replace('.', ' ');
            StringBuilder sb = new StringBuilder();
            Hashtable ht = new Hashtable(20);
            bool hasVariables = false;
            string[] vars = GetTokens(query);
            foreach (string s in vars)
            {
                if (s.Trim().Length > 0)
                {
                    char[] carr = s.ToCharArray();

                    if (Char.IsUpper(carr[0]))
                    {
                        string tmp = s.Trim();

                        if (!ht.Contains(tmp))
                        {
                            ht[tmp] = tmp;
                            sb.Append(" " + s);
                        }
                        hasVariables = true;
                    }
                }
            }
            if (hasVariables) return false;
            string sres = Guid.NewGuid().ToString();
            Write("tell('" + this._dumpDir.Replace('\\', '/') + sres + "').");
            Write("(" + query + ") -> write('True') ; write('False').");
            Write("told.");
            string rstr = string.Empty;
            rstr = SpinAndWaitRead(this._dumpDir + sres);
            if (rstr.Trim().Length < 4) return false;
            bool result = false;
            try
            {
                result = bool.Parse(rstr);
                return result;
            }
            catch
            {
                return false;
            }
        }
        public string Query(string query, bool distinctResults)
        {
            query = query.Replace('.',' ');
            StringBuilder sb = new StringBuilder();
            Hashtable ht = new Hashtable(20);
            bool hasVariables = false;
            string[] vars = GetTokens(query);
            foreach (string s in vars)
            {
                if (s.Trim().Length > 0)
                {
                    string tmp1 = s.Trim();

                    char[] carr = tmp1.ToCharArray();

                    if (Char.IsUpper(carr[0]))
                    {
                        string tmp = s.Trim();

                        if (!ht.Contains(tmp))
                        {
                            ht[tmp] = tmp;
                            sb.Append(" " + s);
                        }
                        hasVariables = true;
                    }
                }
            }
            string sres = Guid.NewGuid().ToString();
            Write("tell('" + this._dumpDir.Replace('\\', '/') + sres + "').");
            if (hasVariables)
            {
                if (distinctResults)
                {
                    Write("setof((" + sb.ToString().Trim().Replace(" ", ",") + ") ,(" + query + "),Z),write(Z),fail.");
                }
                else
                {
                    string tres = "findall((" + sb.ToString().Trim().Replace(" ", ",") + ") ,(" + query + "),Z),write(Z),fail.";
                    Write(tres);
                }
            }
            else
            {
                Write(query + ".");
            }            
            Write("told.");
            string rstr = string.Empty;
            rstr = SpinAndWaitRead(this._dumpDir + sres);
            return rstr;
        }       
        public string Listing()
        {
            string sres = Guid.NewGuid().ToString();
            Write("tell('" + this._dumpDir.Replace('\\', '/') + sres + "').");
            Write("listing.");
            Write("told.");
            string rstr = string.Empty;
            rstr = SpinAndWaitRead(this._dumpDir + sres);
            return rstr;
        }
        private string SpinAndWaitRead(string fileName)
        {
            StreamReader sr = null;
            string rstr = string.Empty;
            int counter = 0;
            bool done = false;
            while (!done)
            {
                try
                {
                    if (File.Exists(fileName))
                    {
                        sr = new StreamReader(fileName);
                        rstr = sr.ReadToEnd();
                        sr.Close();
                        done = true;
                    }
                }
                catch
                {
                    continue;
                }
                counter++;
                System.Threading.Thread.Sleep(1);
                if (counter == this._timeOut) break;
            }
            try
            {
                File.Delete(fileName);
            }
            catch { }
            return rstr;
        }
        private string[] GetTokens(string prologStatement)
        {
            string[] vars = Regex.Split(prologStatement, @"[,)(=;+:%$@~^/\-><@&*!]");
            return vars;
        }
    }
}