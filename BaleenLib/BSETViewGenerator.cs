using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BaleenLib
{
    public class BSETViewGenerator
    {
        public static void Run2()
        {
            StreamWriter sw = null;
            try
            {
                string curDir = Directory.GetCurrentDirectory() + "\\";
                string saveDir = curDir + "BSETViewGenratorSimpleMeta\\";
                if (!Directory.Exists(saveDir))
                {
                    Directory.CreateDirectory(saveDir);
                }
                sw = new StreamWriter(saveDir + "BSET_VIEWS.SQL");
                sw.WriteLine("USE BAL_VIEWS;");
                sw.WriteLine("GO");
                string[] lines = File.ReadAllLines("SIMPLE_META.txt");
                string[] hdr = lines[0].Split('\t');
                List<Dictionary<string, string>> recs =
                    new List<Dictionary<string, string>>();
                for (int i = 1; i < lines.Length; i++)
                {
                    string[] dat = lines[i].Split('\t');
                    if (dat.Length == hdr.Length)
                    {
                        Dictionary<string, string> rec = new Dictionary<string, string>();
                        for (int k = 0; k < hdr.Length; k++)
                        {
                            rec[hdr[k]] = dat[k];
                        }
                        recs.Add(rec);
                    }
                    else
                    {
                        throw new Exception("Hdr/Dat missmatch for line " + i.ToString());
                    }
                }

                List<Dictionary<string, string>> recs1 = (from r in recs
                                                          where ! String.IsNullOrEmpty(r["ORDER"]) 
                                                          select r).ToList<Dictionary<string, string>>();

                List<Dictionary<string, string>> recs2 = (from r in recs1
                                                          orderby r["DATABASE_NAME"] ascending,
                                                          r["OBJECT_NAME"] ascending,
                                                          long.Parse(r["ORDER"]) ascending
                                                          select r).ToList<Dictionary<string, string>>();

                string dbk = "";

                dbk = recs2[0]["DATABASE_NAME"] + "-" + recs2[0]["OBJECT_NAME"];

                string lck = "";

                StringBuilder joinList = new StringBuilder();

                List<string> selectList = new List<string>();

                int t = 0;

                for (int m = 0; m < recs2.Count; m++)
                {
                    lck = recs2[m]["DATABASE_NAME"] + "-" + recs2[m]["OBJECT_NAME"];
                    string fldName = recs2[m]["PREDICATE_NAME"] + "_" + recs2[m]["TYPE_SUFFIX"];
                    if (lck != dbk)
                    {
                        Console.WriteLine("SAVING: " + dbk);
                        StringBuilder viewSql = new StringBuilder();
                        viewSql.Append(("CREATE VIEW [BVW_" + dbk + "]")
                            .Replace("-BSET_","-")
                            .Replace("BVW_BAL_","BVW_")
                            ).Append('\r').Append('\n');
                        viewSql.Append("AS").Append('\r').Append('\n');
                        viewSql.Append("SELECT ").Append('\r').Append('\n');

                        List<string> l2 = (from s in selectList
                                           orderby s ascending
                                           select s).ToList<string>();

                        StringBuilder selb = new StringBuilder();
                        foreach (string s in l2)
                        {
                            string[] parts = s.Split('^');
                            selb.Append(parts[1]);
                        }
                        viewSql.Append(selb.ToString());
                        viewSql.Append("FROM ").Append('\r').Append('\n');
                        viewSql.Append(joinList.ToString().Trim()).Append(";").Append('\r').Append('\n');
                        viewSql.Append("GO").Append('\r').Append('\n');
                        viewSql.Append("---------------").Append('\r').Append('\n');
                        sw.WriteLine(viewSql.ToString());
                        t = 0;
                        selectList = new List<string>();
                        joinList = new StringBuilder();
                        dbk = lck;
                    }
                    t++;
                    if (t == 1)
                    {
                        selectList.Add("aaaaaaaaaa^t1.[key] as OBJECT_KEY " + '\r' + '\n');
                        selectList.Add("aaaaaaaaab^,t1.[val] as " + fldName + '\r' + '\n');
                        joinList.Append("[");
                        joinList.Append(recs2[m]["DATABASE_NAME"]);
                        joinList.Append("].dbo.[");
                        joinList.Append(recs2[m]["TABLE_NAME"]);
                        joinList.Append("]");
                        joinList.Append(" t").Append(t.ToString());
                        joinList.Append('\r').Append('\n');
                    }
                    else
                    {
                        selectList.Add(fldName + "^,t" + t.ToString() + ".[val] as " + fldName + '\r' + '\n');
                        joinList.Append("LEFT OUTER JOIN ");
                        joinList.Append("[");
                        joinList.Append(recs2[m]["DATABASE_NAME"]);
                        joinList.Append("].dbo.[");
                        joinList.Append(recs2[m]["TABLE_NAME"]);
                        joinList.Append("] ");
                        joinList.Append(" t").Append(t.ToString());
                        joinList.Append(" ON ");
                        joinList.Append(" t").Append(t.ToString());
                        joinList.Append(".[key] = t1.[key]");
                        joinList.Append('\r').Append('\n');
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (sw != null)
                {
                    sw.Close();
                }
            }
        }
        public static void Run()
        {
            StreamWriter sw = null;
            try
            {
                string curDir = Directory.GetCurrentDirectory() + "\\";
                string saveDir = curDir + "BSETViewGenrator\\";
                if (!Directory.Exists(saveDir))
                {
                    Directory.CreateDirectory(saveDir);
                }
                sw = new StreamWriter(saveDir + "BSET_VIEWS.SQL");
                sw.WriteLine("USE BAL_VIEWS;");
                sw.WriteLine("GO");
                string[] lines = File.ReadAllLines("BSET_LIST.txt");
                string[] hdr = lines[0].Split('\t');
                List<Dictionary<string, string>> recs =
                    new List<Dictionary<string, string>>();
                for (int i = 1; i < lines.Length; i++)
                {
                    string[] dat = lines[i].Split('\t');
                    if (dat.Length == hdr.Length)
                    {
                        Dictionary<string, string> rec = new Dictionary<string, string>();
                        for (int k = 0; k < hdr.Length; k++)
                        {
                            rec[hdr[k]] = dat[k];
                        }
                        recs.Add(rec);
                    }
                    else
                    {
                        throw new Exception("Hdr/Dat missmatch for line " + i.ToString());
                    }
                }

                List<Dictionary<string, string>> recs2 = (from r in recs
                                                          orderby r["DATABASE_NAME"] ascending,
                                                          r["OBJECT_NAME"] ascending,
                                                          long.Parse(r["TOTAL_CARDINALITY"]) descending
                                                          where r["INCLUDE_IN_VIEW"] == "1"
                                                          select r).ToList<Dictionary<string, string>>();

                string dbk = "";

                dbk = recs2[0]["DATABASE_NAME"] + "-" + recs2[0]["OBJECT_NAME"];

                string lck = "";

                StringBuilder joinList = new StringBuilder();

                List<string> selectList = new List<string>();

                int t = 0;

                for (int m = 0; m < recs2.Count; m++)
                {
                    lck = recs2[m]["DATABASE_NAME"] + "-" + recs2[m]["OBJECT_NAME"];
                    string fldName = recs2[m]["PREDICATE_NAME"] + "_" + recs2[m]["TYPE_SUFFIX"];
                    if (lck != dbk)
                    {
                        Console.WriteLine("SAVING: " + dbk);
                        StringBuilder viewSql = new StringBuilder();
                        viewSql.Append("CREATE VIEW [BVW_" + dbk + "]").Append('\r').Append('\n');
                        viewSql.Append("AS").Append('\r').Append('\n');
                        viewSql.Append("SELECT ").Append('\r').Append('\n');

                        List<string> l2 = (from s in selectList
                                           orderby s ascending
                                           select s).ToList<string>();

                        StringBuilder selb = new StringBuilder();
                        foreach (string s in l2)
                        {
                            string[] parts = s.Split('^');
                            selb.Append(parts[1]);
                        }
                        viewSql.Append(selb.ToString());
                        viewSql.Append("FROM ").Append('\r').Append('\n');
                        viewSql.Append(joinList.ToString().Trim()).Append(";").Append('\r').Append('\n');
                        viewSql.Append("GO").Append('\r').Append('\n');
                        viewSql.Append("---------------").Append('\r').Append('\n');
                        sw.WriteLine(viewSql.ToString());
                        t = 0;
                        selectList = new List<string>();
                        joinList = new StringBuilder();
                        dbk = lck;
                    }
                    t++;
                    if (t == 1)
                    {
                        selectList.Add("aaaaaaaaaa^t1.[key] as OBJECT_KEY " + '\r' + '\n');
                        selectList.Add("aaaaaaaaab^,t1.[val] as " + fldName + '\r' + '\n');
                        joinList.Append("[");
                        joinList.Append(recs2[m]["DATABASE_NAME"]);
                        joinList.Append("].dbo.[");
                        joinList.Append(recs2[m]["TABLE_NAME"]);
                        joinList.Append("]");
                        joinList.Append(" t").Append(t.ToString());
                        joinList.Append('\r').Append('\n');
                    }
                    else
                    {
                        selectList.Add(fldName + "^,t" + t.ToString() + ".[val] as " + fldName + '\r' + '\n');
                        joinList.Append("LEFT OUTER JOIN ");
                        joinList.Append("[");
                        joinList.Append(recs2[m]["DATABASE_NAME"]);
                        joinList.Append("].dbo.[");
                        joinList.Append(recs2[m]["TABLE_NAME"]);
                        joinList.Append("] ");
                        joinList.Append(" t").Append(t.ToString());
                        joinList.Append(" ON ");
                        joinList.Append(" t").Append(t.ToString());
                        joinList.Append(".[key] = t1.[key]");
                        joinList.Append('\r').Append('\n');
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (sw != null)
                {
                    sw.Close();
                }
            }
        }
        public static void Run(int firstNFields)
        {
            StreamWriter sw = null;
            try
            {
                string curDir = Directory.GetCurrentDirectory() + "\\";
                string saveDir = curDir + "BSETViewGenrator\\";
                if (!Directory.Exists(saveDir))
                {
                    Directory.CreateDirectory(saveDir);
                }
                sw = new StreamWriter(saveDir + "BSET_VIEWS.SQL");
                sw.WriteLine("USE BAL_VIEWS;");
                sw.WriteLine("GO");
                string[] lines = File.ReadAllLines("BSET_LIST.txt");
                string[] hdr = lines[0].Split('\t');
                List<Dictionary<string, string>> recs =
                    new List<Dictionary<string, string>>();
                for (int i = 1; i < lines.Length; i++)
                {
                    string[] dat = lines[i].Split('\t');
                    if (dat.Length == hdr.Length)
                    {
                        Dictionary<string, string> rec = new Dictionary<string, string>();
                        for (int k = 0; k < hdr.Length; k++)
                        {
                            rec[hdr[k]] = dat[k];
                        }
                        recs.Add(rec);
                    }
                    else
                    {
                        throw new Exception("Hdr/Dat missmatch for line " + i.ToString());
                    }
                }

                List<Dictionary<string, string>> recs2 = (from r in recs
                                                          orderby r["DATABASE_NAME"] ascending,
                                                          r["OBJECT_NAME"] ascending,
                                                          long.Parse(r["TOTAL_CARDINALITY"]) descending
                                                          select r).ToList<Dictionary<string, string>>();

                string dbk = "";

                dbk = recs2[0]["DATABASE_NAME"] + "-" + recs2[0]["OBJECT_NAME"];

                string lck = "";

                StringBuilder joinList = new StringBuilder();

                List<string> selectList = new List<string>();

                int t = 0;

                for (int m = 0; m < recs2.Count; m++)
                {
                    lck = recs2[m]["DATABASE_NAME"] + "-" + recs2[m]["OBJECT_NAME"];
                    string fldName = recs2[m]["PREDICATE_NAME"] + "_" + recs2[m]["TYPE_SUFFIX"];
                    if (lck != dbk)
                    {
                        Console.WriteLine("SAVING: " + dbk);
                        StringBuilder viewSql = new StringBuilder();
                        viewSql.Append("CREATE VIEW [BVW_" + dbk + "]").Append('\r').Append('\n');
                        viewSql.Append("AS").Append('\r').Append('\n');
                        viewSql.Append("SELECT ").Append('\r').Append('\n');
                        StringBuilder selb = new StringBuilder();
                        foreach (string s in selectList)
                        {
                            selb.Append(s);
                        }
                        viewSql.Append(selb.ToString());
                        viewSql.Append("FROM ").Append('\r').Append('\n');
                        viewSql.Append(joinList.ToString().Trim()).Append(";").Append('\r').Append('\n');
                        viewSql.Append("GO").Append('\r').Append('\n');
                        viewSql.Append("---------------").Append('\r').Append('\n');
                        sw.WriteLine(viewSql.ToString());
                        t = 0;
                        selectList = new List<string>();
                        joinList = new StringBuilder();
                        dbk = lck;
                    }
                    t++;
                    if (t == 1)
                    {
                        selectList.Add("t1.[key] as OBJECT_KEY " + '\r' + '\n');
                        selectList.Add(",t1.[val] as " + fldName + '\r' + '\n');
                        joinList.Append("[");
                        joinList.Append(recs2[m]["DATABASE_NAME"]);
                        joinList.Append("].dbo.[");
                        joinList.Append(recs2[m]["TABLE_NAME"]);
                        joinList.Append("]");
                        joinList.Append(" t").Append(t.ToString());
                        joinList.Append('\r').Append('\n');
                    }
                    else if(t < firstNFields)
                    {
                        selectList.Add(",t" + t.ToString() + ".[val] as " + fldName + '\r' + '\n');
                        joinList.Append("LEFT OUTER JOIN ");
                        joinList.Append("[");
                        joinList.Append(recs2[m]["DATABASE_NAME"]);
                        joinList.Append("].dbo.[");
                        joinList.Append(recs2[m]["TABLE_NAME"]);
                        joinList.Append("] ");
                        joinList.Append(" t").Append(t.ToString());
                        joinList.Append(" ON ");
                        joinList.Append(" t").Append(t.ToString());
                        joinList.Append(".[key] = t1.[key]");
                        joinList.Append('\r').Append('\n');
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (sw != null)
                {
                    sw.Close();
                }
            }
        }
    }
}
