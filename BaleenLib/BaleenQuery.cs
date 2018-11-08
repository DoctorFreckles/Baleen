using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Configuration;

namespace BaleenLib
{
    public enum FileType
    {
        csharp,
        prolog,
        python,
        powershell,
        tab,
        txt,
        csv,
        xml,
        other
    }
    public class DBMeta
    {
        public string DBName = "";
        public string FileName = "";
        public long FirstLine = 0;
        public DateTime? MinLoadDate = null;
        public DateTime? MaxLoadDate = null;
        public long TotalLines = 0;
        public string HeaderRecord = "";
        public FileType fileType
        {
            get
            {
                if (String.IsNullOrEmpty(this.FileName))
                {
                    return FileType.other;
                }
                else if (this.FileName.Trim().ToLower().Contains(".tab"))
                {
                    return FileType.tab;
                }
                else if (this.FileName.Trim().ToLower().Contains(".txt"))
                {
                    return FileType.txt;
                }
                else if (this.FileName.Trim().ToLower().Contains(".cs"))
                {
                    return FileType.csharp;
                }
                else if (this.FileName.Trim().ToLower().Contains(".pro"))
                {
                    return FileType.prolog;
                }
                else if (this.FileName.Trim().ToLower().Contains(".csv"))
                {
                    return FileType.csv;
                }
                else if (this.FileName.Trim().ToLower().Contains(".xml"))
                {
                    return FileType.xml;
                }
                else if (this.FileName.Trim().ToLower().Contains(".py"))
                {
                    return FileType.python;
                }
                else if (this.FileName.Trim().ToLower().Contains(".ps1"))
                {
                    return FileType.powershell;
                }
                else
                {
                    return FileType.other;
                }
            }
        }
        public string Subject
        {
            get
            {
                return DBName.ToUpper().Trim().Replace("BAL_", "").Replace("_", " ");
            }
        }
    }
    public class BaleenQuery
    {
        private static string sqlMeta = @"
SELECT [file_name]
      ,[first_line]
      ,[min_load_date]
      ,[max_load_date]
      ,[total_lines]
      ,[header_record]
FROM [<<DB>>].[dbo].[vw_file_info_summary]
";
        private static string sqlAllDB = @"
SELECT name
FROM sys.databases
WHERE 
name like 'bal_%'
";
        private static DataTable baleenDB = null;
        private static List<string> AvailableSubjects = null;
        private static List<DBMeta> baleenMeta = null;
        public static void Init(string dbServerConnect)
        {
            Console.WriteLine("Baleen Query Start Up");
            SqlConnection c = null;
            try
            {
                c = new SqlConnection(dbServerConnect);
                c.Open();
                SqlDataAdapter sda = new SqlDataAdapter(sqlAllDB, c);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                baleenDB = dt;
                baleenMeta = new List<DBMeta>();
                foreach (DataRow dr in dt.Rows)
                {
                    string db = dr[0].ToString();
                    Console.WriteLine(db);
                    string sql = sqlMeta.Replace("<<DB>>", db);
                    DataTable dtm = new DataTable();
                    sda = new SqlDataAdapter(sql, c);
                    sda.Fill(dtm);
                    foreach (DataRow drm in dtm.Rows)
                    {
                        DBMeta dm = new DBMeta();
                        dm.DBName = db;
                        try
                        {
                            dm.FileName = drm[0].ToString();
                        }
                        catch { }
                        try
                        {
                            dm.FirstLine = long.Parse(drm[1].ToString());
                        }
                        catch { }
                        try
                        {
                            dm.MinLoadDate = DateTime.Parse(drm[2].ToString());
                        }
                        catch { }
                        try
                        {
                            dm.MaxLoadDate = DateTime.Parse(drm[3].ToString());
                        }
                        catch { }
                        try
                        {
                            dm.TotalLines = long.Parse(drm[4].ToString());
                        }
                        catch { }
                        try
                        {
                            dm.HeaderRecord = drm[5].ToString();
                        }
                        catch { }
                        baleenMeta.Add(dm);
                    }
                }
                Dictionary<string, string> subs = new Dictionary<string, string>();
                foreach (DBMeta dm in baleenMeta)
                {
                    subs[dm.Subject] = "";
                }
                AvailableSubjects = subs.Keys.ToList<string>();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (c != null)
                {
                    c.Close();
                }
            }
        }
        public static List<DBMeta> GetSubjectInfo(string subject)
        {
            if (subject.ToUpper().Trim() == "ALL")
            {
                return (from dm in baleenMeta
                        orderby dm.DBName ascending
                        select dm).ToList<DBMeta>();
            }
            else
            {
                return (from dm in baleenMeta
                        where dm.Subject == subject.ToUpper().Trim()
                        orderby dm.DBName ascending
                        select dm).ToList<DBMeta>();
            }
        }
        public static DataTable GetAvailableDBs()
        {
            return baleenDB;
        }
        public static List<string> GetSubjects()
        {
            return AvailableSubjects;
        }
        public static DataTable GetDT(int depth, DBMeta meta, DataTable data)
        {
            string dtTablePrefix = "depth_" + depth.ToString();
            DataTable dt = new DataTable(dtTablePrefix + meta.FileName.Replace(".", "_"));
            dt.Columns.Add("FileType");
            dt.Columns.Add("DBName");
            dt.Columns.Add("FileName");
            dt.Columns.Add("LineNo");
            dt.Columns.Add("MatchScore");
            if (meta.fileType == FileType.csv)
            {
                string[] flds = meta.HeaderRecord.Split(',');
                foreach (string f in flds)
                {
                    dt.Columns.Add(f);
                }
                foreach (DataRow dr in data.Rows)
                {
                    if (dr["data_value"] == null) continue;
                    string dv = dr["data_value"].ToString();
                    string[] dva = dv.Split(',');
                    DataRow drt = dt.NewRow();
                    drt["FileType"] = "CSV";
                    drt["DBName"] = meta.DBName;
                    drt["FileName"] = meta.FileName;
                    drt["LineNo"] = dr["line_number"].ToString();
                    drt["MatchScore"] = dr["MatchScore"].ToString();
                    for (int i = 0; i < flds.Length; i++)
                    {
                        if (i >= dva.Length) break;
                        drt[flds[i]] = dva[i];
                    }
                    dt.Rows.Add(drt);
                }
            }
            else if (meta.fileType == FileType.tab)
            {
                string[] flds = meta.HeaderRecord.Split('\t');
                foreach (string f in flds)
                {
                    dt.Columns.Add(f);
                }
                foreach (DataRow dr in data.Rows)
                {
                    if (dr["data_value"] == null) continue;
                    string dv = dr["data_value"].ToString();
                    string[] dva = dv.Split('\t');
                    DataRow drt = dt.NewRow();
                    drt["FileType"] = "TAB";
                    drt["DBName"] = meta.DBName;
                    drt["FileName"] = meta.FileName;
                    drt["LineNo"] = dr["line_number"].ToString();
                    drt["MatchScore"] = dr["MatchScore"].ToString();
                    for (int i = 0; i < flds.Length; i++)
                    {
                        if (i >= dva.Length) break;
                        drt[flds[i]] = dva[i];
                    }
                    dt.Rows.Add(drt);
                }
            }
            else
            {
                dt.Columns.Add("FirstLineData");
                dt.Columns.Add("Text");
                foreach (DataRow dr in data.Rows)
                {
                    if (dr["data_value"] == null) continue;
                    string dv = dr["data_value"].ToString();
                    DataRow drt = dt.NewRow();
                    drt["FileType"] = "TAB";
                    drt["DBName"] = meta.DBName;
                    drt["FileName"] = meta.FileName;
                    drt["LineNo"] = dr["line_number"].ToString();
                    drt["MatchScore"] = dr["MatchScore"].ToString();
                    drt["FirstLineData"] = meta.HeaderRecord;
                    drt["Text"] = dv;
                    dt.Rows.Add(drt);
                }
            }
            return dt;
        }
        public static DataSet Query(List<string> keyWords, string subject, string dbServerConnect)
        {
            return Query(keyWords, 1, subject, dbServerConnect);
        }
        public static DataSet Query(List<string> keyWords, int depth, string subject, string dbServerConnect)
        {
            SqlConnection c = null;
            try
            {
                c = new SqlConnection(dbServerConnect);
                c.Open();
                Dictionary<string, int> tokensQueried = new Dictionary<string, int>();
                DataSet dtst = new DataSet("QueryResult");
                List<string> currentKW = keyWords;
                for (int i = 0; i < depth; i++)
                {
                    int kwAdd = 0;
                    List<DBMeta> filesToSearch = GetSubjectInfo(subject);
                    StringBuilder queryTemplate = new StringBuilder();

                    string sqlGetData = @"
SELECT [file_name]
      ,[line_number]
      ,[user_name]
      ,[load_date]
      ,[custom_index]
      ,[data_value]
FROM [<<DB>>].[dbo].[fact_small]
where file_name = '<<FN>>'
and
(
<<WC>>
)
and
line_number > <<FL>>
union
SELECT [file_name]
      ,[line_number]
      ,[user_name]
      ,[load_date]
      ,[custom_index]
      ,cast([data_value] as varchar(max)) as data_value
FROM [<<DB>>].[dbo].[fact_large]
where file_name = '<<FN>>'
and
(
<<WC>>
)
and
line_number > <<FL>>
";
                    foreach (string kw in currentKW)
                    {
                        string k = kw.Trim();
                        if (k.Length < 1) continue;
                        if (tokensQueried.ContainsKey(k))
                        {
                            tokensQueried[k]++;
                            continue;
                        }
                        kwAdd++;
                        string wc = "data_value like '%" + k.Replace("'", "''") + "%'";
                        string qt = sqlGetData.Replace("<<WC>>", wc);
                        queryTemplate.Append(qt);
                        queryTemplate.Append("<^>");
                        tokensQueried[k] = 1;
                    }

                    if (kwAdd > 0)
                    {
                        string wc2 = queryTemplate.ToString().Substring(0, queryTemplate.Length - 3);
                        wc2 = wc2.Replace("<^>", " UNION ");
                        foreach (DBMeta dm in filesToSearch)
                        {
                            Console.WriteLine(dm.FileName);

                            string qrySql = wc2
                                .Replace("<<FL>>", dm.FirstLine.ToString())
                                .Replace("<<DB>>", dm.DBName)
                                .Replace("<<FN>>", dm.FileName);

                            string qrySql2 = @"
SELECT t.[file_name]
      ,t.[line_number]
      ,t.[user_name]
      ,t.[load_date]
      ,t.[custom_index]
      ,t.[data_value]
      ,count(*) as MatchScore
from 
(
" + qrySql + @"
) t
group by 
t.[file_name]
,t.[line_number]
,t.[user_name]
,t.[load_date]
,t.[custom_index]
,t.[data_value]

";

                            SqlCommand cmd = new SqlCommand(qrySql2, c);
                            cmd.CommandTimeout = 1000;
                            SqlDataAdapter da = new SqlDataAdapter(cmd);
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                            if (dt.Rows.Count < 1) continue;
                            DataTable addDT = GetDT(depth, dm, dt);
                            dtst.Tables.Add(addDT);
                            foreach (DataRow dr in dt.Rows)
                            {
                                if (dr["data_value"] != null)
                                {
                                    string s = dr["data_value"].ToString();
                                    currentKW = s.Split(new char[] { ',', ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries).ToList<string>();
                                }
                            }
                        }
                    }
                }
                return dtst;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return null;
            }
            finally
            {
                if (c != null) c.Close();
            }
        }
    }
}
