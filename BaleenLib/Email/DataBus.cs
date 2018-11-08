using System;
using System.IO;
using System.Configuration;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.HtmlControls;

public class IndexEntry
{
    public string key = "";
    public string EntryStart = "";
    public string EntryEnd = "";
    public long Cardinality = 0;
    public double? EndAsLong()
    {
        double? temp = null;
        if (this.EntryEnd.Contains("LL:") &&
            this.EntryEnd.Contains(","))
        {
            string p = this.EntryEnd.Replace("LL:", "");
            string[] parts = p.Split(',');
            temp = double.Parse(parts[1].Trim());
        }
        return temp;
    }
    public double? EndAsLat()
    {
        double? temp = null;
        if (this.EntryEnd.Contains("LL:") &&
            this.EntryEnd.Contains(","))
        {
            string p = this.EntryEnd.Replace("LL:", "");
            string[] parts = p.Split(',');
            temp = double.Parse(parts[0].Trim());
        }
        return temp;
    }
    public double? StartAsLong()
    {
        double? temp = null;
        if (this.EntryStart.Contains("LL:") &&
            this.EntryStart.Contains(","))
        {
            string p = this.EntryStart.Replace("LL:", "");
            string[] parts = p.Split(',');
            temp = double.Parse(parts[1].Trim());
        }
        return temp;
    }
    public double? StartAsLat()
    {
        double? temp = null;
        if (this.EntryStart.Contains("LL:") &&
            this.EntryStart.Contains(","))
        {
            string p = this.EntryStart.Replace("LL:", "");
            string[] parts = p.Split(',');
            temp = double.Parse(parts[0].Trim());
        }
        return temp;
    }
    public DateTime? StartAsDate()
    {
        DateTime? ret = null;
        DateTime dt;
        bool good = DateTime.TryParse(this.EntryStart, out dt);
        if (good) ret = dt;
        return ret;
    }
    public DateTime? EndAsDate()
    {
        DateTime? ret = null;
        DateTime dt;
        bool good = DateTime.TryParse(this.EntryEnd, out dt);
        if (good) ret = dt;
        return ret;
    }
}
public class Indexes
{
    public static Dictionary<int, List<IndexEntry>> MasterIndex = null;
    public static DataSet GetLocationEventCount(int fk)
    {
        try
        {
            //2009-4 LL:33,44	1239
            List<IndexEntry> iens = (from ix in MasterIndex[fk]
                                     where ix.StartAsDate() != null
                                     && ix.EndAsLat() != null
                                     && ix.EndAsLong() != null
                                    select ix).ToList<IndexEntry>();



            DataTable dt = new DataTable();
            //dt.Columns.Add(new DataColumn("Year", typeof(System.Int32)));
            //dt.Columns.Add(new DataColumn("Month", typeof(System.Int32)));
            dt.Columns.Add(new DataColumn("Latitude", typeof(System.Double)));
            dt.Columns.Add(new DataColumn("Longitude", typeof(System.Double)));
            dt.Columns.Add(new DataColumn("Intensity", typeof(System.Int64)));


            Dictionary<string, IndexEntry> smallList = new Dictionary<string, IndexEntry>();

            foreach (IndexEntry ix in iens)
            {

                string key = "";

                long lal = (long)ix.EndAsLat().Value;
                long lol = (long)ix.EndAsLong().Value;

                key = lal.ToString() + "-" + lol.ToString();

                if (!smallList.ContainsKey(key))
                {
                    ix.Cardinality = 0;
                    smallList.Add(key, ix);
                }

                if (smallList.ContainsKey(key))
                {
                    smallList[key].Cardinality += ix.Cardinality;
                }
                //else
                //{
                    
                //    smallList.Add(key, ix);
                //}
            }

            //Dictionary<double, double> lon = new Dictionary<double, double>();
            //Dictionary<double, double> lat = new Dictionary<double, double>();

            //List<IndexEntry> sl2 = smallList.Values.ToList<IndexEntry>();

            List<IndexEntry> small2 = (from sl in smallList.Values
                                      orderby sl.Cardinality descending
                                      select sl).ToList<IndexEntry>();

            foreach (IndexEntry ix in small2)
            {
                try
                {
                    //if (!lon.ContainsKey(ix.EndAsLong().Value))
                    //{
                    //    lon.Add(ix.EndAsLong().Value, ix.EndAsLong().Value);
                    //}

                    //if (!lat.ContainsKey(ix.EndAsLat().Value))
                    //{
                    //    lat.Add(ix.EndAsLat().Value, ix.EndAsLat().Value);
                    //}



                    DataRow dr = dt.NewRow();

                    


                    //dr[0] = ix.StartAsDate().Value.Year;
                    //dr[1] = ix.StartAsDate().Value.Month;
                    dr[0] = ix.EndAsLat().Value;
                    dr[1] = ix.EndAsLong().Value;


                    long intens = ((long) ((double)ix.Cardinality) / 100);


                    dr[2] = intens;

                    dt.Rows.Add(dr);
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine(ex.Message);
                }
            }


            //double minLon = lon.Values.Min();
            //double maxLon = lon.Values.Max();

            //double minLat = lat.Values.Min();
            //double maxLat = lat.Values.Max();


            DataSet dtst = new DataSet();

            dtst.Tables.Add(dt);





            return dtst;
            

        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.Message);
            return null;
        }
    }
    public static DataSet GetKeyWordDatesFromGeocode(int fk, int lat, int lon)
    {
        try
        {
            List<IndexEntry> kws = (from ix in MasterIndex[fk]
                                where ix.EndAsDate() == null
                                && ix.StartAsLat() != null
                                && ix.StartAsLong() != null
                                && ((int)ix.StartAsLat()) == lat
                                && ((int)ix.StartAsLong()) == lon
                                select ix).ToList<IndexEntry>();


            Dictionary<string, IndexEntry> toks = new Dictionary<string, IndexEntry>();


            foreach (IndexEntry k in kws)
            {
                string k2 = k.EntryEnd;

                if (k2.Length > 8)
                {
                    k2 = k2.Substring(0, 8) + "*";
                }

                if (toks.ContainsKey(k2))
                {
                    toks[k2].Cardinality += k.Cardinality;
                }
                else
                {
                    k.key = k2;
                    toks.Add(k2, k);
                }
            }


            List<IndexEntry> l2 = (from ix in toks.Values.ToList<IndexEntry>()
                                   orderby ix.EntryEnd ascending
                                   select ix
                                   ).ToList<IndexEntry>();


            //List<string> unstr = toks.Keys.ToList<string>();





            DataTable dt = new DataTable();
            //dt.Columns.Add(new DataColumn("Year", typeof(System.Int32)));
            //dt.Columns.Add(new DataColumn("Month", typeof(System.Int32)));
            dt.Columns.Add(new DataColumn("Key Word", typeof(System.String)));
            dt.Columns.Add(new DataColumn("Score", typeof(System.Int64)));
            dt.Columns.Add(new DataColumn("FileKey", typeof(System.Int32)));
            dt.Columns.Add(new DataColumn("Lat", typeof(System.Int32)));
            dt.Columns.Add(new DataColumn("Lon", typeof(System.Int32)));


            foreach (IndexEntry ind in l2)
            {
                DataRow dr = dt.NewRow();

                dr[0] = ind.key;
                //dr[1] = ind.Cardinality;


                double scor = ((double)ind.Cardinality) / 10.0;
                dr[1] = (long)scor;

                dr[2] = fk;
                dr[3] = lat;
                dr[4] = lon;

                //if (scor > 0)
                //{

                    dt.Rows.Add(dr);
                //}
            }




            //Dictionary<string, IndexEntry> smallList = new Dictionary<string, IndexEntry>();

            //foreach (IndexEntry ix in iens)
            //{

            //    string key = "";

            //    long lal = (long)ix.EndAsLat().Value;
            //    long lol = (long)ix.EndAsLong().Value;

            //    key = lal.ToString() + "-" + lol.ToString();


            //    if (smallList.ContainsKey(key))
            //    {
            //        smallList[key].Cardinality += ix.Cardinality;
            //    }
            //    else
            //    {
            //        smallList.Add(key, ix);
            //    }
            //}

            //Dictionary<double, double> lon = new Dictionary<double, double>();
            //Dictionary<double, double> lat = new Dictionary<double, double>();

            //List<IndexEntry> sl2 = smallList.Values.ToList<IndexEntry>();

            //List<IndexEntry> small2 = (from sl in smallList.Values
            //                           orderby sl.Cardinality descending
            //                           select sl).ToList<IndexEntry>();

            //foreach (IndexEntry ix in small2)
            //{
            //    try
            //    {
            //        //if (!lon.ContainsKey(ix.EndAsLong().Value))
            //        //{
            //        //    lon.Add(ix.EndAsLong().Value, ix.EndAsLong().Value);
            //        //}

            //        //if (!lat.ContainsKey(ix.EndAsLat().Value))
            //        //{
            //        //    lat.Add(ix.EndAsLat().Value, ix.EndAsLat().Value);
            //        //}



            //        DataRow dr = dt.NewRow();




            //        //dr[0] = ix.StartAsDate().Value.Year;
            //        //dr[1] = ix.StartAsDate().Value.Month;
            //        dr[0] = ix.EndAsLat().Value;
            //        dr[1] = ix.EndAsLong().Value;


            //        long intens = ((long)((double)ix.Cardinality) / 100);


            //        dr[2] = intens;

            //        dt.Rows.Add(dr);
            //    }
            //    catch (Exception ex)
            //    {
            //        System.Diagnostics.Debug.WriteLine(ex.Message);
            //    }
            //}


            //double minLon = lon.Values.Min();
            //double maxLon = lon.Values.Max();

            //double minLat = lat.Values.Min();
            //double maxLat = lat.Values.Max();


            DataSet dtst = new DataSet();

            dtst.Tables.Add(dt);





            return dtst;


        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.Message);
            return null;
        }
    }
    //public static DataSet GetKeyWordDatesFromGeocode2(int fk, int lat, int lon, string kw)
    //{
    //    try
    //    {
    //        List<IndexEntry> kws = (from ix in MasterIndex[fk]
    //                                where ix.EndAsDate() == null
    //                                && ix.StartAsLat() != null
    //                                && ix.StartAsLong() != null
    //                                && ((int)ix.StartAsLat()) == lat
    //                                && ((int)ix.StartAsLong()) == lon
    //                                select ix).ToList<IndexEntry>();


    //        Dictionary<string, IndexEntry> toks = new Dictionary<string, IndexEntry>();


    //        foreach (IndexEntry k in kws)
    //        {
    //            string k2 = k.EntryEnd;

    //            if (k2.Length > 8)
    //            {
    //                k2 = k2.Substring(0, 8) + "*";
    //            }

    //            if (toks.ContainsKey(k2))
    //            {
    //                toks[k2].Cardinality += k.Cardinality;
    //            }
    //            else
    //            {
    //                k.key = k2;
    //                toks.Add(k2, k);
    //            }
    //        }


    //        List<IndexEntry> l2 = (from ix in toks.Values.ToList<IndexEntry>()
    //                               orderby ix.EntryEnd ascending
    //                               select ix
    //                               ).ToList<IndexEntry>();


    //        //List<string> unstr = toks.Keys.ToList<string>();





    //        DataTable dt = new DataTable();
    //        //dt.Columns.Add(new DataColumn("Year", typeof(System.Int32)));
    //        //dt.Columns.Add(new DataColumn("Month", typeof(System.Int32)));
    //        dt.Columns.Add(new DataColumn("Key Word", typeof(System.String)));
    //        dt.Columns.Add(new DataColumn("Score", typeof(System.Int64)));
    //        dt.Columns.Add(new DataColumn("FileKey", typeof(System.Int32)));
    //        dt.Columns.Add(new DataColumn("Lat", typeof(System.Int32)));
    //        dt.Columns.Add(new DataColumn("Lon", typeof(System.Int32)));


    //        foreach (IndexEntry ind in l2)
    //        {
    //            DataRow dr = dt.NewRow();

    //            dr[0] = ind.key;
    //            //dr[1] = ind.Cardinality;


    //            double scor = ((double)ind.Cardinality) / 100.0;
    //            dr[1] = (long)scor;

    //            dr[2] = fk;
    //            dr[3] = lat;
    //            dr[4] = lon;
    //            dt.Rows.Add(dr);
    //        }




    //        //Dictionary<string, IndexEntry> smallList = new Dictionary<string, IndexEntry>();

    //        //foreach (IndexEntry ix in iens)
    //        //{

    //        //    string key = "";

    //        //    long lal = (long)ix.EndAsLat().Value;
    //        //    long lol = (long)ix.EndAsLong().Value;

    //        //    key = lal.ToString() + "-" + lol.ToString();


    //        //    if (smallList.ContainsKey(key))
    //        //    {
    //        //        smallList[key].Cardinality += ix.Cardinality;
    //        //    }
    //        //    else
    //        //    {
    //        //        smallList.Add(key, ix);
    //        //    }
    //        //}

    //        //Dictionary<double, double> lon = new Dictionary<double, double>();
    //        //Dictionary<double, double> lat = new Dictionary<double, double>();

    //        //List<IndexEntry> sl2 = smallList.Values.ToList<IndexEntry>();

    //        //List<IndexEntry> small2 = (from sl in smallList.Values
    //        //                           orderby sl.Cardinality descending
    //        //                           select sl).ToList<IndexEntry>();

    //        //foreach (IndexEntry ix in small2)
    //        //{
    //        //    try
    //        //    {
    //        //        //if (!lon.ContainsKey(ix.EndAsLong().Value))
    //        //        //{
    //        //        //    lon.Add(ix.EndAsLong().Value, ix.EndAsLong().Value);
    //        //        //}

    //        //        //if (!lat.ContainsKey(ix.EndAsLat().Value))
    //        //        //{
    //        //        //    lat.Add(ix.EndAsLat().Value, ix.EndAsLat().Value);
    //        //        //}



    //        //        DataRow dr = dt.NewRow();




    //        //        //dr[0] = ix.StartAsDate().Value.Year;
    //        //        //dr[1] = ix.StartAsDate().Value.Month;
    //        //        dr[0] = ix.EndAsLat().Value;
    //        //        dr[1] = ix.EndAsLong().Value;


    //        //        long intens = ((long)((double)ix.Cardinality) / 100);


    //        //        dr[2] = intens;

    //        //        dt.Rows.Add(dr);
    //        //    }
    //        //    catch (Exception ex)
    //        //    {
    //        //        System.Diagnostics.Debug.WriteLine(ex.Message);
    //        //    }
    //        //}


    //        //double minLon = lon.Values.Min();
    //        //double maxLon = lon.Values.Max();

    //        //double minLat = lat.Values.Min();
    //        //double maxLat = lat.Values.Max();


    //        DataSet dtst = new DataSet();

    //        dtst.Tables.Add(dt);





    //        return dtst;


    //    }
    //    catch (Exception ex)
    //    {
    //        System.Diagnostics.Debug.WriteLine(ex.Message);
    //        return null;
    //    }
    //}
    static Indexes()
    {
        MasterIndex = new Dictionary<int, List<IndexEntry>>();
        string idx = HttpContext.Current.Server.MapPath("~/App_Data/DATA/");
        string[] idxs = Directory.GetFiles(idx, "*.IDX");
        foreach (string i in idxs)
        {
            FileInfo fi = new FileInfo(i);
            string[] nparts = fi.Name.Split('.');
            int fk = int.Parse(nparts[0]);
            if (!MasterIndex.ContainsKey(fk))
            {
                MasterIndex.Add(fk, new List<IndexEntry>());
            }
            string[] lines = File.ReadAllLines(i);
            foreach (string ln in lines)
            {
                string[] step1 = ln.Split('\t');
                string[] step2 = Regex.Split(step1[0], "\\^\\=\\=\\>\\^");
                IndexEntry ie = new IndexEntry();
                ie.key = step1[0];
                ie.EntryStart = step2[0].Trim();
                ie.EntryEnd = step2[1].Trim();
                ie.Cardinality = long.Parse(step1[1].Trim());
                MasterIndex[fk].Add(ie);
            }
        }
    }
}
public class SimpleQuery
{
    public DataTable dt = null;
    private SqlConnection Connect = null;
    private string SqlQuery = "";

    public SimpleQuery(string query, SqlConnection conn, DataTable op)
    {
        this.SqlQuery = query;
        this.Connect = conn;
        this.dt = op;
    }
    public void Run()
    {
        try
        {
            this.Connect.Open();
            SqlCommand cmd = new SqlCommand(this.SqlQuery, this.Connect);
            SqlDataReader sdr = cmd.ExecuteReader();
            while (sdr.Read())
            {
                lock (this.dt)
                {
                    DataRow dr = dt.NewRow();
                    dr[0] = sdr[0];
                    dr[1] = sdr[1];
                    dr[2] = sdr[2];
                    dr[3] = sdr[3];
                    dr[4] = sdr[4];
                    dr[5] = sdr[5];
                    dr[6] = sdr[6];
                    dr[7] = sdr[7];
                    dt.Rows.Add(dr);
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.Write(ex.Message);
        }
    }
}
public class DataBus
{
    public static Dictionary<int, string> DataHeaders = null;
    public static Dictionary<int, SqlConnection> connections = null;
    static DataBus()
    {
        connections = new Dictionary<int, SqlConnection>();
        connections.Add(0, new SqlConnection("Data Source=dendrasystem.db.7040204.hostedresource.com; Initial Catalog=dendrasystem; User ID=dendrasystem; Password=g@myH0m3!4u;"));
        connections.Add(1, new SqlConnection("Data Source=db000001.db.7040204.hostedresource.com; Initial Catalog=db000001; User ID=db000001; Password=g@myH0m3!4u;"));
        connections.Add(2, new SqlConnection("Data Source=db000002.db.7040204.hostedresource.com; Initial Catalog=db000002; User ID=db000002; Password=g@myH0m3!4u;"));
        connections.Add(3, new SqlConnection("Data Source=db000003.db.7040204.hostedresource.com; Initial Catalog=db000003; User ID=db000003; Password=g@myH0m3!4u;"));
        connections.Add(4, new SqlConnection("Data Source=db000004.db.7040204.hostedresource.com; Initial Catalog=db000004; User ID=db000004; Password=g@myH0m3!4u;"));
        connections.Add(5, new SqlConnection("Data Source=db000005.db.7040204.hostedresource.com; Initial Catalog=db000005; User ID=db000005; Password=g@myH0m3!4u;"));
        connections.Add(6, new SqlConnection("Data Source=db000006.db.7040204.hostedresource.com; Initial Catalog=db000006; User ID=db000006; Password=g@myH0m3!4u;"));
        connections.Add(7, new SqlConnection("Data Source=db000007.db.7040204.hostedresource.com; Initial Catalog=db000007; User ID=db000007; Password=g@myH0m3!4u;"));
        connections.Add(8, new SqlConnection("Data Source=db000008.db.7040204.hostedresource.com; Initial Catalog=db000008; User ID=db000008; Password=g@myH0m3!4u;"));
        connections.Add(9, new SqlConnection("Data Source=db000009.db.7040204.hostedresource.com; Initial Catalog=db000009; User ID=db000009; Password=g@myH0m3!4u;"));
        connections.Add(10, new SqlConnection("Data Source=db000010.db.7040204.hostedresource.com; Initial Catalog=db000010; User ID=db000010; Password=g@myH0m3!4u;"));
        connections.Add(11, new SqlConnection("Data Source=db000011.db.7040204.hostedresource.com; Initial Catalog=db000011; User ID=db000011; Password=g@myH0m3!4u;"));
        connections.Add(12, new SqlConnection("Data Source=db000012.db.7040204.hostedresource.com; Initial Catalog=db000012; User ID=db000012; Password=g@myH0m3!4u;"));
        connections.Add(13, new SqlConnection("Data Source=db000013.db.7040204.hostedresource.com; Initial Catalog=db000013; User ID=db000013; Password=g@myH0m3!4u;"));
        connections.Add(14, new SqlConnection("Data Source=db000014.db.7040204.hostedresource.com; Initial Catalog=db000014; User ID=db000014; Password=g@myH0m3!4u;"));
        connections.Add(15, new SqlConnection("Data Source=db000015.db.7040204.hostedresource.com; Initial Catalog=db000015; User ID=db000015; Password=g@myH0m3!4u;"));
        connections.Add(16, new SqlConnection("Data Source=db000016.db.7040204.hostedresource.com; Initial Catalog=db000016; User ID=db000016; Password=g@myH0m3!4u;"));
        connections.Add(17, new SqlConnection("Data Source=db000017.db.7040204.hostedresource.com; Initial Catalog=db000017; User ID=db000017; Password=g@myH0m3!4u;"));
        connections.Add(18, new SqlConnection("Data Source=db000018.db.7040204.hostedresource.com; Initial Catalog=db000018; User ID=db000018; Password=g@myH0m3!4u;"));
        connections.Add(19, new SqlConnection("Data Source=db000019.db.7040204.hostedresource.com; Initial Catalog=db000019; User ID=db000019; Password=g@myH0m3!4u;"));
        connections.Add(20, new SqlConnection("Data Source=db000020.db.7040204.hostedresource.com; Initial Catalog=db000020; User ID=db000020; Password=g@myH0m3!4u;"));
        connections.Add(21, new SqlConnection("Data Source=db000021.db.7040204.hostedresource.com; Initial Catalog=db000021; User ID=db000021; Password=g@myH0m3!4u;"));
        connections.Add(22, new SqlConnection("Data Source=db000022.db.7040204.hostedresource.com; Initial Catalog=db000022; User ID=db000022; Password=g@myH0m3!4u;"));
        connections.Add(23, new SqlConnection("Data Source=db000023.db.7040204.hostedresource.com; Initial Catalog=db000023; User ID=db000023; Password=g@myH0m3!4u;"));
        //connections.Add(24, new SqlConnection("Data Source=db000024.db.7040204.hostedresource.com; Initial Catalog=db000024; User ID=db000024; Password=g@myH0m3!4u;"));
        //connections.Add(25, new SqlConnection("Data Source=db000025.db.7040204.hostedresource.com; Initial Catalog=db000025; User ID=db000025; Password=g@myH0m3!4u;"));
        //connections.Add(26, new SqlConnection("Data Source=db000026.db.7040204.hostedresource.com; Initial Catalog=db000026; User ID=db000026; Password=g@myH0m3!4u;"));
        //connections.Add(27, new SqlConnection("Data Source=db000027.db.7040204.hostedresource.com; Initial Catalog=db000027; User ID=db000027; Password=g@myH0m3!4u;"));
        //connections.Add(28, new SqlConnection("Data Source=db000028.db.7040204.hostedresource.com; Initial Catalog=db000028; User ID=db000028; Password=g@myH0m3!4u;"));
        //connections.Add(29, new SqlConnection("Data Source=db000029.db.7040204.hostedresource.com; Initial Catalog=db000029; User ID=db000029; Password=g@myH0m3!4u;"));
        //connections.Add(30, new SqlConnection("Data Source=db000030.db.7040204.hostedresource.com; Initial Catalog=db000030; User ID=db000030; Password=g@myH0m3!4u;"));
        //connections.Add(31, new SqlConnection("Data Source=db000031.db.7040204.hostedresource.com; Initial Catalog=db000031; User ID=db000031; Password=g@myH0m3!4u;"));
        //connections.Add(32, new SqlConnection("Data Source=db000032.db.7040204.hostedresource.com; Initial Catalog=db000032; User ID=db000032; Password=g@myH0m3!4u;"));
        //connections.Add(33, new SqlConnection("Data Source=db000033.db.7040204.hostedresource.com; Initial Catalog=db000033; User ID=db000033; Password=g@myH0m3!4u;"));
        //connections.Add(34, new SqlConnection("Data Source=db000034.db.7040204.hostedresource.com; Initial Catalog=db000034; User ID=db000034; Password=g@myH0m3!4u;"));
        //connections.Add(35, new SqlConnection("Data Source=db000035.db.7040204.hostedresource.com; Initial Catalog=db000035; User ID=db000035; Password=g@myH0m3!4u;"));

        InitDataHeaders();
    }
    public static HtmlTable GetRecordDataCSV(int db, long lineNumber, long FileKey, out string content)
    {
        SqlConnection conn = null;
        try
        {
            conn = connections[db];
            conn.Open();

            string sql = @"
select sequencenumber, lineNumber, filecontent from node with (nolock) 
where filekey = @fileKey
and 
linenumber = @line 
order by sequencenumber asc
";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@line", lineNumber));
            cmd.Parameters.Add(new SqlParameter("@fileKey", FileKey));

            SqlDataReader sdr = cmd.ExecuteReader();

            StringBuilder sb = new StringBuilder();

            Dictionary<long, StringBuilder> sbs = new Dictionary<long, StringBuilder>();

            while (sdr.Read())
            {
                long ln = sdr.GetInt64(1);
                string cont = sdr.GetString(2);
                if (sbs.ContainsKey(ln))
                {
                    sbs[ln].Append(cont);
                }
                else
                {
                    sbs.Add(ln, new StringBuilder(cont));
                }
            }

            List<long> keys = sbs.Keys.ToList<long>();

            keys.Sort();

            HtmlTable ht = new HtmlTable();

            string dat = "";

            foreach (long k in sbs.Keys)
            {
                if (k != 0)
                {
                    dat = sbs[k].ToString();
                    break;
                }
            }

            string[] d = dat.Split(',');

            content = dat;

            //string[] d = Regex.Split(dat, "[\\<][\\^][\\>]");

            sdr.Close();

            if (DataHeaders.ContainsKey((int)FileKey))
            {
                //string[] h = Regex.Split(DataHeaders[(int)FileKey], "[\\<][\\^][\\>]");

                string[] h = DataHeaders[(int)FileKey].Split(',');

                for (int j = 0; j < d.Length && j < h.Length; j++)
                {

                    if (d[j].Trim() == "") continue;

                    HtmlTableRow tr = new HtmlTableRow();

                    HtmlTableCell fl = new HtmlTableCell();
                    fl.Width = "100px";
                    fl.Align = "right";
                    fl.BgColor = "black";

                    fl.Style.Add("color", "white");
                    fl.Style.Add("font-weight", "bolder");

                    fl.BorderColor = "Black";
                    fl.InnerText = h[j] + ": ";
                    tr.Cells.Add(fl);

                    HtmlTableCell da = new HtmlTableCell();
                    da.BgColor = "LightBlue";
                    da.BorderColor = "Black";
                    da.InnerText = d[j];
                    tr.Cells.Add(da);

                    ht.Rows.Add(tr);
                }
                return ht;
            }
            else
            {
                return null;
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.Write(ex.Message);
            content = null;
            return null;
        }
        finally
        {
            if (conn != null)
            {
                conn.Close();
            }
        }
    }
    public static HtmlTable GetRecordData(int db, long lineNumber, long FileKey, out string addressInfo)
    {
        SqlConnection conn = null;
        try
        {
            conn = connections[db];
            conn.Open();

            string sql = @"
select sequencenumber, lineNumber, filecontent from node with (nolock) 
where filekey = @fileKey
and 
linenumber = @line 
order by sequencenumber asc
";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@line", lineNumber));
            cmd.Parameters.Add(new SqlParameter("@fileKey", FileKey));

            SqlDataReader sdr = cmd.ExecuteReader();

            StringBuilder sb = new StringBuilder();

            Dictionary<long, StringBuilder> sbs = new Dictionary<long, StringBuilder>();

            while (sdr.Read())
            {
                long ln = sdr.GetInt64(1);
                string cont = sdr.GetString(2);
                if (sbs.ContainsKey(ln))
                {
                    sbs[ln].Append(cont);
                }
                else
                {
                    sbs.Add(ln, new StringBuilder(cont));
                }
            }

            List<long> keys = sbs.Keys.ToList<long>();

            keys.Sort();

            HtmlTable ht = new HtmlTable();

            string dat = "";

            foreach (long k in sbs.Keys)
            {
                if (k != 0)
                {
                    dat = sbs[k].ToString();
                    break;
                }
            }

            string[] d = Regex.Split(dat, "[\\<][\\^][\\>]");

            sdr.Close();

            StringBuilder addrInfo = new StringBuilder();

            Dictionary<string, string> adict = new Dictionary<string, string>();



            if (DataHeaders.ContainsKey((int)FileKey))
            {
                string[] h = Regex.Split(DataHeaders[(int)FileKey], "[\\<][\\^][\\>]");

                for (int j = 0; j < d.Length; j++)
                {

                    if (d[j].Trim() == "") continue;

                    HtmlTableRow tr = new HtmlTableRow();

                    HtmlTableCell fl = new HtmlTableCell();
                    fl.Width = "100px";
                    fl.Align = "right";
                    fl.BgColor = "black";

                    fl.Style.Add("color", "white");
                    fl.Style.Add("font-weight", "bolder");

                    fl.BorderColor = "Black";
                    fl.InnerText = h[j] + ": ";
                    tr.Cells.Add(fl);

                    HtmlTableCell da = new HtmlTableCell();
                    da.BgColor = "LightBlue";
                    da.BorderColor = "Black";
                    da.InnerText = d[j];
                    tr.Cells.Add(da);


                    if (h[j].Trim().ToLower().Contains("zip")  &&
                    d[j].ToUpper().Trim().Length > 0 && 
                    !adict.ContainsKey("zipcode"))
                    {

                        string z = d[j].Trim().ToUpper();

                        if (z.Length > 5) z = z.Substring(0, 5);

                        adict["zipcode"] = z;

                        //addrInfo.Append(d[j]).Append(' ');

                        //if (!adict.ContainsKey(d[j].Trim().ToUpper()))
                        //{
                        //    adict.Add(d[j].Trim().ToUpper(),"");
                        //}

                    }

                    if (h[j].Trim().ToLower().Contains("address") &&
                         d[j].ToUpper().Trim().Length > 0 &&
                         !adict.ContainsKey("address"))
                    {

                        adict["address"] = d[j].Trim().ToUpper();

                        //addrInfo.Append(d[j]).Append(' ');

                        //if (!adict.ContainsKey(d[j].Trim().ToUpper()))
                        //{
                        //    adict.Add(d[j].Trim().ToUpper(),"");
                        //}

                    }



                    //if ((h[j].Trim().ToLower().Contains("address") ||
                    //    h[j].Trim().ToLower().Contains("state") ||
                    //    h[j].Trim().ToLower().Contains("city") ||
                    //    h[j].Trim().ToLower().Contains("zip")) &&
                    //    d[j].Trim().Length > 0)
                    //{



                    //    //addrInfo.Append(d[j]).Append(' ');

                    //    //if (!adict.ContainsKey(d[j].Trim().ToUpper()))
                    //    //{
                    //    //    adict.Add(d[j].Trim().ToUpper(),"");
                    //    //}

                    //}

                    ht.Rows.Add(tr);
                }

                foreach (string val in adict.Values)
                {
                    addrInfo.Append(val).Append(' ');
                }

                addressInfo = addrInfo.ToString().Trim();


                return ht;
            }
            else
            {
                addressInfo = null;
                return null;
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.Write(ex.Message);
            addressInfo = null;
            return null; 
        }
        finally
        {
            if (conn != null)
            {
                conn.Close();
            }
        }
    }
    public static string GetContentLines(int db, long lineNumber, long FileKey)
    {
        SqlConnection conn = null;
        try
        {
            conn = connections[db];
            conn.Open();

            string sql = @"

select lineNumber, filecontent from node with (nolock)
where filekey = @fileKey

and 
(
linenumber >= @line - 5
and
linenumber <= @line + 5
)
order by sequencenumber asc

";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.Add(new SqlParameter("@line", lineNumber));
            cmd.Parameters.Add(new SqlParameter("@fileKey", FileKey));

            SqlDataReader sdr = cmd.ExecuteReader();

            StringBuilder sb = new StringBuilder();

            Dictionary<long, StringBuilder> sbs = new Dictionary<long, StringBuilder>();

            while (sdr.Read())
            {
                long ln = sdr.GetInt64(0);
                string cont = sdr.GetString(1);

                if (sbs.ContainsKey(ln))
                {
                    sbs[ln].Append(cont);
                }
                else
                {
                    sbs.Add(ln, new StringBuilder(cont));
                }
            }

            List<long> keys = sbs.Keys.ToList<long>();

            keys.Sort();

            StringBuilder ret = new StringBuilder();

            foreach (long k in keys)
            {
                string x = sbs[k].ToString();

                if (x.Contains("<^>"))
                {
                    x = Regex.Replace(x, "([\\<][\\^][\\>])+", ", ");
                }

                ret.Append(x);
                ret.Append(" ");
            }

            return ret.ToString();
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.Write(ex.Message);
            return ex.Message;
        }
        finally
        {
            if (conn != null)
            {
                conn.Close();
            }
        }
    }
    public static void InitDataHeaders()
    {
        SqlConnection conn = null;
        try
        {
            DataHeaders = new Dictionary<int, string>();
            foreach (int key in connections.Keys)
            {
                if (key == 0) continue;
                conn = connections[key];
                string sql = @"
select filekey,filecontent from node
where filetype in ('TAB','CSV') and
linenumber = 0
order by filekey asc, sequencenumber asc
";

                conn.Open();

                SqlCommand cmd = new SqlCommand(sql, conn);

                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    try
                    {
                        int fk = int.Parse(sdr[0].ToString());
                        string fc = sdr.GetString(1);

                        if (DataHeaders.ContainsKey(fk))
                        {
                            DataHeaders[fk] += fc;
                        }
                        else
                        {
                            DataHeaders.Add(fk, fc);
                        }

                    }
                    catch(Exception ex) 
                    {
                        System.Diagnostics.Debug.Write(ex.Message);
                    }
                }

                conn.Close();
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.Write(ex.Message);
        }
        finally
        {
            if (conn != null)
            {
                conn.Close();
            }
        }
    }
//    public static DataSet QueryDB2(string query)
//    {
//        if (query == null) return null;

//        query = query.Replace(' ', '%');
//        query = query.Replace("%%", "%");
//        query = query.Replace("'", "");

//        try
//        {
//            DataTable dt = new DataTable();
//            dt.Columns.Add(new DataColumn("SequenceNumber", typeof(System.Int64)));
//            dt.Columns.Add(new DataColumn("FileContent", typeof(System.String)));
//            dt.Columns.Add(new DataColumn("UserID", typeof(System.Int64)));
//            dt.Columns.Add(new DataColumn("FileType", typeof(System.String)));
//            dt.Columns.Add(new DataColumn("FileDesc", typeof(System.String)));
//            dt.Columns.Add(new DataColumn("FileKey", typeof(System.Int64)));
//            dt.Columns.Add(new DataColumn("LineNumber", typeof(System.Int64)));
//            dt.Columns.Add(new DataColumn("CreatedOn", typeof(System.DateTime)));

//            List<Thread> threads = new List<Thread>();

//            foreach (int key in connections.Keys)
//            {
//                if (key == 0) continue;
//                string sql = @"
//SELECT 
//[SequenceNumber]
//,[FileContent]
//,-1 as [UserID]
//,[FileType]
//,'' as [FileDesc]
//,[FileKey]
//,[LineNumber]
//,[CreatedOn]
//FROM node with (nolock)
//
//where filecontent like '%<<QRY>>%'
//";
//                sql = sql.Replace("<<QRY>>", query);
//                SimpleQuery sq = new SimpleQuery(sql, connections[key], dt);
//                threads.Add(new Thread(new ThreadStart(sq.Run)));
//            }

//            foreach (Thread t in threads)
//            {
//                t.Start();
//                t.Join();
//            }

//            DataSet dtst = new DataSet();

//            dtst.Tables.Add(dt);

//            return dtst;

//        }
//        catch (Exception ex)
//        {
//            System.Diagnostics.Debug.Write(ex.Message);
//            return null;
//        }
//    }

    public static DataSet QueryDB2(string query, string fk, string ll)
    {
        if (query == null) return null;

        query = query.Trim();

        if (query == "") return null;

        query = query.Replace(' ', '%');
        query = query.Replace("'", "%");
        query = query.Replace("%%", "%");

        SqlConnection conn = null;
        try
        {
            DataTable dt = new DataTable();

            dt.Columns.Add(new DataColumn("SequenceNumber", typeof(System.Int64)));
            dt.Columns.Add(new DataColumn("FileContent", typeof(System.String)));
            dt.Columns.Add(new DataColumn("UserID", typeof(System.Int64)));
            dt.Columns.Add(new DataColumn("FileType", typeof(System.String)));
            dt.Columns.Add(new DataColumn("FileDesc", typeof(System.String)));
            dt.Columns.Add(new DataColumn("FileKey", typeof(System.Int64)));
            dt.Columns.Add(new DataColumn("LineNumber", typeof(System.Int64)));
            dt.Columns.Add(new DataColumn("CreatedOn", typeof(System.DateTime)));
            dt.Columns.Add(new DataColumn("SourceDB", typeof(System.Int64)));
            dt.Columns.Add(new DataColumn("Score", typeof(System.String)));

            foreach (int key in connections.Keys)
            {
                if (key == 0) continue;
                if (key > 32) continue;
                conn = connections[key];
                string sql = @"
SELECT top 1000 
[SequenceNumber]
,[FileContent]
,-1 as [UserID]
,[FileType]
,'' as [FileDesc]
,[FileKey]
,[LineNumber]
,[CreatedOn]
FROM node with (nolock)
where 
(filecontent like '%<<QRY>>%'
or
filecontent like '%<<LL>>%')
and filekey = <<FK>>
";
                sql = sql.Replace("<<QRY>>", query);
                sql = sql.Replace("<<LL>>", ll);
                sql = sql.Replace("<<FK>>", fk);

                try
                {

                    conn.Open();

                }
                catch
                {

                    continue;
                }

                SqlCommand cmd = new SqlCommand(sql, conn);

                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    DataRow dr = dt.NewRow();
                    dr[0] = sdr[0];
                    dr[1] = sdr[1];
                    dr[2] = sdr[2];
                    dr[3] = sdr[3];
                    dr[4] = sdr[4];
                    dr[5] = sdr[5];
                    dr[6] = sdr[6];
                    dr[7] = sdr[7];
                    dr[8] = key;
                    dt.Rows.Add(dr);
                }

                conn.Close();
            }

            Dictionary<long, long> lc1 = new Dictionary<long, long>();
            Dictionary<long, long> lc2 = new Dictionary<long, long>();

            foreach (DataRow dr in dt.Rows)
            {
                long ln = (long)dr[6];
                string cont = (string)dr[1];
                //if (Regex.IsMatch(cont, ".*" + query.Replace("%", ".*") + ".*"))
                if(cont.ToUpper().Contains(query))
                {
                    if (lc1.ContainsKey(ln))
                    {
                        lc1[ln]++;
                    }
                    else
                    {
                        lc1.Add(ln, 1);
                    }
                }


                if (Regex.IsMatch(cont, ll.Replace("%", ".*")))
                {
                    if (lc2.ContainsKey(ln))
                    {
                        lc2[ln]++;
                    }
                    else
                    {
                        lc2.Add(ln, 1);
                    }
                }
            }

            //List<long> lins = (from l in LineCount.Values
            //                   where l > 1
            //                   select l).ToList<long>();

            DataTable dt2 = dt.Clone();

            //foreach (DataRow dr in dt.Rows)
            for(int j = 0; j < dt.Rows.Count; j++)
            {
                DataRow dr = dt.Rows[j];
                long ln = (long)dr[6];



                if (lc1.ContainsKey(ln))
                {
                    //if (LineCount[ln] > 1)
                    //{



                        //dt2.Rows.Add(dr);


 


                        DataRow dr2 = dt2.NewRow();
                        dr2[0] = dr[0];
                        dr2[1] = dr[1];
                        dr2[2] = dr[2];
                        dr2[3] = dr[3];
                        dr2[4] = dr[4];
                        dr2[5] = dr[5];
                        dr2[6] = dr[6];
                        dr2[7] = dr[7];
                        dr2[8] = dr[8];

                        if (lc1.ContainsKey(ln) && lc2.ContainsKey(ln))
                        {
                            dr2[9] = "(!)";
                        }
                        else
                        {
                            dr2[9] = "";
                        }


                        dt2.Rows.Add(dr2);
                    
                    
                    
                    
                    
                    //}
                }
            }

            DataSet dtst = new DataSet();

            dtst.Tables.Add(dt2);

            return dtst;

        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.Write(ex.Message);
            return null;
        }
        finally
        {
            if (conn != null)
            {
                conn.Close();
            }
        }
    }
    public static DataSet QueryDB(string query)
    {
        if (query == null) return null;

        query = query.Trim();

        if (query == "") return null;

        query = query.Replace(' ', '%');
        query = query.Replace("'", "%");
        query = query.Replace("%%", "%");

        SqlConnection conn = null;
        try
        {
            DataTable dt = new DataTable();

            dt.Columns.Add(new DataColumn("SequenceNumber", typeof(System.Int64)));
            dt.Columns.Add(new DataColumn("FileContent", typeof(System.String)));
            dt.Columns.Add(new DataColumn("UserID", typeof(System.Int64)));
            dt.Columns.Add(new DataColumn("FileType", typeof(System.String)));
            dt.Columns.Add(new DataColumn("FileDesc", typeof(System.String)));
            dt.Columns.Add(new DataColumn("FileKey", typeof(System.Int64)));
            dt.Columns.Add(new DataColumn("LineNumber", typeof(System.Int64)));
            dt.Columns.Add(new DataColumn("CreatedOn", typeof(System.DateTime)));
            dt.Columns.Add(new DataColumn("SourceDB", typeof(System.Int64)));

            foreach (int key in connections.Keys)
            {
                if (key == 0) continue;
                if (key > 32) continue;
                conn = connections[key];
                string sql = @"
SELECT top 1000 
[SequenceNumber]
,[FileContent]
,-1 as [UserID]
,[FileType]
,'' as [FileDesc]
,[FileKey]
,[LineNumber]
,[CreatedOn]
FROM node with (nolock)

where filecontent like '%<<QUERY>>%'

";
                sql = sql.Replace("<<QUERY>>", query);
                

                conn.Open();

                SqlCommand cmd = new SqlCommand(sql, conn);

                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    DataRow dr = dt.NewRow();
                    dr[0] = sdr[0];
                    dr[1] = sdr[1];
                    dr[2] = sdr[2];
                    dr[3] = sdr[3];
                    dr[4] = sdr[4];
                    dr[5] = sdr[5];
                    dr[6] = sdr[6];
                    dr[7] = sdr[7];
                    dr[8] = key;
                    dt.Rows.Add(dr);
                }

                conn.Close();
            }

            DataSet dtst = new DataSet();

            dtst.Tables.Add(dt);

            return dtst;

        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.Write(ex.Message);
            return null;
        }
        finally
        {
            if (conn != null)
            {
                conn.Close();
            }
        }
    }
//    public static string GetHeaderRow(long fileKey)
//    {
//        try
//        {
//            StringBuilder sb = new StringBuilder();

//            foreach (int key in connections.Keys)
//            {
//                if (key == 0) continue;
//                if (key > 32) continue;
//                SqlConnection conn = null;

//                try
//                {
//                    conn = new SqlConnection(connections[key].ConnectionString); // connections[key];

//                    string sql = @"
//SELECT 
//[FileContent]
//FROM data
//where linenumber = 0 and filekey = @fk
//order by sequencenumber
//";

//                    if (conn.State != ConnectionState.Open)
//                    {
//                        conn.Open();
//                    }

//                    SqlCommand cmd = new SqlCommand(sql, conn);

//                    cmd.Parameters.Add(new SqlParameter("@fk", fileKey));

//                    SqlDataAdapter sda = new SqlDataAdapter(cmd);

//                    DataTable dt = new DataTable();

//                    sda.Fill(dt);

//                    if (dt != null && dt.Rows.Count > 0)
//                    {
//                        foreach (DataRow dr in dt.Rows)
//                        {
//                            sb.Append(dr[0].ToString());
//                        }

//                        break;
//                    }
//                }
//                catch (Exception ex)
//                {
//                    System.Diagnostics.Debug.Write(ex.Message);
//                }
//                finally
//                {
//                    conn.Close();
//                }
//            }
//            return sb.ToString().Trim();
//        }
//        catch (Exception ex)
//        {
//            return ex.Message;
//        }
//    }
}