using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BaleenLib.PortalData
{
    public class SimpleDAL
    {
        private static string DBConnection = "";
        static SimpleDAL()
        {
            DBConnection = ConfigurationManager.AppSettings["DBServerConnect"];
        }
        public static DataTable GetException(string msg, string where)
        {
            DataTable dt = new DataTable("EXCEPTION");
            dt.Columns.Add("WHERE");
            dt.Columns.Add("MSG");
            DataRow dr = dt.NewRow();
            dr[0] = where;
            dr[1] = msg;
            dt.Rows.Add(dr);
            return dt;
        }
        public static DataTable GetObjectViewList()
        {
            string sqlViews = @"
SELECT [TABLE_NAME]
	  ,'BAL_' + [DATABASE_NAME] as [DATABASE_NAME]
      ,[DATABASE_NAME] as [Universe Name]
      ,[OBJECT_NAME] as [Object Name]
      ,[TOTAL_CARDINALITY] as [Row Count]
      ,COUNT(*) as [Column Count]
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
                c = new SqlConnection(DBConnection);
                c.Open();
                SqlDataAdapter sda = new SqlDataAdapter(sqlViews, c);
                DataTable dt = new DataTable();
                sda.Fill(dt);
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
        public static DataTable GetSearchResults(string whereClause, string viewType, string viewName)
        {
            if (viewType == "SMALL")
            {
                return GetSmallView(viewName);
            }
            else
            {
                return null;
            }
        }
        public static DataTable GetSmallView(string viewName)
        {
            string sqlViews = @"
select top 1000 * from
 [bal_views].dbo.[<<VW>>]
".Replace("<<VW>>", viewName);
            SqlConnection c = null;
            try
            {
                c = new SqlConnection(DBConnection);
                c.Open();
                SqlDataAdapter sda = new SqlDataAdapter(sqlViews, c);
                DataTable dt = new DataTable();
                sda.Fill(dt);
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
        public static DataTable GetViewFields(string viewName)
        {
            string sqlViews = @"
SELECT [COLUMN_NAME] as [Column Name]
      ,[DATA_TYPE] as [SQL Data Type]
      ,'' as [SQL Expression]      
FROM [BAL_VIEWS].[dbo].[BVW_BSET_SHOW_WEB_META_3]
where TABLE_NAME = '<<VW>>'
order by COLUMN_NAME asc
".Replace("<<VW>>", viewName);
            SqlConnection c = null;
            try
            {
                c = new SqlConnection(DBConnection);
                c.Open();
                SqlDataAdapter sda = new SqlDataAdapter(sqlViews, c);
                DataTable dt = new DataTable();
                sda.Fill(dt);
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
