using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BaleenLib
{
    public class NpiDAL
    {
        public static string QueryToHtmlTable(string dbConnection, string whereClause, int top)
        {
            return Utility.WebUtil.GetHtmlTable(Query(dbConnection, whereClause, top));
        }
        public static DataTable Query(string dbConnection, string whereClause, int top)
        {
            SqlConnection c = null;
            try
            {
                c = new SqlConnection(dbConnection);
                c.Open();
                SqlDataAdapter sda = new SqlDataAdapter(@"
use dndx_views
select top <<TOP>> * from vdndx_npi
where 
".Replace("<<TOP>>",top.ToString()) + whereClause, c);
                DataTable dt = new DataTable("NPI");
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
