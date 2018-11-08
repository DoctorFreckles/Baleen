using System;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BaleenLib
{
    public class AutoGenBaleenSetView
    {
        public class MetaData
        {
            public string DatabaseName = "";	
            public int DBSizeInKB = 0;	
            public string TableName = "";	
            public int TableRows = 0;
            public int TableDataSizeInKB = 0;
            public int TableIndexSizeInKB = 0;
        }
        public static void RunSimple(
            string DBServerConn,
            string DBName,
            string OwnerName,
            string KeystoneTable,
            double percentThreshold,
            string metaDataTablePath,
            bool ignoreThreshold)
        {
            SqlConnection c = null;
            StreamReader sr = null;
            try
            {
                string[] ksParts = KeystoneTable.Split('-');
                string entity = ksParts[0];
                c = new SqlConnection(DBServerConn);
                c.Open();
                sr = new StreamReader(metaDataTablePath);
                sr.ReadLine();
                List<MetaData> mds = new List<MetaData>();
                while (!sr.EndOfStream)
                {
                    string[] data = sr.ReadLine().Split('\t');
                    MetaData md = new MetaData();
                    if (data[0] != null)
                    {
                        try
                        {
                            md.DatabaseName = data[0];
                        }
                        catch { }
                    }
                    if (data[1] != null)
                    {
                        try
                        {
                            md.DBSizeInKB = int.Parse(data[1]);
                        }
                        catch { }
                    }
                    if (data[2] != null)
                    {
                        try
                        {
                            md.TableName = data[2];
                        }
                        catch { }
                    }
                    if (data[3] != null)
                    {
                        try
                        {
                            md.TableRows = int.Parse(data[3]);
                        }
                        catch { }
                    }
                    if (data[4] != null)
                    {
                        try
                        {
                            md.TableDataSizeInKB = int.Parse(data[4]);
                        }
                        catch { }
                    }
                    if (data[5] != null)
                    {
                        try
                        {
                            md.TableIndexSizeInKB = int.Parse(data[5]);
                        }
                        catch { }
                    }
                    mds.Add(md);
                }

                List<MetaData> viewSet = (from m in mds
                                          where m.TableName.Contains(entity + "-")
                                          && m.DatabaseName == DBName
                                          orderby m.TableRows descending
                                          select m).ToList<MetaData>();

                double totalSize = 0;

                foreach (MetaData m in viewSet)
                {
                    totalSize += (double)(m.TableDataSizeInKB + m.TableIndexSizeInKB);
                }

                double sumSize = 0;

                List<MetaData> genSet = new List<MetaData>();

                foreach (MetaData m in viewSet)
                {
                    sumSize += (double)(m.TableDataSizeInKB + m.TableIndexSizeInKB);
                    genSet.Add(m);
                    if ((sumSize / totalSize) >= percentThreshold && !ignoreThreshold)
                    {
                        break;
                    }
                }
                List<MetaData> g2 = (from m in genSet
                                     where m.TableName.ToUpper().Trim() != KeystoneTable.ToUpper().Trim()
                                     orderby m.TableRows ascending
                                     select m).ToList<MetaData>();

                StringBuilder selectPart = new StringBuilder();
                StringBuilder FromJoinPart = new StringBuilder();
                FromJoinPart.Append("FROM " + DBName + "." + OwnerName + ".[" + KeystoneTable + "] " + '\r' + '\n');
                foreach (MetaData m in g2)
                {
                    FromJoinPart.Append("left outer join " + DBName + "." +
                        OwnerName + ".[" + m.TableName + "] on " +
                        DBName + "." + OwnerName + ".[" + KeystoneTable + "].object_key = " +
                        DBName + "." + OwnerName + ".[" + m.TableName + "].object_key" + '\r' + '\n');
                }

                List<MetaData> g3 = (from m in g2
                                     orderby m.TableName ascending
                                     select m).ToList<MetaData>();

                selectPart.Append("SELECT " + '\r' + '\n');
                selectPart.Append(DBName + "." + OwnerName + ".[" + KeystoneTable + "].object_key" + '\r' + '\n');
                selectPart.Append("," + DBName + "." + OwnerName + ".[" + KeystoneTable + "].as_small_text AS [" + ksParts[1] + "]" + '\r' + '\n');
                foreach (MetaData m in g3)
                {
                    string[] fieldParts = m.TableName.Split('-');
                    selectPart.Append("," + DBName + "." + OwnerName + ".[" + m.TableName + "].as_small_text AS [" 
                        + fieldParts[1] + "]"
                        + '\r' + '\n');
                }

                string finalSql = selectPart.ToString() + FromJoinPart.ToString();

                SqlCommand chgCtx = new SqlCommand(@"use [<<DB>>]".Replace("<<DB>>", DBName), c);

                int res = chgCtx.ExecuteNonQuery();

                string sqlCreateView = @"
create view [BVW_<<KS>>]
as

".Replace("<<KS>>", ksParts[0]) + '\r' + '\n' +
 selectPart + FromJoinPart;

                SqlCommand cmd = new SqlCommand(sqlCreateView, c);
                res = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (sr != null)
                {
                    sr.Close();
                }
                if (c != null)
                {
                    c.Close();
                }
            }
        }
    }
}
