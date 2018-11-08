using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BaleenLib.PortalData
{
    public class GetViews
    {
        private DataTable cache = null;
        private string ConnString = "";
        public GetViews(string dbServerConnString)
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
            string sqlViews = @"
SELECT [TABLE_NAME]
      ,[DATABASE_NAME]
      ,[OBJECT_NAME]
      ,[TOTAL_CARDINALITY]
      ,COUNT(*) as [NUMBER_OF_COLUMNS]
FROM [BAL_VIEWS].[dbo].[BVW_BSET_SHOW_WEB_META_3]
group by [TABLE_NAME]
      ,[DATABASE_NAME]
      ,[OBJECT_NAME]
      ,[TOTAL_CARDINALITY]
order by [DATABASE_NAME] asc
      ,[OBJECT_NAME] asc
";
            SqlConnection c = null;
            try
            {
                c = new SqlConnection(this.ConnString);
                c.Open();
                SqlDataAdapter sda = new SqlDataAdapter(sqlViews, c);
                DataTable dt = new DataTable();
                sda.Fill(dt);
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
