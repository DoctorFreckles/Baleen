using System;
using System.IO;
using System.Collections.Generic;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Net;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public class GeoLocation
{
    private static string ApiUrl = "http://ipinfodb.com/ip_query.php?ip={0}";
    public static Dictionary<string,string> GetUserLocation(string ipAddress)
    {
        if (string.IsNullOrEmpty(ipAddress))
        {
            return null;
        }
        string reqUrl = string.Format(ApiUrl, ipAddress);
        HttpWebRequest httpReq = HttpWebRequest.Create(reqUrl) as HttpWebRequest;
        try
        {
            string result = string.Empty;
            HttpWebResponse response = httpReq.GetResponse() as HttpWebResponse;
            using (var reader = new StreamReader(response.GetResponseStream()))
            {
                result = reader.ReadToEnd();
            }

            Dictionary<string, string> step1 = ProcessResponse(result);

            if (step1 == null)
            {
                step1 = new Dictionary<string, string>();
            }

            step1.Add("IPAddress", ipAddress);

            return step1;
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.Write(ex.Message);
            Dictionary<string,string> retVal = new Dictionary<string,string>();
            retVal.Add("IPAddress", ipAddress);
            return retVal;
        }
    }
    private static Dictionary<string,string> ProcessResponse(string strResp)
    {
        StringReader sr = new StringReader(strResp);
        XElement respElement = XElement.Load(sr);
        string callStatus = (string)respElement.Element("Status");
        if (string.Compare(callStatus, "OK", true) != 0)
        {
            return null;
        }
        Dictionary<string,string> rec = new Dictionary<string,string>();

        rec.Add("City", (string)respElement.Element("City"));
        rec.Add("Country", (string)respElement.Element("CountryName"));
        rec.Add("Region", (string)respElement.Element("RegionName"));
        rec.Add("LAT", (string)respElement.Element("Latitude"));
        rec.Add("LON", (string)respElement.Element("Longitude"));

        return rec;
    }
}
