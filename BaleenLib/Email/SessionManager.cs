using System;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public class CassSession
{
    //string ip = IpAddress();

    //http://ipinfodb.com/ip_query.php?ip=
    //<Response>
    //<Ip>75.151.124.33</Ip>
    //<Status>OK</Status>
    //<CountryCode>US</CountryCode>
    //<CountryName>United States</CountryName>
    //<RegionCode>53</RegionCode>
    //<RegionName>Washington</RegionName>
    //<City>Seattle</City>
    //<ZipPostalCode/>
    //<Latitude>47.5951</Latitude>
    //<Longitude>-122.333</Longitude>
    //<Timezone>0</Timezone>
    //<Gmtoffset>0</Gmtoffset>
    //<Dstoffset>0</Dstoffset>
    //</Response>


    public long DailyLoginCount = 0;
    public DateTime Created
    {
        get { return CreatedDateTime; }
    }
    private DateTime CreatedDateTime = DateTime.Now;

    public string CountryName = "";
    public string RegionName = "";
    public string City = "";
    public double Lat = 0.0;
    public double Lon = 0.0;

    public string UserHostAddress = "";
    //dictionaries of other data
    public Dictionary<string, DateTime> UserHostName = new Dictionary<string, DateTime>();
    public Dictionary<string, DateTime> UserHostAgent = new Dictionary<string, DateTime>();
}

public class SessionManager
{
    private Dictionary<string, CassSession> DailySessions = new Dictionary<string, CassSession>();

    public Dictionary<string,string> IpGeoLocation(HttpRequest req)
    {
        string strIpAddress;
        strIpAddress = req.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (strIpAddress == null)
        {
            strIpAddress = req.ServerVariables["REMOTE_ADDR"];
        }
        return GeoLocation.GetUserLocation(strIpAddress);
    }

    public void AddSession(HttpRequest req)
    {
        try
        {
            Dictionary<string,string> reqinfo = IpGeoLocation(req);

            if (reqinfo == null) return;

            string key = reqinfo["IPAddress"];

            if (!DailySessions.ContainsKey(key))
            {
                CassSession cass = new CassSession();
                cass.UserHostAddress = key;

                if (reqinfo.ContainsKey("Country"))
                {
                    cass.CountryName = reqinfo["Country"];
                }

                if (reqinfo.ContainsKey("Region"))
                {
                    cass.RegionName = reqinfo["Region"];
                }

                if (reqinfo.ContainsKey("LAT"))
                {
                    try
                    {
                        cass.Lat = double.Parse(reqinfo["LAT"]);
                    }
                    catch { }
                }

                if (reqinfo.ContainsKey("LON"))
                {
                    try
                    {
                        cass.Lon = double.Parse(reqinfo["LON"]);
                    }
                    catch { }
                }

                if (reqinfo.ContainsKey("City"))
                {
                    cass.City = reqinfo["City"];
                }

                DailySessions.Add(key, cass);
            }
            if (!DailySessions[key].UserHostAgent.ContainsKey(req.UserAgent.Trim().ToUpper()))
            {
                DailySessions[key].UserHostAgent.Add(req.UserAgent.Trim().ToUpper(), DateTime.Now);
            }
            if (!DailySessions[key].UserHostName.ContainsKey(req.UserHostName.Trim().ToUpper()))
            {
                DailySessions[key].UserHostName.Add(req.UserHostName.Trim().ToUpper(), DateTime.Now);
            }
            DailySessions[key].DailyLoginCount++;
        }
        catch { }
    }

    public void WriteOutSessions()
    {
        try
        {
            string savePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "App_data") + "\\SESSIONS\\";

            string fileKey = DateTime.Now.Year.ToString() + "-" +
                DateTime.Now.Month.ToString() + "-" +
                DateTime.Now.Day.ToString() + "-" + 
                DateTime.Now.Hour.ToString() + ".txt";

            StreamWriter sw = new StreamWriter(savePath + fileKey);

            sw.Write("IP Address");
            sw.Write('\t');
            sw.Write("Count Of Sessions");
            sw.Write('\t');
            sw.Write("Host Names");
            sw.Write('\t');
            sw.Write("Host Agent");
            sw.WriteLine();

            foreach (string key in this.DailySessions.Keys)
            {
                sw.Write(key);
                sw.Write('\t');
                sw.Write(this.DailySessions[key].DailyLoginCount.ToString());
                sw.Write('\t');

                StringBuilder hname = new StringBuilder();

                foreach (string key2 in this.DailySessions[key].UserHostName.Keys)
                {
                    hname.Append(key2).Append(' ');
                }

                sw.Write(hname.ToString().Trim().Replace(' ', ','));
                sw.Write('\t');

                StringBuilder hagt = new StringBuilder();

                foreach (string key2 in this.DailySessions[key].UserHostAgent.Keys)
                {
                    hagt.Append(key2).Append(' ');
                }

                sw.Write(hagt.ToString().Trim().Replace(' ', ','));
                sw.WriteLine();
            }
            sw.Close();
        }
        catch { }
    }
}
