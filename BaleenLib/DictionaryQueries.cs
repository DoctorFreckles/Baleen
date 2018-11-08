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
    public class DictionaryQueries
    {
        private static Regex CleanToks = new Regex(@"\W+", RegexOptions.IgnoreCase | RegexOptions.Compiled);
        public static DataTable GetProviders(string query, string dbServerConnect)
        {
            string qry = query.Trim();
            if (String.IsNullOrEmpty(qry)) return null;
            if (qry.Length < 5) return null;
            string[] parts1 = CleanToks.Split(qry);
            List<string> parts2 = new List<string>();
            foreach (string p in parts1)
            {
                string p2 = p.Trim();
                if (p2.Length < 1) continue;
                parts2.Add(p2);
            }
            if (parts2 == null || parts2.Count < 1) return null;
            string whereClause = @"
(type_value like '%<<VAL>>%' and LEN(type_value) < <<MIN>>)

";
            StringBuilder sqry = new StringBuilder();
            string qt = parts2[0];
            int min = qt.Length + 2;
            string wc = whereClause
                .Replace("<<VAL>>", qt)
                .Replace("<<MIN>>", min.ToString());
            sqry.Append(wc);
            for (int i = 0; i < parts2.Count; i++)
            {
                sqry.Append(" OR ");
                qt = parts2[i];
                min = qt.Length + 2;
                wc = whereClause
                .Replace("<<VAL>>", qt)
                .Replace("<<MIN>>", min.ToString());
                sqry.Append(wc);
            }



            SqlConnection c = null;
            try
            {
                string sqlCheckData = @"
select * from dndx_npi_<<DAT>>.dbo.dict_npi_<<TAB>>
";
                for (int i = 1; i < 10; i++)
                {
                    Console.WriteLine(i.ToString());
                    int db = 0;
                    if (i <= 3) db = 1;
                    if (i > 3 && i <= 6) db = 2;
                    if (i > 6 && i <= 9) db = 3;
                    string sql = sqlCheckData
                        .Replace("<<DAT>>", db.ToString())
                        .Replace("<<TAB>>", i.ToString());

                }
                return null;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.Write(ex.Message);
                return null;
            }
            finally
            {
                if (c != null) c.Close();
            }
        }
    }
}
