using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.Data;
using System.IO;
using System.Net;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using iTextSharp.text.pdf;
using System.Security.Cryptography;
using System.Xml;
using System.Reflection;
using System.Xml.Linq;
using System.Net.Mail;
using MySql.Data.MySqlClient;

namespace BaleenLib.Utility
{
    public enum CellPhoneProvider
    {
        Sprint = 1,
        ATT = 2,
        Cingular = 3,
        Metrocall = 4,
        Nextel = 5,
        TMobile = 6,
        Verizon = 7,
        Virgin = 8
    }
    public class Tests
    {
        public static bool TestMysqlConnection(string connection)
        {
            try
            {
                MySqlConnection c = new MySqlConnection(connection);
                c.Open();
                return true;
            }
            catch(Exception ex)
            {
                Console.WriteLine(ex.Message);

                return false;
            }
        }
    }
    public class FieldTypeLookup
    {
        private static Dictionary<string, string> FTLookup = new Dictionary<string, string>();
        static FieldTypeLookup()
        {
            var assembly = Assembly.GetExecutingAssembly();
            var resourceName = "MySQL.Baleen.field_type_lookup.txt";
            List<string> lnstr = new List<string>();
            using (Stream stream = assembly.GetManifestResourceStream(resourceName))
            using (StreamReader reader = new StreamReader(stream))
            {
                while(!reader.EndOfStream)
                {
                    lnstr.Add(reader.ReadLine());
                }
                //string result = reader.ReadToEnd();
            }
            //string[] lns = File.ReadAllLines("field_type_lookup.txt");
            string[] lns = lnstr.ToArray<string>();
            for (int i = 1; i < lns.Length; i++)
            {
                string[] parts = lns[i].Split('\t');
                if (!FTLookup.ContainsKey(parts[0].Trim()))
                {
                    FTLookup.Add(parts[0].Trim().ToUpper(), parts[1].Trim().ToUpper());
                }
            }
        }
        public static string GetType(string ftName)
        {
            if (string.IsNullOrEmpty(ftName)) return "TXT";
            string key = ftName.Trim().ToUpper();
            if (FTLookup.ContainsKey(key))
            {
                return FTLookup[key];
            }
            else
            {
                return "TXT";
            }
        }
    }
    public class EmailResponse
    {
        public static void SmtpHtmlEmail(
            string ToAddress, 
            string FromAddress, 
            string MessageBody, 
            string Subject,
            string smtpEmailServer,
            string emailUserName,
            string emailPassWord,
            string fileAttachment
            )
        {
            try
            {
                System.Net.NetworkCredential cred = new System.Net.NetworkCredential(emailUserName, emailPassWord);
                System.Net.Mail.SmtpClient cln = new System.Net.Mail.SmtpClient();
                cln.Host = smtpEmailServer;
                cln.Credentials = cred;
                System.Net.Mail.MailMessage email = new System.Net.Mail.MailMessage();
                email.From = new MailAddress(FromAddress);
                email.To.Add(ToAddress);
                email.Subject = Subject;
                email.IsBodyHtml = true;
                if (fileAttachment != null)
                {
                    System.Net.Mail.Attachment attch = new Attachment(fileAttachment);
                    email.Attachments.Add(attch);
                }
                email.DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure;
                email.Body = MessageBody;
                cln.Send(email);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }
        public static void AsciiEmail(
            string ToAddress, 
            string FromAddress, 
            string MessageBody, 
            string Subject,
            string smtpEmailServer,
            string emailUserName,
            string emailPassWord
            )
        {
            try
            {
                System.Net.NetworkCredential cred = new System.Net.NetworkCredential(emailUserName, emailPassWord);
                System.Net.Mail.SmtpClient cln = new System.Net.Mail.SmtpClient();
                cln.Host = smtpEmailServer;
                cln.Credentials = cred;
                System.Net.Mail.MailMessage email = new System.Net.Mail.MailMessage();

                email.BodyEncoding = System.Text.Encoding.ASCII;

                email.From = new MailAddress(FromAddress);
                email.To.Add(ToAddress);
                email.Subject = Subject;
                email.IsBodyHtml = true;
                email.DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure;
                email.Body = MessageBody;

                cln.Send(email);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }
    }
    public class GeoLocation
    {
        private static string ApiUrl = "http://ipinfodb.com/ip_query.php?ip={0}";
        public static Dictionary<string, string> GetUserLocation(string ipAddress)
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
                Dictionary<string, string> retVal = new Dictionary<string, string>();
                retVal.Add("IPAddress", ipAddress);
                return retVal;
            }
        }
        private static Dictionary<string, string> ProcessResponse(string strResp)
        {
            StringReader sr = new StringReader(strResp);
            XElement respElement = XElement.Load(sr);
            string callStatus = (string)respElement.Element("Status");
            if (string.Compare(callStatus, "OK", true) != 0)
            {
                return null;
            }
            Dictionary<string, string> rec = new Dictionary<string, string>();

            rec.Add("City", (string)respElement.Element("City"));
            rec.Add("Country", (string)respElement.Element("CountryName"));
            rec.Add("Region", (string)respElement.Element("RegionName"));
            rec.Add("LAT", (string)respElement.Element("Latitude"));
            rec.Add("LON", (string)respElement.Element("Longitude"));

            return rec;
        }
    }
    public class WebUtil
    {
        public static string GetHtmlTable(DataTable dt)
        {
            if(dt == null) return "";
            if(dt.Rows.Count < 1) return "";
            StringBuilder table = new StringBuilder();
            table.Append("<table style='font-family: Arial; vertical-align: text-top;' border='1'>");
            table.Append("<tr style='background-color: Blue; color: Yellow; font-size:12pt;'>");
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                table.Append("<td valign='top'>");
                table.Append("<b>");
                table.Append(dt.Columns[i].ColumnName);
                table.Append("</b>");
                table.Append("</td>");
            }
            table.Append("</tr>");
            foreach(DataRow dr in dt.Rows)
            {
                table.Append("<tr>");
                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    string s = dr[i].ToString();
                    s = RegexHelper.SplitWS.Replace(s, " ").Trim();
                    table.Append("<td valign='top' style='font-size:10pt;'>");
                    if (String.IsNullOrEmpty(s))
                    {
                        s = "*";
                    }
                    if (s.Length > 100)
                    {
                        table.Append("<textarea cols='20' rows='5'>");
                        table.Append(s.Trim());
                        table.Append("</textarea>");
                    }
                    else
                    {
                        table.Append(s.Trim());
                    }
                    table.Append("</td>");
                }
                table.Append("</tr>");
            }
            table.Append("</table>");
            return table.ToString();
        }
        public static void DownLoadFile(string FileNameAndPath, string SourceFileURL)
        {
            //			string myStringWebResource = null;
            WebClient myWebClient = new WebClient();
            try
            {
                myWebClient.DownloadFile(SourceFileURL, FileNameAndPath);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }
        public static string DynamicImageFromText5(string text)
        {
            if (text == null) return null;

            text = text.Trim();

            text = text.Replace('\r', ' ');
            text = text.Replace('\n', ' ');

            string[] parts = Regex.Split(text, @"\s+");

            List<string> just = new List<string>();

            StringBuilder buf = new StringBuilder();

            foreach (string p in parts)
            {
                string tok = p.Trim().ToUpper() + ' ';
                buf.Append(tok);
                if (buf.ToString().Trim().Length > 40)
                {
                    just.Add(buf.ToString().Trim());
                    buf = new StringBuilder();
                }
            }

            if (buf.Length > 0)
            {
                just.Add(buf.ToString().Trim());
            }

            List<string> just2 = new List<string>();

            foreach (string s in just)
            {
                if (s.Length <= 40)
                {
                    just2.Add(s);
                }
                else
                {
                    StringBuilder sb = new StringBuilder();
                    foreach (char c in s)
                    {
                        sb.Append(c);
                        if (sb.Length >= 40)
                        {
                            just2.Add(sb.ToString());
                            sb = new StringBuilder();
                        }
                    }
                    if (sb.Length > 0)
                    {
                        just2.Add(sb.ToString());
                    }
                }
            }







            //foreach (char c in text)
            //{

            //    buf.Append(c);

            //    if (buf.Length > 40)
            //    {
            //        yy++;
            //        just.Add(buf.ToString().Trim());
            //        buf = new StringBuilder();
            //    }
            //}

            //if (buf.Length > 0)
            //{
            //    yy++;
            //    just.Add(buf.ToString());
            //}


            Bitmap bitMapImage = new Bitmap(40 * 20, just2.Count * 20); //new Bitmap(@"C:\Users\daniel\Desktop\Untitled.jpg");

            for (int x = 0; x < bitMapImage.Width; x++)
            {
                for (int y = 0; y < bitMapImage.Height; y++)
                {
                    bitMapImage.SetPixel(x, y, Color.LightBlue);
                }
            }

            Graphics graphicImage = Graphics.FromImage(bitMapImage);

            graphicImage.SmoothingMode = SmoothingMode.AntiAlias;

            int lnIncr = 0;

            foreach (string ln in just)
            {


                graphicImage.DrawString(ln, new Font("Courier New", 12, FontStyle.Bold),
                    SystemBrushes.WindowText, new Point(5, 5 + lnIncr));



                lnIncr += 25;
            }

            //graphicImage.DrawArc(new Pen(Color.Red, 3), 90, 235, 150, 50, 0, 360); 
            //Response.ContentType = "image/jpeg";
            ////Save the new image to the response output stream.

            //bitMapImage.Save(@"C:\Users\daniel\Desktop\test.jpg", ImageFormat.Jpeg); 

            graphicImage.Dispose();

            MemoryStream mem = new MemoryStream();
            bitMapImage.Save(mem, ImageFormat.Jpeg);
            byte[] buffer = mem.ToArray();

            string b64 = Convert.ToBase64String(buffer);

            //StringBuilder sb = new StringBuilder();

            //for (int y = 0; y < bitMapImage.Height; y++)
            //{
            //    for (int x = 0; x < bitMapImage.Width; x++)
            //    {
            //        Color c = bitMapImage.GetPixel(x, y);
            //        String strHtmlColor = System.Drawing.ColorTranslator(c);
            //        sb.Append(strHtmlColor);
            //    }
            //    sb.Append('\r').Append('\n');
            //}

            bitMapImage.Dispose();

            return b64;
        }
        public static string DynamicImageFromText4(string text, Brush brush, int limitWidth)
        {
            if (text == null) return null;

            bool limWid = false;

            if (limitWidth > 0) limWid = true;

            //string[] txt = Regex.Split(text, @"\s+");

            //List<string> toks = new List<string>();

            //foreach (string t in txt)
            //{
            //    string t2 = t.Trim();
            //    if (t2.Length < 1) continue;
            //    toks.Add(t);
            //}

            int maxWid = 40;

            if (limWid)
            {
                maxWid = limitWidth;
            }

            text = text.Replace('\r', ' ');
            text = text.Replace('\n', ' ');

            text = text.Trim();

            List<string> just = new List<string>();

            StringBuilder buf = new StringBuilder();

            int yy = 0;

            foreach (char c in text)
            {

                buf.Append(c);

                if (buf.Length > maxWid)
                {
                    yy++;
                    just.Add(buf.ToString().Trim());
                    buf = new StringBuilder();



                }
            }

            if (buf.Length > 0)
            {
                yy++;
                just.Add(buf.ToString());
            }

            Bitmap bitMapImage = new Bitmap(maxWid * 37, yy * 65); //new Bitmap(@"C:\Users\daniel\Desktop\Untitled.jpg");

            for (int x = 0; x < bitMapImage.Width; x++)
            {
                for (int y = 0; y < bitMapImage.Height; y++)
                {
                    bitMapImage.SetPixel(x, y, Color.LightBlue);
                }
            }

            Graphics graphicImage = Graphics.FromImage(bitMapImage);

            graphicImage.SmoothingMode = SmoothingMode.AntiAlias;

            int lnIncr = 0;

            foreach (string ln in just)
            {
                graphicImage.DrawString(ln, new Font("Courier New", 42, FontStyle.Bold),
                    brush, new Point(5, 5 + lnIncr));

                lnIncr += 65;
            }

            //graphicImage.DrawArc(new Pen(Color.Red, 3), 90, 235, 150, 50, 0, 360); 
            //Response.ContentType = "image/jpeg";
            ////Save the new image to the response output stream.

            //bitMapImage.Save(@"C:\Users\daniel\Desktop\test.jpg", ImageFormat.Jpeg); 

            graphicImage.Dispose();

            MemoryStream mem = new MemoryStream();
            bitMapImage.Save(mem, ImageFormat.Jpeg);
            byte[] buffer = mem.ToArray();

            string b64 = Convert.ToBase64String(buffer);

            //StringBuilder sb = new StringBuilder();

            //for (int y = 0; y < bitMapImage.Height; y++)
            //{
            //    for (int x = 0; x < bitMapImage.Width; x++)
            //    {
            //        Color c = bitMapImage.GetPixel(x, y);
            //        String strHtmlColor = System.Drawing.ColorTranslator(c);
            //        sb.Append(strHtmlColor);
            //    }
            //    sb.Append('\r').Append('\n');
            //}

            bitMapImage.Dispose();

            return b64;
        }
        public static string DynamicImageFromText3(string text, Brush brush, int limitLines)
        {
            if (text == null) return null;

            bool limLines = false;

            if (limitLines > 0) limLines = true;

            //string[] txt = Regex.Split(text, @"\s+");

            //List<string> toks = new List<string>();

            //foreach (string t in txt)
            //{
            //    string t2 = t.Trim();
            //    if (t2.Length < 1) continue;
            //    toks.Add(t);
            //}

            text = text.Replace('\r', ' ');
            text = text.Replace('\n', ' ');

            text = text.Trim();

            List<string> just = new List<string>();

            StringBuilder buf = new StringBuilder();

            int yy = 0;

            foreach (char c in text)
            {

                buf.Append(c);

                if (buf.Length > 40)
                {
                    yy++;

                    if (limLines)
                    {
                        if (limitLines < yy) break;
                    }

                    just.Add(buf.ToString().Trim());
                    buf = new StringBuilder();



                }
            }

            if (buf.Length > 0)
            {
                yy++;

                if (limLines)
                {
                    if (!(limitLines < yy))
                    {
                        just.Add(buf.ToString());
                    }
                }
                else just.Add(buf.ToString());
            }

            Bitmap bitMapImage = new Bitmap(40 * 37, yy * 65); //new Bitmap(@"C:\Users\daniel\Desktop\Untitled.jpg");

            for (int x = 0; x < bitMapImage.Width; x++)
            {
                for (int y = 0; y < bitMapImage.Height; y++)
                {
                    bitMapImage.SetPixel(x, y, Color.LightBlue);
                }
            }

            Graphics graphicImage = Graphics.FromImage(bitMapImage);

            graphicImage.SmoothingMode = SmoothingMode.HighQuality;

            int lnIncr = 0;



            foreach (string ln in just)
            {


                graphicImage.DrawString(ln, new Font("Courier New", 42, FontStyle.Bold),
                    brush, new Point(5, 5 + lnIncr));



                lnIncr += 65;
            }

            //graphicImage.DrawArc(new Pen(Color.Red, 3), 90, 235, 150, 50, 0, 360); 
            //Response.ContentType = "image/jpeg";
            ////Save the new image to the response output stream.

            //bitMapImage.Save(@"C:\Users\daniel\Desktop\test.jpg", ImageFormat.Jpeg); 

            graphicImage.Dispose();

            MemoryStream mem = new MemoryStream();
            bitMapImage.Save(mem, ImageFormat.Jpeg);
            byte[] buffer = mem.ToArray();

            string b64 = Convert.ToBase64String(buffer);

            //StringBuilder sb = new StringBuilder();

            //for (int y = 0; y < bitMapImage.Height; y++)
            //{
            //    for (int x = 0; x < bitMapImage.Width; x++)
            //    {
            //        Color c = bitMapImage.GetPixel(x, y);
            //        String strHtmlColor = System.Drawing.ColorTranslator(c);
            //        sb.Append(strHtmlColor);
            //    }
            //    sb.Append('\r').Append('\n');
            //}

            bitMapImage.Dispose();

            return b64;
        }
        public static string DynamicImageFromText2(string text)
        {
            if (text == null) return null;

            text = text.Trim();

            text = text.Replace('\r', ' ');
            text = text.Replace('\n', ' ');

            List<string> just = new List<string>();

            StringBuilder buf = new StringBuilder();

            int yy = 0;

            foreach (char c in text)
            {

                buf.Append(c);

                if (buf.Length > 40)
                {
                    yy++;
                    just.Add(buf.ToString().Trim());
                    buf = new StringBuilder();
                }
            }

            if (buf.Length > 0)
            {
                yy++;
                just.Add(buf.ToString());
            }


            Bitmap bitMapImage = new Bitmap(40 * 12, yy * 25); //new Bitmap(@"C:\Users\daniel\Desktop\Untitled.jpg");

            for (int x = 0; x < bitMapImage.Width; x++)
            {
                for (int y = 0; y < bitMapImage.Height; y++)
                {
                    bitMapImage.SetPixel(x, y, Color.LightBlue);
                }
            }

            Graphics graphicImage = Graphics.FromImage(bitMapImage);

            graphicImage.SmoothingMode = SmoothingMode.AntiAlias;

            int lnIncr = 0;

            foreach (string ln in just)
            {


                graphicImage.DrawString(ln, new Font("Courier New", 12, FontStyle.Bold),
                    SystemBrushes.WindowText, new Point(5, 5 + lnIncr));



                lnIncr += 25;
            }

            //graphicImage.DrawArc(new Pen(Color.Red, 3), 90, 235, 150, 50, 0, 360); 
            //Response.ContentType = "image/jpeg";
            ////Save the new image to the response output stream.

            //bitMapImage.Save(@"C:\Users\daniel\Desktop\test.jpg", ImageFormat.Jpeg); 

            graphicImage.Dispose();

            MemoryStream mem = new MemoryStream();
            bitMapImage.Save(mem, ImageFormat.Jpeg);
            byte[] buffer = mem.ToArray();

            string b64 = Convert.ToBase64String(buffer);

            //StringBuilder sb = new StringBuilder();

            //for (int y = 0; y < bitMapImage.Height; y++)
            //{
            //    for (int x = 0; x < bitMapImage.Width; x++)
            //    {
            //        Color c = bitMapImage.GetPixel(x, y);
            //        String strHtmlColor = System.Drawing.ColorTranslator(c);
            //        sb.Append(strHtmlColor);
            //    }
            //    sb.Append('\r').Append('\n');
            //}

            bitMapImage.Dispose();

            return b64;
        }
        public static string DynamicImageFromText(string text)
        {
            Bitmap bitMapImage = new Bitmap(337, 34); //new Bitmap(@"C:\Users\daniel\Desktop\Untitled.jpg");

            for (int x = 0; x < bitMapImage.Width; x++)
            {
                for (int y = 0; y < bitMapImage.Height; y++)
                {
                    bitMapImage.SetPixel(x, y, Color.LightBlue);
                }
            }

            Graphics graphicImage = Graphics.FromImage(bitMapImage);

            graphicImage.SmoothingMode = SmoothingMode.AntiAlias;
            graphicImage.DrawString(text, new Font("Arial", 12, FontStyle.Bold),
                SystemBrushes.WindowText, new Point(5, 5));

            //graphicImage.DrawArc(new Pen(Color.Red, 3), 90, 235, 150, 50, 0, 360); 
            //Response.ContentType = "image/jpeg";
            ////Save the new image to the response output stream.

            //bitMapImage.Save(@"C:\Users\daniel\Desktop\test.jpg", ImageFormat.Jpeg); 

            graphicImage.Dispose();

            MemoryStream mem = new MemoryStream();
            bitMapImage.Save(mem, ImageFormat.Jpeg);
            byte[] buffer = mem.ToArray();

            string b64 = Convert.ToBase64String(buffer);

            //StringBuilder sb = new StringBuilder();

            //for (int y = 0; y < bitMapImage.Height; y++)
            //{
            //    for (int x = 0; x < bitMapImage.Width; x++)
            //    {
            //        Color c = bitMapImage.GetPixel(x, y);
            //        String strHtmlColor = System.Drawing.ColorTranslator(c);
            //        sb.Append(strHtmlColor);
            //    }
            //    sb.Append('\r').Append('\n');
            //}

            bitMapImage.Dispose();

            return b64;
        }
        public static string GetMd5Sum(string str)
        {
            System.Text.Encoder enc = System.Text.Encoding.Unicode.GetEncoder();
            byte[] unicodeText = new byte[str.Length * 2];
            enc.GetBytes(str.ToCharArray(), 0, str.Length, unicodeText, 0, true);
            MD5 md5 = new MD5CryptoServiceProvider();
            byte[] result = md5.ComputeHash(unicodeText);
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < result.Length; i++)
            {
                sb.Append(result[i].ToString("X2"));
            }
            return sb.ToString();
        }
    }
    public class WebData
    {
        public static void GetDowScores()
        {
            try
            {
                //http://www.google.com/finance/historical?q=INDEXDJX:.DJI&histperiod=weekly

                StringBuilder sb = new StringBuilder();
                byte[] buf = new byte[8192];

                HttpWebRequest request = (HttpWebRequest)
                    WebRequest.Create(System.Web.HttpUtility.HtmlEncode("http://www.google.com/finance/historical?q=INDEXDJX:.DJI&histperiod=weekly"));

                HttpWebResponse response = (HttpWebResponse)
                    request.GetResponse();

                Stream resStream = response.GetResponseStream();

                string tempString = null;
                int count = 0;

                do
                {
                    count = resStream.Read(buf, 0, buf.Length);
                    if (count != 0)
                    {
                        tempString = Encoding.ASCII.GetString(buf, 0, count);
                        sb.Append(tempString);
                    }
                }
                while (count > 0);

                resStream.Close();

                string savePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "App_data") + "\\DOW\\";

                string fileKey = DateTime.Now.Year.ToString() + "-" +
                    DateTime.Now.Month.ToString() + "-" +
                    DateTime.Now.Day.ToString() + ".txt";
                File.WriteAllText(savePath + fileKey, sb.ToString());
            }
            catch
            {

            }
        }
        public static void GetArticles()
        {
            Dictionary<string, string> rssFeeds = new Dictionary<string, string>();

            rssFeeds.Add("http://rss.news.yahoo.com/rss/topstories", "Yahoo - Top Stories");
            rssFeeds.Add("http://rss.news.yahoo.com/rss/us", "Yahoo - US");
            rssFeeds.Add("http://rss.news.yahoo.com/rss/world", "Yahoo - World");
            rssFeeds.Add("http://rss.news.yahoo.com/rss/politics", "Yahoo - Politics");
            rssFeeds.Add("http://rss.news.yahoo.com/rss/business", "Yahoo - Business");
            rssFeeds.Add("http://rss.news.yahoo.com/rss/tech", "Yahoo - Technology");
            rssFeeds.Add("http://rss.news.yahoo.com/rss/entertainment", "Yahoo - Entertainment");
            rssFeeds.Add("http://rss.news.yahoo.com/rss/health", "Yahoo - Health");
            rssFeeds.Add("http://rss.news.yahoo.com/rss/science", "Yahoo - Science");
            rssFeeds.Add("http://rss.news.yahoo.com/rss/oped", "Yahoo - Opinion");
            rssFeeds.Add("http://rss.news.yahoo.com/rss/sports", "Yahoo - Sports");
            rssFeeds.Add("http://rss.news.yahoo.com/rss/oddlyenough", "Yahoo - Oddly Enough");
            rssFeeds.Add("http://rss.news.yahoo.com/rss/obits", "Yahoo - Obits");
            rssFeeds.Add("http://rss.news.yahoo.com/rss/mostviewed", "Yahoo - Most Viewed");
            rssFeeds.Add("http://www.npr.org/rss/rss.php?id=1001", "NPR News");

            string savePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "App_data") + "\\NEWS\\";

            foreach (string feed in rssFeeds.Keys)
            {
                string cat = rssFeeds[feed];

                string saveName = cat.Trim().ToUpper() + "_" + DateTime.Now.Year.ToString() + "_" +
                    DateTime.Now.Month.ToString() + "_" + DateTime.Now.Day.ToString() + "_" + DateTime.Now.Hour.ToString() + ".xml";
                DataSet dtst = null;
                try
                {
                    dtst = new DataSet();
                    dtst.ReadXml(feed);
                    dtst.WriteXml(savePath + saveName);
                    System.Diagnostics.Debug.WriteLine(feed);
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.Write(ex.Message);
                }
            }
        }
        public static string GetPageTextContent(string URL)
        {
            try
            {
                StringBuilder sb = new StringBuilder();
                byte[] buf = new byte[8192];

                HttpWebRequest request = (HttpWebRequest)
                    WebRequest.Create(System.Web.HttpUtility.HtmlEncode(URL));

                HttpWebResponse response = (HttpWebResponse)
                    request.GetResponse();

                Stream resStream = response.GetResponseStream();

                string tempString = null;
                int count = 0;

                do
                {
                    count = resStream.Read(buf, 0, buf.Length);
                    if (count != 0)
                    {
                        tempString = Encoding.ASCII.GetString(buf, 0, count);
                        sb.Append(tempString);
                    }
                }
                while (count > 0);

                resStream.Close();

                bool readVals = true;

                char[] chr = sb.ToString().ToCharArray();

                sb = new StringBuilder();

                foreach (char c in chr)
                {
                    if (c == '<')
                    {
                        readVals = false;
                    }
                    if (c == '>')
                    {
                        readVals = true;
                    }
                    if (readVals)
                    {
                        sb.Append(c);
                    }
                }

                string retVal = sb.ToString().Trim();

                if (retVal == null) return "";

                retVal = Regex.Replace(retVal, "\\s+", " ").Trim();

                if (retVal.Length < 20) return "";

                return retVal;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.Write(ex.Message);
                return null;
            }
        }
        public static List<string> GetNewsPageContent(string URL)
        {
            try
            {
                StringBuilder sb = new StringBuilder();
                byte[] buf = new byte[8192];

                HttpWebRequest request = (HttpWebRequest)
                    WebRequest.Create(System.Web.HttpUtility.HtmlEncode(URL));

                HttpWebResponse response = (HttpWebResponse)
                    request.GetResponse();

                Stream resStream = response.GetResponseStream();

                string tempString = null;
                int count = 0;

                do
                {
                    count = resStream.Read(buf, 0, buf.Length);
                    if (count != 0)
                    {
                        tempString = Encoding.ASCII.GetString(buf, 0, count);
                        sb.Append(tempString);
                    }
                }
                while (count > 0);

                resStream.Close();


                string[] parts = Regex.Split(sb.ToString(), "[<][/]?[pP][>]");

                StringBuilder sb3 = new StringBuilder();

                foreach (string par in parts)
                {
                    string p2 = System.Web.HttpUtility.HtmlDecode(par.Trim().ToUpper());
                    if (p2.Length > 50 && Char.IsLetterOrDigit(p2[0]))
                    {
                        sb3.Append(p2).Append(' ');
                    }
                }

                string[] text = sb3.ToString().Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);

                List<string> retList = new List<string>();

                foreach (string d in text)
                {
                    if (d.Contains("=")) continue;
                    if (d.Contains("<")) continue;
                    if (d.Contains(">")) continue;
                    if (d.Length > 20) continue;
                    retList.Add(d);
                }

                return retList;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.Write(ex.Message);
                return null;
            }
        }
    }
    public class ColorClass
    {
        public string Name = "";
        public string HEX = "";
        public int R = 0;
        public int G = 0;
        public int B = 0;
        public bool HasProperName = true;
        public string GetSmallName()
        {
            if (HasProperName)
            {
                StringBuilder sb = new StringBuilder();
                foreach (char c in this.Name)
                {
                    if (Char.IsLetter(c))
                    {
                        sb.Append(c);
                    }
                }
                return sb.ToString().Trim().ToUpper();
            }
            else
            {
                return "UNK";
            }
        }
        public ColorClass(string nm, string hx, int rc, int gc, int bc)
        {
            this.Name = nm;
            this.HEX = hx;
            this.R = rc;
            this.G = gc;
            this.B = bc;
        }
    }
    //http://developer.oodle.com/files/xml/oodle_categories.xml
    public class UtilityMain
    {
        public static Regex DateTimeMatch = new Regex(@"^(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|((([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})(\s(((0[1-9])|([1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$", RegexOptions.Compiled | RegexOptions.IgnorePatternWhitespace);

        private static List<ColorClass> colorList = new List<ColorClass>();
        static UtilityMain()
        {
            #region "Color List"

            colorList.Add(new ColorClass("INDIAN RED", "#B0171F", 176, 23, 31));
            colorList.Add(new ColorClass("CRIMSON", "#DC143C", 220, 20, 60));
            colorList.Add(new ColorClass("LIGHTPINK", "#FFB6C1", 255, 182, 193));
            colorList.Add(new ColorClass("LIGHTPINK 1", "#FFAEB9", 255, 174, 185));
            colorList.Add(new ColorClass("LIGHTPINK 2", "#EEA2AD", 238, 162, 173));
            colorList.Add(new ColorClass("LIGHTPINK 3", "#CD8C95", 205, 140, 149));
            colorList.Add(new ColorClass("LIGHTPINK 4", "#8B5F65", 139, 95, 101));
            colorList.Add(new ColorClass("PINK", "#FFC0CB", 255, 192, 203));
            colorList.Add(new ColorClass("PINK 1", "#FFB5C5", 255, 181, 197));
            colorList.Add(new ColorClass("PINK 2", "#EEA9B8", 238, 169, 184));
            colorList.Add(new ColorClass("PINK 3", "#CD919E", 205, 145, 158));
            colorList.Add(new ColorClass("PINK 4", "#8B636C", 139, 99, 108));
            colorList.Add(new ColorClass("PALEVIOLETRED", "#DB7093", 219, 112, 147));
            colorList.Add(new ColorClass("PALEVIOLETRED 1", "#FF82AB", 255, 130, 171));
            colorList.Add(new ColorClass("PALEVIOLETRED 2", "#EE799F", 238, 121, 159));
            colorList.Add(new ColorClass("PALEVIOLETRED 3", "#CD6889", 205, 104, 137));
            colorList.Add(new ColorClass("PALEVIOLETRED 4", "#8B475D", 139, 71, 93));
            colorList.Add(new ColorClass("LAVENDERBLUSH 1", "#FFF0F5", 255, 240, 245));
            colorList.Add(new ColorClass("LAVENDERBLUSH 2", "#EEE0E5", 238, 224, 229));
            colorList.Add(new ColorClass("LAVENDERBLUSH 3", "#CDC1C5", 205, 193, 197));
            colorList.Add(new ColorClass("LAVENDERBLUSH 4", "#8B8386", 139, 131, 134));
            colorList.Add(new ColorClass("VIOLETRED 1", "#FF3E96", 255, 62, 150));
            colorList.Add(new ColorClass("VIOLETRED 2", "#EE3A8C", 238, 58, 140));
            colorList.Add(new ColorClass("VIOLETRED 3", "#CD3278", 205, 50, 120));
            colorList.Add(new ColorClass("VIOLETRED 4", "#8B2252", 139, 34, 82));
            colorList.Add(new ColorClass("HOTPINK", "#FF69B4", 255, 105, 180));
            colorList.Add(new ColorClass("HOTPINK 1", "#FF6EB4", 255, 110, 180));
            colorList.Add(new ColorClass("HOTPINK 2", "#EE6AA7", 238, 106, 167));
            colorList.Add(new ColorClass("HOTPINK 3", "#CD6090", 205, 96, 144));
            colorList.Add(new ColorClass("HOTPINK 4", "#8B3A62", 139, 58, 98));
            colorList.Add(new ColorClass("RASPBERRY", "#872657", 135, 38, 87));
            colorList.Add(new ColorClass("DEEPPINK", "#FF1493", 255, 20, 147));
            colorList.Add(new ColorClass("DEEPPINK 2", "#EE1289", 238, 18, 137));
            colorList.Add(new ColorClass("DEEPPINK 3", "#CD1076", 205, 16, 118));
            colorList.Add(new ColorClass("DEEPPINK 4", "#8B0A50", 139, 10, 80));
            colorList.Add(new ColorClass("MAROON 1", "#FF34B3", 255, 52, 179));
            colorList.Add(new ColorClass("MAROON 2", "#EE30A7", 238, 48, 167));
            colorList.Add(new ColorClass("MAROON 3", "#CD2990", 205, 41, 144));
            colorList.Add(new ColorClass("MAROON 4", "#8B1C62", 139, 28, 98));
            colorList.Add(new ColorClass("MEDIUMVIOLETRED", "#C71585", 199, 21, 133));
            colorList.Add(new ColorClass("VIOLETRED", "#D02090", 208, 32, 144));
            colorList.Add(new ColorClass("ORCHID", "#DA70D6", 218, 112, 214));
            colorList.Add(new ColorClass("ORCHID 1", "#FF83FA", 255, 131, 250));
            colorList.Add(new ColorClass("ORCHID 2", "#EE7AE9", 238, 122, 233));
            colorList.Add(new ColorClass("ORCHID 3", "#CD69C9", 205, 105, 201));
            colorList.Add(new ColorClass("ORCHID 4", "#8B4789", 139, 71, 137));
            colorList.Add(new ColorClass("THISTLE", "#D8BFD8", 216, 191, 216));
            colorList.Add(new ColorClass("THISTLE 1", "#FFE1FF", 255, 225, 255));
            colorList.Add(new ColorClass("THISTLE 2", "#EED2EE", 238, 210, 238));
            colorList.Add(new ColorClass("THISTLE 3", "#CDB5CD", 205, 181, 205));
            colorList.Add(new ColorClass("THISTLE 4", "#8B7B8B", 139, 123, 139));
            colorList.Add(new ColorClass("PLUM 1", "#FFBBFF", 255, 187, 255));
            colorList.Add(new ColorClass("PLUM 2", "#EEAEEE", 238, 174, 238));
            colorList.Add(new ColorClass("PLUM 3", "#CD96CD", 205, 150, 205));
            colorList.Add(new ColorClass("PLUM 4", "#8B668B", 139, 102, 139));
            colorList.Add(new ColorClass("PLUM", "#DDA0DD", 221, 160, 221));
            colorList.Add(new ColorClass("VIOLET", "#EE82EE", 238, 130, 238));
            colorList.Add(new ColorClass("FUCHSIA", "#FF00FF", 255, 0, 255));
            colorList.Add(new ColorClass("MAGENTA 2", "#EE00EE", 238, 0, 238));
            colorList.Add(new ColorClass("MAGENTA 3", "#CD00CD", 205, 0, 205));
            colorList.Add(new ColorClass("DARKMAGENTA", "#8B008B", 139, 0, 139));
            colorList.Add(new ColorClass("PURPLE*", "#800080", 128, 0, 128));
            colorList.Add(new ColorClass("MEDIUMORCHID", "#BA55D3", 186, 85, 211));
            colorList.Add(new ColorClass("MEDIUMORCHID 1", "#E066FF", 224, 102, 255));
            colorList.Add(new ColorClass("MEDIUMORCHID 2", "#D15FEE", 209, 95, 238));
            colorList.Add(new ColorClass("MEDIUMORCHID 3", "#B452CD", 180, 82, 205));
            colorList.Add(new ColorClass("MEDIUMORCHID 4", "#7A378B", 122, 55, 139));
            colorList.Add(new ColorClass("DARKVIOLET", "#9400D3", 148, 0, 211));
            colorList.Add(new ColorClass("DARKORCHID", "#9932CC", 153, 50, 204));
            colorList.Add(new ColorClass("DARKORCHID 1", "#BF3EFF", 191, 62, 255));
            colorList.Add(new ColorClass("DARKORCHID 2", "#B23AEE", 178, 58, 238));
            colorList.Add(new ColorClass("DARKORCHID 3", "#9A32CD", 154, 50, 205));
            colorList.Add(new ColorClass("DARKORCHID 4", "#68228B", 104, 34, 139));
            colorList.Add(new ColorClass("INDIGO", "#4B0082", 75, 0, 130));
            colorList.Add(new ColorClass("BLUEVIOLET", "#8A2BE2", 138, 43, 226));
            colorList.Add(new ColorClass("PURPLE 1", "#9B30FF", 155, 48, 255));
            colorList.Add(new ColorClass("PURPLE 2", "#912CEE", 145, 44, 238));
            colorList.Add(new ColorClass("PURPLE 3", "#7D26CD", 125, 38, 205));
            colorList.Add(new ColorClass("PURPLE 4", "#551A8B", 85, 26, 139));
            colorList.Add(new ColorClass("MEDIUMPURPLE", "#9370DB", 147, 112, 219));
            colorList.Add(new ColorClass("MEDIUMPURPLE 1", "#AB82FF", 171, 130, 255));
            colorList.Add(new ColorClass("MEDIUMPURPLE 2", "#9F79EE", 159, 121, 238));
            colorList.Add(new ColorClass("MEDIUMPURPLE 3", "#8968CD", 137, 104, 205));
            colorList.Add(new ColorClass("MEDIUMPURPLE 4", "#5D478B", 93, 71, 139));
            colorList.Add(new ColorClass("DARKSLATEBLUE", "#483D8B", 72, 61, 139));
            colorList.Add(new ColorClass("LIGHTSLATEBLUE", "#8470FF", 132, 112, 255));
            colorList.Add(new ColorClass("MEDIUMSLATEBLUE", "#7B68EE", 123, 104, 238));
            colorList.Add(new ColorClass("SLATEBLUE", "#6A5ACD", 106, 90, 205));
            colorList.Add(new ColorClass("SLATEBLUE 1", "#836FFF", 131, 111, 255));
            colorList.Add(new ColorClass("SLATEBLUE 2", "#7A67EE", 122, 103, 238));
            colorList.Add(new ColorClass("SLATEBLUE 3", "#6959CD", 105, 89, 205));
            colorList.Add(new ColorClass("SLATEBLUE 4", "#473C8B", 71, 60, 139));
            colorList.Add(new ColorClass("GHOSTWHITE", "#F8F8FF", 248, 248, 255));
            colorList.Add(new ColorClass("LAVENDER", "#E6E6FA", 230, 230, 250));
            colorList.Add(new ColorClass("BLUE*", "#0000FF", 0, 0, 255));
            colorList.Add(new ColorClass("BLUE 2", "#0000EE", 0, 0, 238));
            colorList.Add(new ColorClass("MEDIUMBLUE", "#0000CD", 0, 0, 205));
            colorList.Add(new ColorClass("DARKBLUE", "#00008B", 0, 0, 139));
            colorList.Add(new ColorClass("NAVY*", "#000080", 0, 0, 128));
            colorList.Add(new ColorClass("MIDNIGHTBLUE", "#191970", 25, 25, 112));
            colorList.Add(new ColorClass("COBALT", "#3D59AB", 61, 89, 171));
            colorList.Add(new ColorClass("ROYALBLUE", "#4169E1", 65, 105, 225));
            colorList.Add(new ColorClass("ROYALBLUE 1", "#4876FF", 72, 118, 255));
            colorList.Add(new ColorClass("ROYALBLUE 2", "#436EEE", 67, 110, 238));
            colorList.Add(new ColorClass("ROYALBLUE 3", "#3A5FCD", 58, 95, 205));
            colorList.Add(new ColorClass("ROYALBLUE 4", "#27408B", 39, 64, 139));
            colorList.Add(new ColorClass("CORNFLOWERBLUE", "#6495ED", 100, 149, 237));
            colorList.Add(new ColorClass("LIGHTSTEELBLUE", "#B0C4DE", 176, 196, 222));
            colorList.Add(new ColorClass("LIGHTSTEELBLUE 1", "#CAE1FF", 202, 225, 255));
            colorList.Add(new ColorClass("LIGHTSTEELBLUE 2", "#BCD2EE", 188, 210, 238));
            colorList.Add(new ColorClass("LIGHTSTEELBLUE 3", "#A2B5CD", 162, 181, 205));
            colorList.Add(new ColorClass("LIGHTSTEELBLUE 4", "#6E7B8B", 110, 123, 139));
            colorList.Add(new ColorClass("LIGHTSLATEGRAY", "#778899", 119, 136, 153));
            colorList.Add(new ColorClass("SLATEGRAY", "#708090", 112, 128, 144));
            colorList.Add(new ColorClass("SLATEGRAY 1", "#C6E2FF", 198, 226, 255));
            colorList.Add(new ColorClass("SLATEGRAY 2", "#B9D3EE", 185, 211, 238));
            colorList.Add(new ColorClass("SLATEGRAY 3", "#9FB6CD", 159, 182, 205));
            colorList.Add(new ColorClass("SLATEGRAY 4", "#6C7B8B", 108, 123, 139));
            colorList.Add(new ColorClass("DODGERBLUE 1", "#1E90FF", 30, 144, 255));
            colorList.Add(new ColorClass("DODGERBLUE 2", "#1C86EE", 28, 134, 238));
            colorList.Add(new ColorClass("DODGERBLUE 3", "#1874CD", 24, 116, 205));
            colorList.Add(new ColorClass("DODGERBLUE 4", "#104E8B", 16, 78, 139));
            colorList.Add(new ColorClass("ALICEBLUE", "#F0F8FF", 240, 248, 255));
            colorList.Add(new ColorClass("STEELBLUE", "#4682B4", 70, 130, 180));
            colorList.Add(new ColorClass("STEELBLUE 1", "#63B8FF", 99, 184, 255));
            colorList.Add(new ColorClass("STEELBLUE 2", "#5CACEE", 92, 172, 238));
            colorList.Add(new ColorClass("STEELBLUE 3", "#4F94CD", 79, 148, 205));
            colorList.Add(new ColorClass("STEELBLUE 4", "#36648B", 54, 100, 139));
            colorList.Add(new ColorClass("LIGHTSKYBLUE", "#87CEFA", 135, 206, 250));
            colorList.Add(new ColorClass("LIGHTSKYBLUE 1", "#B0E2FF", 176, 226, 255));
            colorList.Add(new ColorClass("LIGHTSKYBLUE 2", "#A4D3EE", 164, 211, 238));
            colorList.Add(new ColorClass("LIGHTSKYBLUE 3", "#8DB6CD", 141, 182, 205));
            colorList.Add(new ColorClass("LIGHTSKYBLUE 4", "#607B8B", 96, 123, 139));
            colorList.Add(new ColorClass("SKYBLUE 1", "#87CEFF", 135, 206, 255));
            colorList.Add(new ColorClass("SKYBLUE 2", "#7EC0EE", 126, 192, 238));
            colorList.Add(new ColorClass("SKYBLUE 3", "#6CA6CD", 108, 166, 205));
            colorList.Add(new ColorClass("SKYBLUE 4", "#4A708B", 74, 112, 139));
            colorList.Add(new ColorClass("SKYBLUE", "#87CEEB", 135, 206, 235));
            colorList.Add(new ColorClass("DEEPSKYBLUE 1", "#00BFFF", 0, 191, 255));
            colorList.Add(new ColorClass("DEEPSKYBLUE 2", "#00B2EE", 0, 178, 238));
            colorList.Add(new ColorClass("DEEPSKYBLUE 3", "#009ACD", 0, 154, 205));
            colorList.Add(new ColorClass("DEEPSKYBLUE 4", "#00688B", 0, 104, 139));
            colorList.Add(new ColorClass("PEACOCK", "#33A1C9", 51, 161, 201));
            colorList.Add(new ColorClass("LIGHTBLUE", "#ADD8E6", 173, 216, 230));
            colorList.Add(new ColorClass("LIGHTBLUE 1", "#BFEFFF", 191, 239, 255));
            colorList.Add(new ColorClass("LIGHTBLUE 2", "#B2DFEE", 178, 223, 238));
            colorList.Add(new ColorClass("LIGHTBLUE 3", "#9AC0CD", 154, 192, 205));
            colorList.Add(new ColorClass("LIGHTBLUE 4", "#68838B", 104, 131, 139));
            colorList.Add(new ColorClass("POWDERBLUE", "#B0E0E6", 176, 224, 230));
            colorList.Add(new ColorClass("CADETBLUE 1", "#98F5FF", 152, 245, 255));
            colorList.Add(new ColorClass("CADETBLUE 2", "#8EE5EE", 142, 229, 238));
            colorList.Add(new ColorClass("CADETBLUE 3", "#7AC5CD", 122, 197, 205));
            colorList.Add(new ColorClass("CADETBLUE 4", "#53868B", 83, 134, 139));
            colorList.Add(new ColorClass("TURQUOISE 1", "#00F5FF", 0, 245, 255));
            colorList.Add(new ColorClass("TURQUOISE 2", "#00E5EE", 0, 229, 238));
            colorList.Add(new ColorClass("TURQUOISE 3", "#00C5CD", 0, 197, 205));
            colorList.Add(new ColorClass("TURQUOISE 4", "#00868B", 0, 134, 139));
            colorList.Add(new ColorClass("CADETBLUE", "#5F9EA0", 95, 158, 160));
            colorList.Add(new ColorClass("DARKTURQUOISE", "#00CED1", 0, 206, 209));
            colorList.Add(new ColorClass("AZURE 1", "#F0FFFF", 240, 255, 255));
            colorList.Add(new ColorClass("AZURE 2", "#E0EEEE", 224, 238, 238));
            colorList.Add(new ColorClass("AZURE 3", "#C1CDCD", 193, 205, 205));
            colorList.Add(new ColorClass("AZURE 4", "#838B8B", 131, 139, 139));
            colorList.Add(new ColorClass("LIGHTCYAN 1", "#E0FFFF", 224, 255, 255));
            colorList.Add(new ColorClass("LIGHTCYAN 2", "#D1EEEE", 209, 238, 238));
            colorList.Add(new ColorClass("LIGHTCYAN 3", "#B4CDCD", 180, 205, 205));
            colorList.Add(new ColorClass("LIGHTCYAN 4", "#7A8B8B", 122, 139, 139));
            colorList.Add(new ColorClass("PALETURQUOISE 1", "#BBFFFF", 187, 255, 255));
            colorList.Add(new ColorClass("PALETURQUOISE 2", "#AEEEEE", 174, 238, 238));
            colorList.Add(new ColorClass("PALETURQUOISE 3", "#96CDCD", 150, 205, 205));
            colorList.Add(new ColorClass("PALETURQUOISE 4", "#668B8B", 102, 139, 139));
            colorList.Add(new ColorClass("DARKSLATEGRAY", "#2F4F4F", 47, 79, 79));
            colorList.Add(new ColorClass("DARKSLATEGRAY 1", "#97FFFF", 151, 255, 255));
            colorList.Add(new ColorClass("DARKSLATEGRAY 2", "#8DEEEE", 141, 238, 238));
            colorList.Add(new ColorClass("DARKSLATEGRAY 3", "#79CDCD", 121, 205, 205));
            colorList.Add(new ColorClass("DARKSLATEGRAY 4", "#528B8B", 82, 139, 139));
            colorList.Add(new ColorClass("CYAN / AQUA*", "#00FFFF", 0, 255, 255));
            colorList.Add(new ColorClass("CYAN 2", "#00EEEE", 0, 238, 238));
            colorList.Add(new ColorClass("CYAN 3", "#00CDCD", 0, 205, 205));
            colorList.Add(new ColorClass("DARKCYAN", "#008B8B", 0, 139, 139));
            colorList.Add(new ColorClass("TEAL*", "#008080", 0, 128, 128));
            colorList.Add(new ColorClass("MEDIUMTURQUOISE", "#48D1CC", 72, 209, 204));
            colorList.Add(new ColorClass("LIGHTSEAGREEN", "#20B2AA", 32, 178, 170));
            colorList.Add(new ColorClass("MANGANESEBLUE", "#03A89E", 3, 168, 158));
            colorList.Add(new ColorClass("TURQUOISE", "#40E0D0", 64, 224, 208));
            colorList.Add(new ColorClass("COLDGREY", "#808A87", 128, 138, 135));
            colorList.Add(new ColorClass("TURQUOISEBLUE", "#00C78C", 0, 199, 140));
            colorList.Add(new ColorClass("AQUAMARINE 1", "#7FFFD4", 127, 255, 212));
            colorList.Add(new ColorClass("AQUAMARINE 2", "#76EEC6", 118, 238, 198));
            colorList.Add(new ColorClass("AQUAMARINE 3", "#66CDAA", 102, 205, 170));
            colorList.Add(new ColorClass("AQUAMARINE 4", "#458B74", 69, 139, 116));
            colorList.Add(new ColorClass("MEDIUMSPRINGGREEN", "#00FA9A", 0, 250, 154));
            colorList.Add(new ColorClass("MINTCREAM", "#F5FFFA", 245, 255, 250));
            colorList.Add(new ColorClass("SPRINGGREEN", "#00FF7F", 0, 255, 127));
            colorList.Add(new ColorClass("SPRINGGREEN 1", "#00EE76", 0, 238, 118));
            colorList.Add(new ColorClass("SPRINGGREEN 2", "#00CD66", 0, 205, 102));
            colorList.Add(new ColorClass("SPRINGGREEN 3", "#008B45", 0, 139, 69));
            colorList.Add(new ColorClass("MEDIUMSEAGREEN", "#3CB371", 60, 179, 113));
            colorList.Add(new ColorClass("SEAGREEN 1", "#54FF9F", 84, 255, 159));
            colorList.Add(new ColorClass("SEAGREEN 2", "#4EEE94", 78, 238, 148));
            colorList.Add(new ColorClass("SEAGREEN 3", "#43CD80", 67, 205, 128));
            colorList.Add(new ColorClass("SEAGREEN 4", "#2E8B57", 46, 139, 87));
            colorList.Add(new ColorClass("EMERALDGREEN", "#00C957", 0, 201, 87));
            colorList.Add(new ColorClass("MINT", "#BDFCC9", 189, 252, 201));
            colorList.Add(new ColorClass("COBALTGREEN", "#3D9140", 61, 145, 64));
            colorList.Add(new ColorClass("HONEYDEW 1", "#F0FFF0", 240, 255, 240));
            colorList.Add(new ColorClass("HONEYDEW 2", "#E0EEE0", 224, 238, 224));
            colorList.Add(new ColorClass("HONEYDEW 3", "#C1CDC1", 193, 205, 193));
            colorList.Add(new ColorClass("HONEYDEW 4", "#838B83", 131, 139, 131));
            colorList.Add(new ColorClass("DARKSEAGREEN", "#8FBC8F", 143, 188, 143));
            colorList.Add(new ColorClass("DARKSEAGREEN 1", "#C1FFC1", 193, 255, 193));
            colorList.Add(new ColorClass("DARKSEAGREEN 2", "#B4EEB4", 180, 238, 180));
            colorList.Add(new ColorClass("DARKSEAGREEN 3", "#9BCD9B", 155, 205, 155));
            colorList.Add(new ColorClass("DARKSEAGREEN 4", "#698B69", 105, 139, 105));
            colorList.Add(new ColorClass("PALEGREEN", "#98FB98", 152, 251, 152));
            colorList.Add(new ColorClass("PALEGREEN 1", "#9AFF9A", 154, 255, 154));
            colorList.Add(new ColorClass("PALEGREEN 2", "#90EE90", 144, 238, 144));
            colorList.Add(new ColorClass("PALEGREEN 3", "#7CCD7C", 124, 205, 124));
            colorList.Add(new ColorClass("PALEGREEN 4", "#548B54", 84, 139, 84));
            colorList.Add(new ColorClass("LIMEGREEN", "#32CD32", 50, 205, 50));
            colorList.Add(new ColorClass("FORESTGREEN", "#228B22", 34, 139, 34));
            colorList.Add(new ColorClass("LIME", "#00FF00", 0, 255, 0));
            colorList.Add(new ColorClass("GREEN 2", "#00EE00", 0, 238, 0));
            colorList.Add(new ColorClass("GREEN 3", "#00CD00", 0, 205, 0));
            colorList.Add(new ColorClass("GREEN 4", "#008B00", 0, 139, 0));
            colorList.Add(new ColorClass("GREEN*", "#008000", 0, 128, 0));
            colorList.Add(new ColorClass("DARKGREEN", "#006400", 0, 100, 0));
            colorList.Add(new ColorClass("SAPGREEN", "#308014", 48, 128, 20));
            colorList.Add(new ColorClass("LAWNGREEN", "#7CFC00", 124, 252, 0));
            colorList.Add(new ColorClass("CHARTREUSE 1", "#7FFF00", 127, 255, 0));
            colorList.Add(new ColorClass("CHARTREUSE 2", "#76EE00", 118, 238, 0));
            colorList.Add(new ColorClass("CHARTREUSE 3", "#66CD00", 102, 205, 0));
            colorList.Add(new ColorClass("CHARTREUSE 4", "#458B00", 69, 139, 0));
            colorList.Add(new ColorClass("GREENYELLOW", "#ADFF2F", 173, 255, 47));
            colorList.Add(new ColorClass("DARKOLIVEGREEN 1", "#CAFF70", 202, 255, 112));
            colorList.Add(new ColorClass("DARKOLIVEGREEN 2", "#BCEE68", 188, 238, 104));
            colorList.Add(new ColorClass("DARKOLIVEGREEN 3", "#A2CD5A", 162, 205, 90));
            colorList.Add(new ColorClass("DARKOLIVEGREEN 4", "#6E8B3D", 110, 139, 61));
            colorList.Add(new ColorClass("DARKOLIVEGREEN", "#556B2F", 85, 107, 47));
            colorList.Add(new ColorClass("OLIVEDRAB", "#6B8E23", 107, 142, 35));
            colorList.Add(new ColorClass("OLIVEDRAB 1", "#C0FF3E", 192, 255, 62));
            colorList.Add(new ColorClass("OLIVEDRAB 2", "#B3EE3A", 179, 238, 58));
            colorList.Add(new ColorClass("YELLOWGREEN", "#9ACD32", 154, 205, 50));
            colorList.Add(new ColorClass("OLIVEDRAB 4", "#698B22", 105, 139, 34));
            colorList.Add(new ColorClass("IVORY 1", "#FFFFF0", 255, 255, 240));
            colorList.Add(new ColorClass("IVORY 2", "#EEEEE0", 238, 238, 224));
            colorList.Add(new ColorClass("IVORY 3", "#CDCDC1", 205, 205, 193));
            colorList.Add(new ColorClass("IVORY 4", "#8B8B83", 139, 139, 131));
            colorList.Add(new ColorClass("BEIGE", "#F5F5DC", 245, 245, 220));
            colorList.Add(new ColorClass("LIGHTYELLOW 1", "#FFFFE0", 255, 255, 224));
            colorList.Add(new ColorClass("LIGHTYELLOW 2", "#EEEED1", 238, 238, 209));
            colorList.Add(new ColorClass("LIGHTYELLOW 3", "#CDCDB4", 205, 205, 180));
            colorList.Add(new ColorClass("LIGHTYELLOW 4", "#8B8B7A", 139, 139, 122));
            colorList.Add(new ColorClass("LIGHTGOLDENRODYELLOW", "#FAFAD2", 250, 250, 210));
            colorList.Add(new ColorClass("YELLOW 1", "#FFFF00", 255, 255, 0));
            colorList.Add(new ColorClass("YELLOW 2", "#EEEE00", 238, 238, 0));
            colorList.Add(new ColorClass("YELLOW 3", "#CDCD00", 205, 205, 0));
            colorList.Add(new ColorClass("YELLOW 4", "#8B8B00", 139, 139, 0));
            colorList.Add(new ColorClass("WARMGREY", "#808069", 128, 128, 105));
            colorList.Add(new ColorClass("OLIVE*", "#808000", 128, 128, 0));
            colorList.Add(new ColorClass("DARKKHAKI", "#BDB76B", 189, 183, 107));
            colorList.Add(new ColorClass("KHAKI 1", "#FFF68F", 255, 246, 143));
            colorList.Add(new ColorClass("KHAKI 2", "#EEE685", 238, 230, 133));
            colorList.Add(new ColorClass("KHAKI 3", "#CDC673", 205, 198, 115));
            colorList.Add(new ColorClass("KHAKI 4", "#8B864E", 139, 134, 78));
            colorList.Add(new ColorClass("KHAKI", "#F0E68C", 240, 230, 140));
            colorList.Add(new ColorClass("PALEGOLDENROD", "#EEE8AA", 238, 232, 170));
            colorList.Add(new ColorClass("LEMONCHIFFON 1", "#FFFACD", 255, 250, 205));
            colorList.Add(new ColorClass("LEMONCHIFFON 2", "#EEE9BF", 238, 233, 191));
            colorList.Add(new ColorClass("LEMONCHIFFON 3", "#CDC9A5", 205, 201, 165));
            colorList.Add(new ColorClass("LEMONCHIFFON 4", "#8B8970", 139, 137, 112));
            colorList.Add(new ColorClass("LIGHTGOLDENROD 1", "#FFEC8B", 255, 236, 139));
            colorList.Add(new ColorClass("LIGHTGOLDENROD 2", "#EEDC82", 238, 220, 130));
            colorList.Add(new ColorClass("LIGHTGOLDENROD 3", "#CDBE70", 205, 190, 112));
            colorList.Add(new ColorClass("LIGHTGOLDENROD 4", "#8B814C", 139, 129, 76));
            colorList.Add(new ColorClass("BANANA", "#E3CF57", 227, 207, 87));
            colorList.Add(new ColorClass("GOLD 1", "#FFD700", 255, 215, 0));
            colorList.Add(new ColorClass("GOLD 2", "#EEC900", 238, 201, 0));
            colorList.Add(new ColorClass("GOLD 3", "#CDAD00", 205, 173, 0));
            colorList.Add(new ColorClass("GOLD 4", "#8B7500", 139, 117, 0));
            colorList.Add(new ColorClass("CORNSILK 1", "#FFF8DC", 255, 248, 220));
            colorList.Add(new ColorClass("CORNSILK 2", "#EEE8CD", 238, 232, 205));
            colorList.Add(new ColorClass("CORNSILK 3", "#CDC8B1", 205, 200, 177));
            colorList.Add(new ColorClass("CORNSILK 4", "#8B8878", 139, 136, 120));
            colorList.Add(new ColorClass("GOLDENROD", "#DAA520", 218, 165, 32));
            colorList.Add(new ColorClass("GOLDENROD 1", "#FFC125", 255, 193, 37));
            colorList.Add(new ColorClass("GOLDENROD 2", "#EEB422", 238, 180, 34));
            colorList.Add(new ColorClass("GOLDENROD 3", "#CD9B1D", 205, 155, 29));
            colorList.Add(new ColorClass("GOLDENROD 4", "#8B6914", 139, 105, 20));
            colorList.Add(new ColorClass("DARKGOLDENROD", "#B8860B", 184, 134, 11));
            colorList.Add(new ColorClass("DARKGOLDENROD 1", "#FFB90F", 255, 185, 15));
            colorList.Add(new ColorClass("DARKGOLDENROD 2", "#EEAD0E", 238, 173, 14));
            colorList.Add(new ColorClass("DARKGOLDENROD 3", "#CD950C", 205, 149, 12));
            colorList.Add(new ColorClass("DARKGOLDENROD 4", "#8B6508", 139, 101, 8));
            colorList.Add(new ColorClass("ORANGE 1", "#FFA500", 255, 165, 0));
            colorList.Add(new ColorClass("ORANGE 2", "#EE9A00", 238, 154, 0));
            colorList.Add(new ColorClass("ORANGE 3", "#CD8500", 205, 133, 0));
            colorList.Add(new ColorClass("ORANGE 4", "#8B5A00", 139, 90, 0));
            colorList.Add(new ColorClass("FLORALWHITE", "#FFFAF0", 255, 250, 240));
            colorList.Add(new ColorClass("OLDLACE", "#FDF5E6", 253, 245, 230));
            colorList.Add(new ColorClass("WHEAT", "#F5DEB3", 245, 222, 179));
            colorList.Add(new ColorClass("WHEAT 1", "#FFE7BA", 255, 231, 186));
            colorList.Add(new ColorClass("WHEAT 2", "#EED8AE", 238, 216, 174));
            colorList.Add(new ColorClass("WHEAT 3", "#CDBA96", 205, 186, 150));
            colorList.Add(new ColorClass("WHEAT 4", "#8B7E66", 139, 126, 102));
            colorList.Add(new ColorClass("MOCCASIN", "#FFE4B5", 255, 228, 181));
            colorList.Add(new ColorClass("PAPAYAWHIP", "#FFEFD5", 255, 239, 213));
            colorList.Add(new ColorClass("BLANCHEDALMOND", "#FFEBCD", 255, 235, 205));
            colorList.Add(new ColorClass("NAVAJOWHITE 1", "#FFDEAD", 255, 222, 173));
            colorList.Add(new ColorClass("NAVAJOWHITE 2", "#EECFA1", 238, 207, 161));
            colorList.Add(new ColorClass("NAVAJOWHITE 3", "#CDB38B", 205, 179, 139));
            colorList.Add(new ColorClass("NAVAJOWHITE 4", "#8B795E", 139, 121, 94));
            colorList.Add(new ColorClass("EGGSHELL", "#FCE6C9", 252, 230, 201));
            colorList.Add(new ColorClass("TAN", "#D2B48C", 210, 180, 140));
            colorList.Add(new ColorClass("BRICK", "#9C661F", 156, 102, 31));
            colorList.Add(new ColorClass("CADMIUMYELLOW", "#FF9912", 255, 153, 18));
            colorList.Add(new ColorClass("ANTIQUEWHITE", "#FAEBD7", 250, 235, 215));
            colorList.Add(new ColorClass("ANTIQUEWHITE 1", "#FFEFDB", 255, 239, 219));
            colorList.Add(new ColorClass("ANTIQUEWHITE 2", "#EEDFCC", 238, 223, 204));
            colorList.Add(new ColorClass("ANTIQUEWHITE 3", "#CDC0B0", 205, 192, 176));
            colorList.Add(new ColorClass("ANTIQUEWHITE 4", "#8B8378", 139, 131, 120));
            colorList.Add(new ColorClass("BURLYWOOD", "#DEB887", 222, 184, 135));
            colorList.Add(new ColorClass("BURLYWOOD 1", "#FFD39B", 255, 211, 155));
            colorList.Add(new ColorClass("BURLYWOOD 2", "#EEC591", 238, 197, 145));
            colorList.Add(new ColorClass("BURLYWOOD 3", "#CDAA7D", 205, 170, 125));
            colorList.Add(new ColorClass("BURLYWOOD 4", "#8B7355", 139, 115, 85));
            colorList.Add(new ColorClass("BISQUE 1", "#FFE4C4", 255, 228, 196));
            colorList.Add(new ColorClass("BISQUE 2", "#EED5B7", 238, 213, 183));
            colorList.Add(new ColorClass("BISQUE 3", "#CDB79E", 205, 183, 158));
            colorList.Add(new ColorClass("BISQUE 4", "#8B7D6B", 139, 125, 107));
            colorList.Add(new ColorClass("MELON", "#E3A869", 227, 168, 105));
            colorList.Add(new ColorClass("CARROT", "#ED9121", 237, 145, 33));
            colorList.Add(new ColorClass("DARKORANGE", "#FF8C00", 255, 140, 0));
            colorList.Add(new ColorClass("DARKORANGE 1", "#FF7F00", 255, 127, 0));
            colorList.Add(new ColorClass("DARKORANGE 2", "#EE7600", 238, 118, 0));
            colorList.Add(new ColorClass("DARKORANGE 3", "#CD6600", 205, 102, 0));
            colorList.Add(new ColorClass("DARKORANGE 4", "#8B4500", 139, 69, 0));
            colorList.Add(new ColorClass("ORANGE", "#FF8000", 255, 128, 0));
            colorList.Add(new ColorClass("TAN 1", "#FFA54F", 255, 165, 79));
            colorList.Add(new ColorClass("TAN 2", "#EE9A49", 238, 154, 73));
            colorList.Add(new ColorClass("PERU", "#CD853F", 205, 133, 63));
            colorList.Add(new ColorClass("TAN 4", "#8B5A2B", 139, 90, 43));
            colorList.Add(new ColorClass("LINEN", "#FAF0E6", 250, 240, 230));
            colorList.Add(new ColorClass("PEACHPUFF 1", "#FFDAB9", 255, 218, 185));
            colorList.Add(new ColorClass("PEACHPUFF 2", "#EECBAD", 238, 203, 173));
            colorList.Add(new ColorClass("PEACHPUFF 3", "#CDAF95", 205, 175, 149));
            colorList.Add(new ColorClass("PEACHPUFF 4", "#8B7765", 139, 119, 101));
            colorList.Add(new ColorClass("SEASHELL 1", "#FFF5EE", 255, 245, 238));
            colorList.Add(new ColorClass("SEASHELL 2", "#EEE5DE", 238, 229, 222));
            colorList.Add(new ColorClass("SEASHELL 3", "#CDC5BF", 205, 197, 191));
            colorList.Add(new ColorClass("SEASHELL 4", "#8B8682", 139, 134, 130));
            colorList.Add(new ColorClass("SANDYBROWN", "#F4A460", 244, 164, 96));
            colorList.Add(new ColorClass("RAWSIENNA", "#C76114", 199, 97, 20));
            colorList.Add(new ColorClass("CHOCOLATE", "#D2691E", 210, 105, 30));
            colorList.Add(new ColorClass("CHOCOLATE 1", "#FF7F24", 255, 127, 36));
            colorList.Add(new ColorClass("CHOCOLATE 2", "#EE7621", 238, 118, 33));
            colorList.Add(new ColorClass("CHOCOLATE 3", "#CD661D", 205, 102, 29));
            colorList.Add(new ColorClass("SADDLEBROWN", "#8B4513", 139, 69, 19));
            colorList.Add(new ColorClass("IVORYBLACK", "#292421", 41, 36, 33));
            colorList.Add(new ColorClass("FLESH", "#FF7D40", 255, 125, 64));
            colorList.Add(new ColorClass("CADMIUMORANGE", "#FF6103", 255, 97, 3));
            colorList.Add(new ColorClass("BURNTSIENNA", "#8A360F", 138, 54, 15));
            colorList.Add(new ColorClass("SIENNA", "#A0522D", 160, 82, 45));
            colorList.Add(new ColorClass("SIENNA 1", "#FF8247", 255, 130, 71));
            colorList.Add(new ColorClass("SIENNA 2", "#EE7942", 238, 121, 66));
            colorList.Add(new ColorClass("SIENNA 3", "#CD6839", 205, 104, 57));
            colorList.Add(new ColorClass("SIENNA 4", "#8B4726", 139, 71, 38));
            colorList.Add(new ColorClass("LIGHTSALMON 1", "#FFA07A", 255, 160, 122));
            colorList.Add(new ColorClass("LIGHTSALMON 2", "#EE9572", 238, 149, 114));
            colorList.Add(new ColorClass("LIGHTSALMON 3", "#CD8162", 205, 129, 98));
            colorList.Add(new ColorClass("LIGHTSALMON 4", "#8B5742", 139, 87, 66));
            colorList.Add(new ColorClass("CORAL", "#FF7F50", 255, 127, 80));
            colorList.Add(new ColorClass("ORANGERED 1", "#FF4500", 255, 69, 0));
            colorList.Add(new ColorClass("ORANGERED 2", "#EE4000", 238, 64, 0));
            colorList.Add(new ColorClass("ORANGERED 3", "#CD3700", 205, 55, 0));
            colorList.Add(new ColorClass("ORANGERED 4", "#8B2500", 139, 37, 0));
            colorList.Add(new ColorClass("SEPIA", "#5E2612", 94, 38, 18));
            colorList.Add(new ColorClass("DARKSALMON", "#E9967A", 233, 150, 122));
            colorList.Add(new ColorClass("SALMON 1", "#FF8C69", 255, 140, 105));
            colorList.Add(new ColorClass("SALMON 2", "#EE8262", 238, 130, 98));
            colorList.Add(new ColorClass("SALMON 3", "#CD7054", 205, 112, 84));
            colorList.Add(new ColorClass("SALMON 4", "#8B4C39", 139, 76, 57));
            colorList.Add(new ColorClass("CORAL 1", "#FF7256", 255, 114, 86));
            colorList.Add(new ColorClass("CORAL 2", "#EE6A50", 238, 106, 80));
            colorList.Add(new ColorClass("CORAL 3", "#CD5B45", 205, 91, 69));
            colorList.Add(new ColorClass("CORAL 4", "#8B3E2F", 139, 62, 47));
            colorList.Add(new ColorClass("BURNTUMBER", "#8A3324", 138, 51, 36));
            colorList.Add(new ColorClass("TOMATO 1", "#FF6347", 255, 99, 71));
            colorList.Add(new ColorClass("TOMATO 2", "#EE5C42", 238, 92, 66));
            colorList.Add(new ColorClass("TOMATO 3", "#CD4F39", 205, 79, 57));
            colorList.Add(new ColorClass("TOMATO 4", "#8B3626", 139, 54, 38));
            colorList.Add(new ColorClass("SALMON", "#FA8072", 250, 128, 114));
            colorList.Add(new ColorClass("MISTYROSE 1", "#FFE4E1", 255, 228, 225));
            colorList.Add(new ColorClass("MISTYROSE 2", "#EED5D2", 238, 213, 210));
            colorList.Add(new ColorClass("MISTYROSE 3", "#CDB7B5", 205, 183, 181));
            colorList.Add(new ColorClass("MISTYROSE 4", "#8B7D7B", 139, 125, 123));
            colorList.Add(new ColorClass("SNOW 1", "#FFFAFA", 255, 250, 250));
            colorList.Add(new ColorClass("SNOW 2", "#EEE9E9", 238, 233, 233));
            colorList.Add(new ColorClass("SNOW 3", "#CDC9C9", 205, 201, 201));
            colorList.Add(new ColorClass("SNOW 4", "#8B8989", 139, 137, 137));
            colorList.Add(new ColorClass("ROSYBROWN", "#BC8F8F", 188, 143, 143));
            colorList.Add(new ColorClass("ROSYBROWN 1", "#FFC1C1", 255, 193, 193));
            colorList.Add(new ColorClass("ROSYBROWN 2", "#EEB4B4", 238, 180, 180));
            colorList.Add(new ColorClass("ROSYBROWN 3", "#CD9B9B", 205, 155, 155));
            colorList.Add(new ColorClass("ROSYBROWN 4", "#8B6969", 139, 105, 105));
            colorList.Add(new ColorClass("LIGHTCORAL", "#F08080", 240, 128, 128));
            colorList.Add(new ColorClass("INDIANRED", "#CD5C5C", 205, 92, 92));
            colorList.Add(new ColorClass("INDIANRED 1", "#FF6A6A", 255, 106, 106));
            colorList.Add(new ColorClass("INDIANRED 2", "#EE6363", 238, 99, 99));
            colorList.Add(new ColorClass("INDIANRED 4", "#8B3A3A", 139, 58, 58));
            colorList.Add(new ColorClass("INDIANRED 3", "#CD5555", 205, 85, 85));
            colorList.Add(new ColorClass("BROWN", "#A52A2A", 165, 42, 42));
            colorList.Add(new ColorClass("BROWN 1", "#FF4040", 255, 64, 64));
            colorList.Add(new ColorClass("BROWN 2", "#EE3B3B", 238, 59, 59));
            colorList.Add(new ColorClass("BROWN 3", "#CD3333", 205, 51, 51));
            colorList.Add(new ColorClass("BROWN 4", "#8B2323", 139, 35, 35));
            colorList.Add(new ColorClass("FIREBRICK", "#B22222", 178, 34, 34));
            colorList.Add(new ColorClass("FIREBRICK 1", "#FF3030", 255, 48, 48));
            colorList.Add(new ColorClass("FIREBRICK 2", "#EE2C2C", 238, 44, 44));
            colorList.Add(new ColorClass("FIREBRICK 3", "#CD2626", 205, 38, 38));
            colorList.Add(new ColorClass("FIREBRICK 4", "#8B1A1A", 139, 26, 26));
            colorList.Add(new ColorClass("RED 1", "#FF0000", 255, 0, 0));
            colorList.Add(new ColorClass("RED 2", "#EE0000", 238, 0, 0));
            colorList.Add(new ColorClass("RED 3", "#CD0000", 205, 0, 0));
            colorList.Add(new ColorClass("RED 4", "#8B0000", 139, 0, 0));
            colorList.Add(new ColorClass("MAROON*", "#800000", 128, 0, 0));
            colorList.Add(new ColorClass("SGI BEET", "#8E388E", 142, 56, 142));
            colorList.Add(new ColorClass("SGI SLATEBLUE", "#7171C6", 113, 113, 198));
            colorList.Add(new ColorClass("SGI LIGHTBLUE", "#7D9EC0", 125, 158, 192));
            colorList.Add(new ColorClass("SGI TEAL", "#388E8E", 56, 142, 142));
            colorList.Add(new ColorClass("SGI CHARTREUSE", "#71C671", 113, 198, 113));
            colorList.Add(new ColorClass("SGI OLIVEDRAB", "#8E8E38", 142, 142, 56));
            colorList.Add(new ColorClass("SGI BRIGHTGRAY", "#C5C1AA", 197, 193, 170));
            colorList.Add(new ColorClass("SGI SALMON", "#C67171", 198, 113, 113));
            colorList.Add(new ColorClass("SGI DARKGRAY", "#555555", 85, 85, 85));
            colorList.Add(new ColorClass("SGI GRAY 12", "#1E1E1E", 30, 30, 30));
            colorList.Add(new ColorClass("SGI GRAY 16", "#282828", 40, 40, 40));
            colorList.Add(new ColorClass("SGI GRAY 32", "#515151", 81, 81, 81));
            colorList.Add(new ColorClass("SGI GRAY 36", "#5B5B5B", 91, 91, 91));
            colorList.Add(new ColorClass("SGI GRAY 52", "#848484", 132, 132, 132));
            colorList.Add(new ColorClass("SGI GRAY 56", "#8E8E8E", 142, 142, 142));
            colorList.Add(new ColorClass("SGI LIGHTGRAY", "#AAAAAA", 170, 170, 170));
            colorList.Add(new ColorClass("SGI GRAY 72", "#B7B7B7", 183, 183, 183));
            colorList.Add(new ColorClass("SGI GRAY 76", "#C1C1C1", 193, 193, 193));
            colorList.Add(new ColorClass("SGI GRAY 92", "#EAEAEA", 234, 234, 234));
            colorList.Add(new ColorClass("SGI GRAY 96", "#F4F4F4", 244, 244, 244));
            colorList.Add(new ColorClass("WHITE*", "#FFFFFF", 255, 255, 255));
            colorList.Add(new ColorClass("WHITE SMOKE", "#F5F5F5", 245, 245, 245));
            colorList.Add(new ColorClass("GAINSBORO", "#DCDCDC", 220, 220, 220));
            colorList.Add(new ColorClass("LIGHTGREY", "#D3D3D3", 211, 211, 211));
            colorList.Add(new ColorClass("SILVER*", "#C0C0C0", 192, 192, 192));
            colorList.Add(new ColorClass("DARKGRAY", "#A9A9A9", 169, 169, 169));
            colorList.Add(new ColorClass("GRAY*", "#808080", 128, 128, 128));
            colorList.Add(new ColorClass("DIMGRAY", "#696969", 105, 105, 105));
            colorList.Add(new ColorClass("BLACK*", "#000000", 0, 0, 0));
            colorList.Add(new ColorClass("GRAY 99", "#FCFCFC", 252, 252, 252));
            colorList.Add(new ColorClass("GRAY 98", "#FAFAFA", 250, 250, 250));
            colorList.Add(new ColorClass("GRAY 97", "#F7F7F7", 247, 247, 247));
            colorList.Add(new ColorClass("WHITE SMOKE", "#F5F5F5", 245, 245, 245));
            colorList.Add(new ColorClass("GRAY 95", "#F2F2F2", 242, 242, 242));
            colorList.Add(new ColorClass("GRAY 94", "#F0F0F0", 240, 240, 240));
            colorList.Add(new ColorClass("GRAY 93", "#EDEDED", 237, 237, 237));
            colorList.Add(new ColorClass("GRAY 92", "#EBEBEB", 235, 235, 235));
            colorList.Add(new ColorClass("GRAY 91", "#E8E8E8", 232, 232, 232));
            colorList.Add(new ColorClass("GRAY 90", "#E5E5E5", 229, 229, 229));
            colorList.Add(new ColorClass("GRAY 89", "#E3E3E3", 227, 227, 227));
            colorList.Add(new ColorClass("GRAY 88", "#E0E0E0", 224, 224, 224));
            colorList.Add(new ColorClass("GRAY 87", "#DEDEDE", 222, 222, 222));
            colorList.Add(new ColorClass("GRAY 86", "#DBDBDB", 219, 219, 219));
            colorList.Add(new ColorClass("GRAY 85", "#D9D9D9", 217, 217, 217));
            colorList.Add(new ColorClass("GRAY 84", "#D6D6D6", 214, 214, 214));
            colorList.Add(new ColorClass("GRAY 83", "#D4D4D4", 212, 212, 212));
            colorList.Add(new ColorClass("GRAY 82", "#D1D1D1", 209, 209, 209));
            colorList.Add(new ColorClass("GRAY 81", "#CFCFCF", 207, 207, 207));
            colorList.Add(new ColorClass("GRAY 80", "#CCCCCC", 204, 204, 204));
            colorList.Add(new ColorClass("GRAY 79", "#C9C9C9", 201, 201, 201));
            colorList.Add(new ColorClass("GRAY 78", "#C7C7C7", 199, 199, 199));
            colorList.Add(new ColorClass("GRAY 77", "#C4C4C4", 196, 196, 196));
            colorList.Add(new ColorClass("GRAY 76", "#C2C2C2", 194, 194, 194));
            colorList.Add(new ColorClass("GRAY 75", "#BFBFBF", 191, 191, 191));
            colorList.Add(new ColorClass("GRAY 74", "#BDBDBD", 189, 189, 189));
            colorList.Add(new ColorClass("GRAY 73", "#BABABA", 186, 186, 186));
            colorList.Add(new ColorClass("GRAY 72", "#B8B8B8", 184, 184, 184));
            colorList.Add(new ColorClass("GRAY 71", "#B5B5B5", 181, 181, 181));
            colorList.Add(new ColorClass("GRAY 70", "#B3B3B3", 179, 179, 179));
            colorList.Add(new ColorClass("GRAY 69", "#B0B0B0", 176, 176, 176));
            colorList.Add(new ColorClass("GRAY 68", "#ADADAD", 173, 173, 173));
            colorList.Add(new ColorClass("GRAY 67", "#ABABAB", 171, 171, 171));
            colorList.Add(new ColorClass("GRAY 66", "#A8A8A8", 168, 168, 168));
            colorList.Add(new ColorClass("GRAY 65", "#A6A6A6", 166, 166, 166));
            colorList.Add(new ColorClass("GRAY 64", "#A3A3A3", 163, 163, 163));
            colorList.Add(new ColorClass("GRAY 63", "#A1A1A1", 161, 161, 161));
            colorList.Add(new ColorClass("GRAY 62", "#9E9E9E", 158, 158, 158));
            colorList.Add(new ColorClass("GRAY 61", "#9C9C9C", 156, 156, 156));
            colorList.Add(new ColorClass("GRAY 60", "#999999", 153, 153, 153));
            colorList.Add(new ColorClass("GRAY 59", "#969696", 150, 150, 150));
            colorList.Add(new ColorClass("GRAY 58", "#949494", 148, 148, 148));
            colorList.Add(new ColorClass("GRAY 57", "#919191", 145, 145, 145));
            colorList.Add(new ColorClass("GRAY 56", "#8F8F8F", 143, 143, 143));
            colorList.Add(new ColorClass("GRAY 55", "#8C8C8C", 140, 140, 140));
            colorList.Add(new ColorClass("GRAY 54", "#8A8A8A", 138, 138, 138));
            colorList.Add(new ColorClass("GRAY 53", "#878787", 135, 135, 135));
            colorList.Add(new ColorClass("GRAY 52", "#858585", 133, 133, 133));
            colorList.Add(new ColorClass("GRAY 51", "#828282", 130, 130, 130));
            colorList.Add(new ColorClass("GRAY 50", "#7F7F7F", 127, 127, 127));
            colorList.Add(new ColorClass("GRAY 49", "#7D7D7D", 125, 125, 125));
            colorList.Add(new ColorClass("GRAY 48", "#7A7A7A", 122, 122, 122));
            colorList.Add(new ColorClass("GRAY 47", "#787878", 120, 120, 120));
            colorList.Add(new ColorClass("GRAY 46", "#757575", 117, 117, 117));
            colorList.Add(new ColorClass("GRAY 45", "#737373", 115, 115, 115));
            colorList.Add(new ColorClass("GRAY 44", "#707070", 112, 112, 112));
            colorList.Add(new ColorClass("GRAY 43", "#6E6E6E", 110, 110, 110));
            colorList.Add(new ColorClass("GRAY 42", "#6B6B6B", 107, 107, 107));
            colorList.Add(new ColorClass("DIMGRAY", "#696969", 105, 105, 105));
            colorList.Add(new ColorClass("GRAY 40", "#666666", 102, 102, 102));
            colorList.Add(new ColorClass("GRAY 39", "#636363", 99, 99, 99));
            colorList.Add(new ColorClass("GRAY 38", "#616161", 97, 97, 97));
            colorList.Add(new ColorClass("GRAY 37", "#5E5E5E", 94, 94, 94));
            colorList.Add(new ColorClass("GRAY 36", "#5C5C5C", 92, 92, 92));
            colorList.Add(new ColorClass("GRAY 35", "#595959", 89, 89, 89));
            colorList.Add(new ColorClass("GRAY 34", "#575757", 87, 87, 87));
            colorList.Add(new ColorClass("GRAY 33", "#545454", 84, 84, 84));
            colorList.Add(new ColorClass("GRAY 32", "#525252", 82, 82, 82));
            colorList.Add(new ColorClass("GRAY 31", "#4F4F4F", 79, 79, 79));
            colorList.Add(new ColorClass("GRAY 30", "#4D4D4D", 77, 77, 77));
            colorList.Add(new ColorClass("GRAY 29", "#4A4A4A", 74, 74, 74));
            colorList.Add(new ColorClass("GRAY 28", "#474747", 71, 71, 71));
            colorList.Add(new ColorClass("GRAY 27", "#454545", 69, 69, 69));
            colorList.Add(new ColorClass("GRAY 26", "#424242", 66, 66, 66));
            colorList.Add(new ColorClass("GRAY 25", "#404040", 64, 64, 64));
            colorList.Add(new ColorClass("GRAY 24", "#3D3D3D", 61, 61, 61));
            colorList.Add(new ColorClass("GRAY 23", "#3B3B3B", 59, 59, 59));
            colorList.Add(new ColorClass("GRAY 22", "#383838", 56, 56, 56));
            colorList.Add(new ColorClass("GRAY 21", "#363636", 54, 54, 54));
            colorList.Add(new ColorClass("GRAY 20", "#333333", 51, 51, 51));
            colorList.Add(new ColorClass("GRAY 19", "#303030", 48, 48, 48));
            colorList.Add(new ColorClass("GRAY 18", "#2E2E2E", 46, 46, 46));
            colorList.Add(new ColorClass("GRAY 17", "#2B2B2B", 43, 43, 43));
            colorList.Add(new ColorClass("GRAY 16", "#292929", 41, 41, 41));
            colorList.Add(new ColorClass("GRAY 15", "#262626", 38, 38, 38));
            colorList.Add(new ColorClass("GRAY 14", "#242424", 36, 36, 36));
            colorList.Add(new ColorClass("GRAY 13", "#212121", 33, 33, 33));
            colorList.Add(new ColorClass("GRAY 12", "#1F1F1F", 31, 31, 31));
            colorList.Add(new ColorClass("GRAY 11", "#1C1C1C", 28, 28, 28));
            colorList.Add(new ColorClass("GRAY 10", "#1A1A1A", 26, 26, 26));
            colorList.Add(new ColorClass("GRAY 9", "#171717", 23, 23, 23));
            colorList.Add(new ColorClass("GRAY 8", "#141414", 20, 20, 20));
            colorList.Add(new ColorClass("GRAY 7", "#121212", 18, 18, 18));
            colorList.Add(new ColorClass("GRAY 6", "#0F0F0F", 15, 15, 15));
            colorList.Add(new ColorClass("GRAY 5", "#0D0D0D", 13, 13, 13));
            colorList.Add(new ColorClass("GRAY 4", "#0A0A0A", 10, 10, 10));
            colorList.Add(new ColorClass("GRAY 3", "#080808", 8, 8, 8));
            colorList.Add(new ColorClass("GRAY 2", "#050505", 5, 5, 5));
            colorList.Add(new ColorClass("GRAY 1", "#030303", 3, 3, 3));
            #endregion
        }
        private static Regex CSVandQUOTESplit =
            new Regex(@""",""", RegexOptions.Compiled);
        public static string[] CsvQuoteSplit(string ln)
        {
            if (String.IsNullOrEmpty(ln)) return null;
            string ln2 = ln.Trim();
            if (ln2.Length < 1) return null;
            return CSVandQUOTESplit.Split(ln2);
        }
        public static object GetConvertedValue(string val, int minYr, int maxYr)
        {
            string v2 = val.Trim().ToUpper();
            string dtm = v2.Replace('"', ' ').Replace("'", "").Trim();
            string number = v2
                .Replace('"', ' ')
                .Replace('(', '-')
                .Replace(')', ' ')
                .Replace('$', ' ')
                .Replace('[', ' ')
                .Replace(']', ' ')
                .Replace('%', ' ')
                .Replace(",", "")
                .Trim();
            if (String.IsNullOrEmpty(v2)) return null;
            double objDbl = 0.0;
            long objLong = 0;
            DateTime objDtm = DateTime.MinValue;
            bool containsAlphas = false;
            foreach (char c in v2)
            {
                if (Char.IsLetter(c) && c != 'E')
                {
                    containsAlphas = true;
                    break;
                }
            }

            if (long.TryParse(number, out objLong) && containsAlphas == false)
            {
                return objLong;
            }
            else if (double.TryParse(number, out objDbl) && containsAlphas == false)
            {
                return objDbl;
            }
            else if (DateTime.TryParse(dtm, out objDtm))
            {
                if ((dtm.Contains('/') ||
                    dtm.Contains('\\') ||
                    dtm.Contains('-')) &&
                    objDtm.Year >= minYr &&
                    objDtm.Year <= maxYr)
                {
                    return objDtm;
                }
                else return null;
            }
            else return null;
        }
        public static double GetNumber(string val, int minYr, int maxYr)
        {
            string v2 = val.Trim().ToUpper();
            string dtm = v2.Replace('"', ' ').Replace("'", "").Trim();
            string number = v2
                .Replace('"', ' ')
                .Replace('(', '-')
                .Replace(')', ' ')
                .Replace('$', ' ')
                .Replace('[', ' ')
                .Replace(']', ' ')
                .Replace('%', ' ')
                .Replace(",", "")
                .Trim();
            if (String.IsNullOrEmpty(v2)) return 0;
            double objDbl = -1.0;
            DateTime objDtm = DateTime.MinValue;
            if (double.TryParse(number, out objDbl))
            {
                return objDbl;
            }
            else if (DateTime.TryParse(dtm, out objDtm))
            {
                if ((dtm.Contains('/') ||
                    dtm.Contains('\\') ||
                    dtm.Contains('-')) &&
                    objDtm.Year >= minYr &&
                    objDtm.Year <= maxYr)
                {
                    string dtNum = objDtm.Year.ToString() +
                        objDtm.Month.ToString().PadLeft(2, '0') +
                        objDtm.Day.ToString().PadLeft(2, '0') +
                        objDtm.Hour.ToString().PadLeft(2, '0') +
                        objDtm.Minute.ToString().PadLeft(2, '0') +
                        objDtm.Second.ToString().PadLeft(2, '0') +
                        '.' +
                        objDtm.Millisecond.ToString().PadLeft(3, '0');
                    return double.Parse(dtNum);
                }
            }
            return 0;
        }
        public static List<object> CoalesceObjects(string val)
        {
            string v2 = val.Trim().ToUpper();
            string dtm = v2.Replace('"',' ').Replace("'","").Trim();
            string number = v2
                .Replace('"', ' ')
                .Replace('(', '-')
                .Replace(')', ' ')
                .Replace('$', ' ')
                .Replace('[', ' ')
                .Replace(']', ' ')
                .Replace('%', ' ')
                .Replace(",","")
                .Trim();
            if (String.IsNullOrEmpty(v2)) return null;
            List<object> retList = new List<object>();
            retList.Add(v2);
            if (v2.Length > 100) return retList;
            long objLng = -1;
            double objDbl = -1.0;
            DateTime objDtm = DateTime.MinValue;
            if (DateTime.TryParse(dtm, out objDtm))
            {
                if (dtm.Contains('/') ||
                    dtm.Contains('\\') ||
                    dtm.Contains('-'))
                {
                    retList.Add(objDtm);
                }
            }
            else if (long.TryParse(number, out objLng))
            {
                if (objLng > 0)
                {
                    retList.Add(objLng);
                }
            }
            else if (double.TryParse(number, out objDbl))
            {
                if (objDbl > 0)
                {
                    retList.Add(objDbl);
                }
            }
            return retList;
        }
        public static ColorClass FindClosestColorMatch(int r, int g, int b)
        {
            int rLower = r - 10;
            int rHigher = r + 10;
            int gLower = g - 10;
            int gHigher = g + 10;
            int bLower = b - 10;
            int bHigher = b + 10;

            List<ColorClass> cls = (from cc in colorList
                                    where 
                                    (cc.R > rLower && cc.R < rHigher)
                                    &&
                                    (cc.G > gLower && cc.G < gHigher)
                                    &&
                                    (cc.B > bLower && cc.B < bHigher)
                                    orderby cc.R ascending, cc.G ascending, cc.B ascending
                                    select cc).ToList<ColorClass>();

            if (cls == null || cls.Count < 1)
            {
                int r2 = ((int)(((double)r) / 10)) * 10;
                int g2 = ((int)(((double)g) / 10)) * 10;
                int b2 = ((int)(((double)b) / 10)) * 10;

                ColorClass cRet = new ColorClass(r2.ToString() + '|' +
                    g2.ToString() + '|' +
                    b2.ToString(), System.Drawing.ColorTranslator.ToHtml(System.Drawing.Color.FromArgb(r, g, b)),
                    r2, g2, b2);

                cRet.HasProperName = false;

                return cRet;
            }
            else return cls[0];
        }
        public static List<string> GetAlphaToks(string data)
        {
            string[] s1 = Regex.Split(data.ToUpper(), @"\W+|[0-9]+");
            Dictionary<string, string> unique = new Dictionary<string, string>();
            foreach (string s in s1)
            {
                if (s.Trim() == "") continue;
                if (s.Trim().Length < 2) continue;
                if (!unique.ContainsKey(s.Trim())) unique.Add(s.Trim(), s.Trim());
            }
            return unique.Values.ToList<string>();
        }
        public static List<DateTime> GetDates(string data, string fileType)
        {
            string tmp = data;

            tmp = tmp.Replace("<^>", " ");
            tmp = tmp.Replace(";", " ");
            if (fileType == "CSV")
            {
                tmp = tmp.Replace(",", " ");
            }
            string[] s1 = Regex.Split(tmp, @"\s+");
            //2004-11-14
            Dictionary<DateTime, string> tdic = new Dictionary<DateTime, string>();
            foreach (string s in s1)
            {
                DateTime dt = DateTime.MinValue;

                bool p = DateTime.TryParse(s.Replace(",", "").Replace(";", ""), out dt);
                if (p)
                {
                    if (!tdic.ContainsKey(dt))
                    {
                        tdic.Add(dt, "");
                    }
                }
            }
            return tdic.Keys.ToList<DateTime>();
        }
        public static List<string> GetDates2(string data)
        {
            List<DateTime> dates = GetDates(data);

            if (dates.Count > 0)
            {
                Dictionary<string, string> dict = new Dictionary<string, string>();
                foreach (DateTime dt in dates)
                {
                    string tok1 = "[DT:" + dt.Year.ToString() + "-" +
                        dt.Month.ToString() + "-" + dt.Day.ToString() + ']';
                    dict[tok1] = "";
                }
                return dict.Keys.ToList<string>();
            }
            else return null;
        }
        public static List<DateTime> GetDates(string data)
        {
            string tmp = data;

            string[] s1 = Regex.Split(tmp, @"\s+|[.]|,|;|:");
            //2004-11-14
            Dictionary<DateTime, string> tdic = new Dictionary<DateTime, string>();
            
            foreach (string s in s1)
            {
                if (s.Trim().Length < 5) continue;

                DateTime dt = DateTime.MinValue;

                bool p = DateTime.TryParse(s.Replace(",", "").Replace(";", ""), out dt);

                if (dt > DateTime.Today) continue;

                if (dt < DateTime.Parse("1/1/1500")) continue;

                if (p)
                {
                    if (!tdic.ContainsKey(dt))
                    {
                        tdic.Add(dt, "");
                    }
                }
            }
            return tdic.Keys.ToList<DateTime>();
        }
        public static List<long> GetLong(string data, string fileType)
        {
            string tmp = data;

            tmp = tmp.Replace("<^>", " ");
            tmp = tmp.Replace(";", " ");
            if (fileType == "CSV")
            {
                tmp = tmp.Replace(",", " ");
            }
            string[] s1 = Regex.Split(tmp, @"\s+");
            Dictionary<long, long> tdic = new Dictionary<long, long>();
            foreach (string s in s1)
            {
                long l = 0;

                string s2 = s;

                s2 = s2.Replace("$", "");
                s2 = s2.Replace("(", "-");
                s2 = s2.Replace(")", "");
                s2 = s2.Replace(";", "");

                string[] s3 = s2.Split('.');

                bool p = long.TryParse(s, out l);
                if (p)
                {
                    if (!tdic.ContainsKey(l))
                    {
                        tdic.Add(l, l);
                    }
                }
            }
            return tdic.Keys.ToList<long>();
        }
        public static List<long> GetLong(string data, List<List<double>> ll)
        {
            string tmp = data;

            string[] s1 = Regex.Split(tmp, @"\D+");

            List<long> retVals = new List<long>();

            foreach (string s in s1)
            {
                bool saveVal = true;
                if (ll != null)
                {
                    foreach (List<double> llng in ll)
                    {
                        if (llng.Count == 2)
                        {
                            string a = llng[0].ToString();
                            string b = llng[1].ToString();
                            if (a.Contains(s) || b.Contains(s))
                            {
                                saveVal = false;
                                break;
                            }
                        }
                    }
                }

                if (saveVal)
                {

                    long l;
                    bool tp = long.TryParse(s, out l);
                    if (tp)
                    {
                        retVals.Add(l);
                    }
                }
            }

            if (retVals.Count > 0)
            {
                return retVals.Distinct().ToList<long>();
            }
            else
            {
                return null;
            }
        }
        public static string[] GetDistinctSortedAlpha(string data)
        {
            string[] parts = Regex.Split(data, @"[^a-z]|[^A-Z]");
            List<string> l1 = parts.Distinct().ToList<string>();
            string[] l2 = l1.ToArray<string>();
            Array.Sort(l2);
            return l2;
        }
        public static string[] GetDistinctNumbers(string data)
        {
            string[] parts = Regex.Split(data, @"\D+");
            List<string> l1 = parts.Distinct().ToList<string>();
            string[] l2 = l1.ToArray<string>();
            Array.Sort(l2);
            return l2;
        }
        public static List<string> GetZipCodes(string data)
        {
            MatchCollection mc = RegexHelper.matchZipCode.Matches(data);
            Dictionary<string, string> zips = new Dictionary<string, string>();
            foreach (Match m in mc)
            {
                if (m.Success)
                {
                    string v = m.Groups[0].Value.Trim();
                    if (!zips.ContainsKey(v.Trim()))
                    {
                        zips.Add(v.Trim(), "");
                    }
                }
            }
            return zips.Keys.ToList<string>();
        }
        public static List<string> GetPhoneNumbers(string data)
        {
            MatchCollection mc = RegexHelper.matchPhoneNumber.Matches(data);
            Dictionary<string, string> phones = new Dictionary<string, string>();
            foreach (Match m in mc)
            {
                if (m.Success)
                {
                    string v = m.Groups[0].Value.Trim();

                    if (v.Contains('-') || v.Contains('.'))
                    {
                        v = Regex.Replace(v, @"\D+", "");
                        if (!phones.ContainsKey(v.Trim()))
                        {
                            phones.Add(v.Trim(), "");
                        }
                    }
                }
            }
            return phones.Keys.ToList<string>();
        }
        public static List<string> GetEmails(string data)
        {
            MatchCollection mc = RegexHelper.matchEmailLenient.Matches(data);
            Dictionary<string, string> emails = new Dictionary<string, string>();
            foreach (Match m in mc)
            {
                if (m.Success)
                {
                    string v = m.Groups[0].Value.Trim();
                    if (!emails.ContainsKey(v.Trim()))
                    {
                        emails.Add(v.Trim(), "");
                    }
                }
            }
            return emails.Keys.ToList<string>();
        }
        public static List<string> GetRegexMaches(string data)
        {
            MatchCollection mc = RegexHelper.matchIsA.Matches(data);
            Dictionary<string, string> isa = new Dictionary<string, string>();
            foreach (Match m in mc)
            {
                if (m.Success)
                {
                    string v = m.Groups[0].Value.Trim();
                    if (!isa.ContainsKey(v.Trim()))
                    {
                        isa.Add(v.Trim(), "");
                    }
                }
            }
            return isa.Keys.ToList<string>();
        }
        public static List<string> GetLatLong2(string data)
        {
            List<List<double>> latlong = GetLatLong(data);
            if (latlong.Count > 0)
            {
                Dictionary<string, string> dict = new Dictionary<string, string>();
                foreach (List<double> ll in latlong)
                {
                    string llk = "[LALO:" + ll[0].ToString() + '|' +
                            ll[1].ToString() + "]";
                    dict[llk] = "";
                }
                return dict.Keys.ToList<string>();
            }
            else return null;
        }
        public static List<List<double>> GetLatLong(string data)
        {
            if (data == null) return null;

            string data2 = data.Replace('"', ' ').Replace(" ", "");

            MatchCollection mc = RegexHelper.matchLatLong2.Matches(data2);
            Dictionary<string, string> lls = new Dictionary<string, string>();
            foreach (Match m in mc)
            {
                if (m.Success)
                {
                    string v = m.Groups[0].Value.Trim();
                    string[] vals = v.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                    if (vals.Length == 2)
                    {
                        double lat = -999.0;
                        double lon = -999.0;

                        bool lab = double.TryParse(vals[0].Trim(), out lat);
                        bool lob = double.TryParse(vals[1].Trim(), out lon);

                        if (lab && lob)
                        {

                            //Valid value for the latitude are from -90.0° to 90.0° for 
                            //the longitude are from -180.0° to 180.0°, the + sign 
                            //should be omitted, while the minus sign is ...

                            if ((lat >= -90.0 && lat <= 90.0) &&
                                (lon >= -180.0 && lon <= 180.0))
                            {
                                string key = lat.ToString() + "," + lon.ToString();

                                if (!lls.ContainsKey(key))
                                {
                                    lls.Add(key, "");
                                }
                            }
                            else if ((lon >= -90.0 && lon <= 90.0) &&
                                    (lat >= -180.0 && lat <= 180.0))
                            {
                                string key = lon.ToString() + "," + lat.ToString();

                                if (!lls.ContainsKey(key))
                                {
                                    lls.Add(key, "");
                                }
                            }
                        }
                    }
                }
            }
            
            List<string> dbls = lls.Keys.ToList<string>();

            List<List<double>> rets = new List<List<double>>();

            foreach (string ll in dbls)
            {
                string[] splits = ll.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                if (splits.Length == 2)
                {
                    try
                    {
                        double lat = double.Parse(splits[0]);
                        double lon = double.Parse(splits[1]);

                        List<double> dls = new List<double>();
                        dls.Add(lat);
                        dls.Add(lon);
                        rets.Add(dls);
                    }
                    catch { }
                }
            }

            return rets;
        }
        public static List<string> Segments2(string line, int segLen)
        {
            int recSize = 0;
            string[] parts = line.Split('|');
            StringBuilder sb = new StringBuilder();
            List<string> ret = new List<string>();
            foreach (string p in parts)
            {
                string p2 = p.Trim();
                if (p2.Length < 1) continue;
                recSize = recSize + p2.Length;
                sb.Append(p2).Append(' ');
                if (recSize > segLen - 10)
                {
                    ret.Add(sb.ToString().Trim().Replace(' ','|'));
                    sb = new StringBuilder();
                    recSize = 0;
                }
            }
            if (sb.Length > 0)
            {
                ret.Add(sb.ToString().Trim().Replace(' ', '|'));
            }
            return ret;
        }
        public static List<string> Segments(string line, int segLen)
        {
            List<string> parts = new List<string>();
            StringBuilder sb = new StringBuilder();
            int cCount = 0;
            foreach (char c in line)
            {
                cCount++;
                sb.Append(c);
                if (cCount == segLen)
                {
                    string l2 = sb.ToString().Trim();
                    if (l2 != "")
                    {
                        parts.Add(sb.ToString());
                    }
                    sb = new StringBuilder();
                    cCount = 0;
                }
            }
            if (sb.Length > 0) parts.Add(sb.ToString());
            return parts;
        }
        public static string Encoder2(string tok)
        {
            StringBuilder sb = new StringBuilder();
            foreach (char c in tok.ToUpper())
            {
                int vc = (int)c;
                if (vc > 127) continue;
                if (Char.IsLetterOrDigit(c))
                {
                    sb.Append(c);
                }
                if (Char.IsPunctuation(c))
                {
                    sb.Append(c);
                }
            }
            return sb.ToString().Trim();
        }
        public static string Encoder1(string tok)
        {
            if(tok == "[[DJS<<") return tok;

            StringBuilder sb = new StringBuilder();
            foreach (char c in tok.ToUpper())
            {
                int vc = (int)c;
                if (vc > 127) continue;
                if (Char.IsLetterOrDigit(c))
                {
                    sb.Append(c);
                }
                if (Char.IsPunctuation(c))
                {
                    sb.Append(c);
                }
            }
            return sb.ToString().Trim();
        }
        public static string EncodeString1(string value)
        {
            string v2 = value.Trim().ToUpper();
            char[] v3 = v2.ToCharArray();
            StringBuilder sb = new StringBuilder();
            foreach (char c in v3)
            {
                int i = (int)c;
                if (i < 256)
                {
                    if (Char.IsLetterOrDigit(c))
                    {
                        sb.Append(c);
                    }
                    else if (c == ',' ||
                         c == ':' ||
                         c == '.' ||
                         c == '~' ||
                         c == '`' ||
                         c == '!' ||
                         c == '@' ||
                         c == '#' ||
                         c == '$' ||
                         c == '%' ||
                         c == '^' ||
                         c == '&' ||
                         c == '*' ||
                         c == '(' ||
                         c == ')' ||
                         c == '-' ||
                         c == '_' ||
                         c == '=' ||
                         c == '+' ||
                         c == '{' ||
                         c == '[' ||
                         c == '}' ||
                         c == ']' ||
                         c == ';' ||
                         c == '"' ||
                         c == '\'' ||
                         c == '<' ||
                         c == '>' ||
                         c == '\\' ||
                         c == ',' ||
                         c == '?' ||
                         c == '/')
                    {
                        sb.Append(c);
                    }
                    else sb.Append(' ');
                }
            }

            string rtok = sb.ToString().Trim();

            rtok = Regex.Replace(rtok, @"\s+", " ");

            return rtok.Trim();
        }
        public static string EncodeString2(string value)
        {
            string v2 = value.Trim().ToUpper();
            if (v2 == "") return "";
            char[] v3 = v2.ToCharArray();
            StringBuilder sb = new StringBuilder();
            foreach (char c in v3)
            {
                int i = (int)c;
                sb.Append(i.ToString()).Append(' ');
            }
            return sb.ToString().Trim().Replace(' ', 'x');
        }
        public static long TimeKeyShort()
        {
            DateTime val = DateTime.Now;
            int yr = val.Year;
            int mo = val.Month;
            int dy = val.Day;
            return long.Parse(yr.ToString() +
                mo.ToString().PadLeft(2, '0') +
                dy.ToString().PadLeft(2, '0'));
        }
        public static long TimeKeyLong()
        {
            DateTime val = DateTime.Now;
            int yr = val.Year;
            int mo = val.Month;
            int dy = val.Day;
            int hr = val.Hour;
            int mi = val.Minute;
            int sc = val.Second;
            return long.Parse(yr.ToString() +
                mo.ToString().PadLeft(2, '0') +
                dy.ToString().PadLeft(2, '0') +
                hr.ToString().PadLeft(2, '0') +
                mi.ToString().PadLeft(2, '0') +
                sc.ToString().PadLeft(2, '0'));
        }
        public static long TimeKeyLong(DateTime val)
        {
            int yr = val.Year;
            int mo = val.Month;
            int dy = val.Day;
            return long.Parse(yr.ToString() + mo.ToString().PadLeft(2, '0') + dy.ToString().PadLeft(2, '0'));
        }
        public static string ParsePdfFiles(string sourcePDF)
        {
            StringBuilder sb = new StringBuilder();

            try
            {
                PdfReader reader = new PdfReader(sourcePDF);
                int toPageNum = reader.NumberOfPages;
                int fromPageNum = 1;
                byte[] pageBytes = null;
                PRTokeniser token = null;
                PRTokeniser.TokType tknType;
                string tknValue = string.Empty;

                if (fromPageNum > toPageNum) return "From and to page number wrong.";

                for (int i = fromPageNum; i < toPageNum; i++)
                {
                    pageBytes = reader.GetPageContent(i);
                    if (pageBytes != null)
                    {
                        token = new PRTokeniser(pageBytes);
                        while (token.NextToken())
                        {
                            tknType = token.TokenType;
                            tknValue = token.StringValue;

                            int iTknType = (int)tknType;

                            if (tknType == PRTokeniser.TokType.STRING)
                            {
                                sb.Append(token.StringValue);
                            }
                            else if (iTknType == 1 && tknValue == "-600")
                            {
                                sb.Append(' ');
                            }
                            else if (iTknType == 10 && tknValue == "TJ")
                            {
                                sb.Append(' ');
                            }
                        }
                    }
                }

                return sb.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
        public static bool IsMobileAddress(string fromAddress)
        {
            //Sprint	phonenumber@messaging.sprintpcs.com
            //Verizon	phonenumber@vtext.com
            //T-Mobile	phonenumber@tmomail.net
            //AT&T	phonenumber@txt.att.net

            //Carrier  	Send Email to phonenumber@....
            //Alltel 	@message.alltel.com
            //AT&T 	@mms.att.net
            //Nextel 	@messaging.nextel.com
            //Sprint 	@messaging.sprintpcs.com
            //SunCom 	@tms.suncom.com
            //T-mobile 	@tmomail.net
            //VoiceStream 	@voicestream.net
            //Verizon 	@vtext.com (text only)
            //@vzwpix.com (pictures and videos)

            string[] splt = fromAddress.Split('@');

            if (splt == null) return false;

            if (splt.Length < 2) return false;

            long pv = -1;

            bool isNum = long.TryParse(splt[0].Trim(), out pv);

            if (!isNum) return false;

            if (fromAddress == null) return false;
            if (fromAddress.Trim().Length < 3) return false;

            fromAddress = fromAddress.ToLower().Trim();

            if (fromAddress.Contains("messaging.sprintpcs.com"))
            {
                return true;
            }

            if (fromAddress.Contains("vtext.com"))
            {
                return true;
            }

            if (fromAddress.Contains("tmomail.net"))
            {
                return true;
            }

            if (fromAddress.Contains("messaging.nextel.com"))
            {
                return true;
            }

            if (fromAddress.Contains("txt.att.net"))
            {
                return true;
            }

            //if (fromAddress.Contains("mms.att.net"))
            //{
            //    return true;
            //}

            if (fromAddress.Contains("message.alltel.com"))
            {
                return true;
            }

            if (fromAddress.Contains("tms.suncom.com"))
            {
                return true;
            }

            if (fromAddress.Contains("voicestream.net"))
            {
                return true;
            }

            if (fromAddress.Contains("cwwsms.com")) return true;
            if (fromAddress.Contains("satellink.net")) return true;
            if (fromAddress.Contains("my2way.com")) return true;
            if (fromAddress.Contains("page.metrocall.com")) return true;
            if (fromAddress.Contains("bellmobility.ca")) return true;
            if (fromAddress.Contains("blueskyfrog.com")) return true;
            if (fromAddress.Contains("bplmobile.com")) return true;
            if (fromAddress.Contains("cellularonewest.com")) return true;
            if (fromAddress.Contains("clearlydigital.com")) return true;
            if (fromAddress.Contains("comcastpcs.textmsg.com")) return true;
            if (fromAddress.Contains("corrwireless.net")) return true;
            if (fromAddress.Contains("csouth1.com")) return true;
            if (fromAddress.Contains("cwemail.com")) return true;
            if (fromAddress.Contains("email.swbw.com")) return true;
            if (fromAddress.Contains("email.uscc.net")) return true;
            if (fromAddress.Contains("fido.ca")) return true;
            if (fromAddress.Contains("ideacellular.net")) return true;
            if (fromAddress.Contains("inlandlink.com")) return true;
            if (fromAddress.Contains("ivctext.com")) return true;
            if (fromAddress.Contains("message.alltel.com")) return true;
            if (fromAddress.Contains("messaging.centurytel.net")) return true;
            if (fromAddress.Contains("messaging.nextel.com")) return true;
            if (fromAddress.Contains("messaging.sprintpcs.com")) return true;
            if (fromAddress.Contains("mobile.celloneusa.com")) return true;
            if (fromAddress.Contains("mobile.dobson.net")) return true;
            if (fromAddress.Contains("mobile.surewest.com")) return true;
            if (fromAddress.Contains("mobilecomm.net")) return true;
            if (fromAddress.Contains("msg.clearnet.com")) return true;
            if (fromAddress.Contains("msg.telus.com")) return true;
            if (fromAddress.Contains("myboostmobile.com")) return true;
            if (fromAddress.Contains("mymetropcs.com")) return true;
            if (fromAddress.Contains("onlinebeep.net")) return true;
            if (fromAddress.Contains("pagemci.com")) return true;
            if (fromAddress.Contains("paging.acswireless.com")) return true;
            if (fromAddress.Contains("pcs.rogers.com")) return true;
            if (fromAddress.Contains("pcsone.net")) return true;
            if (fromAddress.Contains("qwestmp.com")) return true;
            if (fromAddress.Contains("sms.3rivers.net")) return true;
            if (fromAddress.Contains("sms.bluecell.com")) return true;
            if (fromAddress.Contains("sms.edgewireless.com")) return true;
            if (fromAddress.Contains("sms.goldentele.com")) return true;
            if (fromAddress.Contains("sms.pscel.com")) return true;
            if (fromAddress.Contains("sms.wcc.net")) return true;
            if (fromAddress.Contains("text.houstoncellular.net")) return true;
            if (fromAddress.Contains("text.mtsmobility.com")) return true;
            if (fromAddress.Contains("tmomail.net")) return true;
            if (fromAddress.Contains("tms.suncom.com")) return true;
            if (fromAddress.Contains("txt.att.net")) return true;
            if (fromAddress.Contains("txt.bell.ca")) return true;
            if (fromAddress.Contains("txt.bellmobility.ca")) return true;
            if (fromAddress.Contains("uswestdatamail.com")) return true;
            if (fromAddress.Contains("utext.com")) return true;
            if (fromAddress.Contains("vmobile.ca")) return true;
            if (fromAddress.Contains("vmobl.com")) return true;
            if (fromAddress.Contains("vtext.com")) return true;
            if (fromAddress.Contains("mms.att.net")) return true;
            if (fromAddress.Contains("mms.mycingular.com")) return true;

//satellink.net
//my2way.com
//page.metrocall.com
//bellmobility.ca
//blueskyfrog.com
//bplmobile.com
//cellularonewest.com
//clearlydigital.com
//comcastpcs.textmsg.com
//corrwireless.net
//csouth1.com
//cwemail.com
//email.swbw.com
//email.uscc.net
//fido.ca
//ideacellular.net
//inlandlink.com
//ivctext.com
//message.alltel.com
//messaging.centurytel.net
//messaging.nextel.com
//messaging.sprintpcs.com
//mobile.celloneusa.com
//mobile.dobson.net
//mobile.surewest.com
//mobilecomm.net
//msg.clearnet.com
//msg.telus.com
//myboostmobile.com
//mymetropcs.com
//onlinebeep.net
//pagemci.com
//paging.acswireless.com
//pcs.rogers.com
//pcsone.net
//qwestmp.com
//sms.3rivers.net
//sms.bluecell.com
//sms.edgewireless.com
//sms.goldentele.com
//sms.pscel.com
//sms.wcc.net
//text.houstoncellular.net
//text.mtsmobility.com
//tmomail.net
//tms.suncom.com
//txt.att.net
//txt.bell.ca
//txt.bellmobility.ca
//uswestdatamail.com
//utext.com
//vmobile.ca
//vmobl.com
//vtext.com
            return false;

        }
    }
}
