using System;
using System.Data;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BaleenLib.PortalData
{
    public class ViewFactory
    {
        private static string DBConnection = "";
        static ViewFactory()
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
        public static DataTable GetViews()
        {
            GetViews gv = new GetViews(DBConnection);
            return gv.Run(true);
        }
    }
}
