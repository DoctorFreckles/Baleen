using System;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BaleenLib
{
    public class GenerateBaleenMetaData
    {
        public static void Run(string ServerConnection, string outputFile, string dbPrefix, string tablePrefix)
        {
            StreamWriter sw = null;
            SqlConnection c = null;
            try
            {
                c = new SqlConnection(ServerConnection);
                c.Open();
                string showDatabases = @"EXEC sp_databases";
                DataTable dbs = new DataTable("DB");
                SqlDataAdapter sda = null;
                sda = new SqlDataAdapter(showDatabases, c);
                sda.Fill(dbs);
                if (dbs.Rows.Count < 1) return;
                sw = new StreamWriter(outputFile);
                sw.Write("Database Name");
                sw.Write('\t');
                sw.Write("DB Size in KB");
                sw.Write('\t');
                sw.Write("Table Name");
                sw.Write('\t');
                sw.Write("Table Rows");
                sw.Write('\t');
                sw.Write("Data Size (table) in KB");
                sw.Write('\t');
                sw.WriteLine("Index Size (table) in KB");
                foreach (DataRow dr in dbs.Rows)
                {
                    string dbName = dr[0].ToString();
                    string dbSize = dr[1].ToString();
                    if (!dbName.ToLower().Contains(dbPrefix.ToLower()))
                    {
                        continue;
                    }
                    SqlDataAdapter sda2 = new SqlDataAdapter(@"
use [<<DB>>]
SELECT * FROM information_schema.tables
where TABLE_NAME like '<<PREFIX>>%'
".Replace("<<PREFIX>>",tablePrefix).Replace("<<DB>>",dbName), c);

                    DataTable tbls = new DataTable("TB");
                    sda2.Fill(tbls);
                    if (tbls.Rows.Count < 1) continue;
                    foreach (DataRow dr2 in tbls.Rows)
                    {
                        string tbl = dr2[2].ToString();
                        Console.WriteLine(tbl);
                        SqlDataAdapter sda3 = new SqlDataAdapter(@"
use [<<DB>>]
EXEC sp_spaceused N'<<TBL>>'
".Replace("<<TBL>>", tbl).Replace("<<DB>>", dbName), c);

                        DataTable metrics = new DataTable();
                        sda3.Fill(metrics);
                        if (metrics.Rows.Count < 1) continue;
                        DataRow record1 = metrics.Rows[0];
                        string rows = record1[1].ToString().Replace("KB","").Trim();
                        string data = record1[3].ToString().Replace("KB","").Trim();
                        string indx = record1[4].ToString().Replace("KB","").Trim();
                        sw.Write(dbName);
                        sw.Write('\t');
                        sw.Write(dbSize.Replace("KB", "").Trim());
                        sw.Write('\t');
                        sw.Write(tbl);
                        sw.Write('\t');
                        sw.Write(rows);
                        sw.Write('\t');
                        sw.Write(data);
                        sw.Write('\t');
                        sw.WriteLine(indx);
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (sw != null) sw.Close();
                if (c != null) c.Close();
            }
        }
    }
}
