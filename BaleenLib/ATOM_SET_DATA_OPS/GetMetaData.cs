using System;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BaleenLib.ATOM_SET_DATA_OPS
{
    public class GetMetaData
    {
        private DataTable cache = null;
        private string ConnString = "";
        public GetMetaData(string dbServerConnString)
        {
            ConnString = dbServerConnString;
            
        }
        private DataTable MetaCache
        {
            get
            {
                return this.cache;
            }
            set
            {
                this.cache = value;
            }
        }
        public DataTable Run(bool grabCacheIfAvailable)
        {
            if (grabCacheIfAvailable && cache != null)
            {
                return cache;
            }
            DataTable dt = new DataTable("BALEEN_META");
            dt.Columns.Add(new DataColumn("DATABASE_NAME", typeof(System.String)));
            dt.Columns.Add(new DataColumn("TABLE_NAME", typeof(System.String)));
            dt.Columns.Add(new DataColumn("DATA_TYPE", typeof(System.String)));
            dt.Columns.Add(new DataColumn("CHARACTER_MAXIMUM_LENGTH", typeof(System.Int32)));
            dt.Columns.Add(new DataColumn("CHARACTER_OCTET_LENGTH", typeof(System.Int32)));
            dt.Columns.Add(new DataColumn("NUMERIC_PRECISION", typeof(System.Int32)));
            dt.Columns.Add(new DataColumn("CHARACTER_SET_NAME", typeof(System.String)));
            dt.Columns.Add(new DataColumn("COLLATION_NAME", typeof(System.String)));
            dt.Columns.Add(new DataColumn("TOTAL_CARDINALITY", typeof(System.Int64)));
            dt.Columns.Add(new DataColumn("UNIQUE_VALUE_CARDINALITY", typeof(System.Int64)));
            dt.Columns.Add(new DataColumn("UNIQUENESS_SCORE", typeof(System.Double)));           
            string sqlDB = @"
SELECT name
FROM sys.databases
where name like 'BAL_%'
";
            string sqlMeta = @"
SELECT  
TABLE_NAME, 
DATA_TYPE, 
CHARACTER_MAXIMUM_LENGTH, 
CHARACTER_OCTET_LENGTH, 
NUMERIC_PRECISION, 
CHARACTER_SET_NAME, 
COLLATION_NAME
FROM [<<DB>>].information_schema.COLUMNS
where COLUMN_NAME = 'val'
and
TABLE_NAME like 'BSET_%'
order by TABLE_NAME asc
";
            string sqlTableStat = @"
select
(
SELECT COUNT(*) as Cardinality
FROM [<<DB>>].[dbo].[<<TABLE>>]
) as TOTAL_CARDINALITY,
(
SELECT COUNT(*) as Cardinality
FROM 
(select distinct val from
 [<<DB>>].[dbo].[<<TABLE>>]
) as t) as UNIQUE_VALUE_CARDINALITY,
(
cast(
(
SELECT COUNT(*) as Cardinality
FROM 
(select distinct val from
 [<<DB>>].[dbo].[<<TABLE>>]
) as t) as float)
/
cast((
SELECT COUNT(*) as Cardinality
FROM  [<<DB>>].[dbo].[<<TABLE>>]
) as float)
) as UNIQUENESS_SCORE
";
            SqlConnection c = null;
            try
            {
                c = new SqlConnection(this.ConnString);
                c.Open();
                SqlDataAdapter sda = new SqlDataAdapter(sqlDB, c);
                DataTable dt1 = new DataTable();
                sda.Fill(dt1);
                foreach (DataRow dr in dt1.Rows)
                {
                    string db = dr[0].ToString();
                    string sql = sqlMeta.Replace("<<DB>>", db);
                    DataTable dtm = new DataTable();
                    sda = new SqlDataAdapter(sql, c);
                    sda.Fill(dtm);
                    foreach (DataRow drm in dtm.Rows)
                    {
                        DataRow rec = dt.NewRow();
                        string sqlCard = sqlTableStat
                            .Replace("<<DB>>", db)
                            .Replace("<<TABLE>>", drm["TABLE_NAME"].ToString());
                        


                    }
                    //    DBMeta dm = new DBMeta();
                    //    dm.DBName = db;
                    //    try
                    //    {
                    //        dm.FileName = drm[0].ToString();
                    //    }
                    //    catch { }
                    //    try
                    //    {
                    //        dm.FirstLine = long.Parse(drm[1].ToString());
                    //    }
                    //    catch { }
                    //    try
                    //    {
                    //        dm.MinLoadDate = DateTime.Parse(drm[2].ToString());
                    //    }
                    //    catch { }
                    //    try
                    //    {
                    //        dm.MaxLoadDate = DateTime.Parse(drm[3].ToString());
                    //    }
                    //    catch { }
                    //    try
                    //    {
                    //        dm.TotalLines = long.Parse(drm[4].ToString());
                    //    }
                    //    catch { }
                    //    try
                    //    {
                    //        dm.HeaderRecord = drm[5].ToString();
                    //    }
                    //    catch { }
                    //    baleenMeta.Add(dm);
                    //}
                }
                MetaCache = dt;
                return dt;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
                return null;
            }
            finally
            {
                if (c != null)
                {
                    c.Close();
                }
            }
        }
    }
}
