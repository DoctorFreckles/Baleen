using System;
using System.Data;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using Pop3;
using System.Net.Mail;
using System.Configuration;
using System.Timers;
using BaleenLib.Utility;

namespace BaleenLib
{
    public class EmailAgent
    {
        public static string Pop3EmailServer = "";
        public static string SmtpEmailServer = "";
        public static string EmailPassword = "";
        public static string EmailUserName = "";
        public static string SenderData = "";
        public static long PollingIntervalInSeconds = 100;
        public static Timer EmailCheck = null;
        static EmailAgent()
        {
            try
            {
                SenderData = ConfigurationManager.AppSettings["SenderData"];
                Pop3EmailServer = ConfigurationManager.AppSettings["Pop3EmailServer"];
                SmtpEmailServer = ConfigurationManager.AppSettings["SmtpEmailServer"];
                EmailPassword = ConfigurationManager.AppSettings["EmailPassword"];
                EmailUserName = ConfigurationManager.AppSettings["EmailUserName"];
                PollingIntervalInSeconds = long.Parse(ConfigurationManager.AppSettings["PollingIntervalInSeconds"]);
                EmailCheck = new Timer(PollingIntervalInSeconds * 1000);
                EmailCheck.Elapsed += new ElapsedEventHandler(EmailCheck_Elapsed);
            }
            catch(Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
        protected static void EmailCheck_Elapsed(object sender, ElapsedEventArgs e)
        {
            EmailCheck.Stop();
            try
            {
                MessageReceiptCycle();
                //MessageResponseCycle();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                EmailCheck.Start();
            }
        }
        public static void Start()
        {
            try
            {
                EmailCheck.Start();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
        public static void MessageResponseCycle()
        {
            DirectoryInfo di = new DirectoryInfo(SenderData);
            RespondToProviderQuery(di);
        }
        public static void RespondToProviderQuery(DirectoryInfo di)
        {
            DirectoryInfo[] subs = di.GetDirectories("*npi@dendritica.com*", SearchOption.AllDirectories);
            if (subs != null && subs.Length > 0)
            {
                foreach (DirectoryInfo d in subs)
                {
                    string pmail = d.Parent.Name;

                    string[] parts = pmail.Split('@');

                    int tryI = 0;

                    bool isSMS = false;

                    if (int.TryParse(parts[0], out tryI))
                    {
                        isSMS = true;
                    }

                    FileInfo[] requests = d.GetFiles("*.txt");
                    List<string> delete = new List<string>();
                    foreach (FileInfo f in requests)
                    {
                        string data = File.ReadAllText(f.FullName);
                        MatchCollection mc = RegexHelper.MatchEmailRequestBlock.Matches(data);
                        delete.Add(f.FullName);
                        if (mc.Count >= 2)
                        {
                            int i1 = mc[0].Index;
                            int i2 = mc[1].Index;
                            string sub = data.Substring(i1, i2 + 3 - i1);
                            sub = sub.Replace("<^>", "")
                                .Trim();
                            sub = RegexHelper.SplitWS.Replace(sub, " ").Trim();

                            if (sub.ToLower() == "help")
                            {
                                Utility.EmailResponse.SmtpHtmlEmail(pmail, "npi@dendritica.com",
                                        "***HELP FILE ATTACHED***", "HELP FILE",
                                        EmailAgent.SmtpEmailServer,
                                        EmailAgent.EmailUserName,
                                        EmailAgent.EmailPassword, "help.pdf");
                            }
                            else
                            {
                                if (isSMS)
                                {
                                    DataTable dt = NpiDAL.Query(BaleenAgent.DBReadOnlyUser, sub, 5);
                                    StringBuilder resp = new StringBuilder();
                                    if (dt.Rows.Count > 0)
                                    {
                                        foreach (DataRow dr in dt.Rows)
                                        {
                                            resp.Append("{");
                                            for (int i = 0; i < dt.Columns.Count; i++)
                                            {
                                                if (i > 11) continue;
                                                string col = dt.Columns[i].ColumnName;
                                                string val = dr[i].ToString().Trim();
                                                if (String.IsNullOrEmpty(val)) continue;
                                                resp.Append(col).Append(" = ").Append(val).Append("|");
                                            }
                                            resp.Append("}, ");
                                        }
                                    }
                                    else
                                    {
                                        resp.Append("NO RESULTS FOUND...");
                                    }

                                    Utility.EmailResponse.AsciiEmail(
                                            pmail,
                                            "npi@dendritica.com",
                                            resp.ToString(),
                                            "NPI - Query Response",
                                            EmailAgent.SmtpEmailServer,
                                            EmailAgent.EmailUserName,
                                            EmailAgent.EmailPassword);
                                }
                                else
                                {
                                    string tbl = NpiDAL.QueryToHtmlTable(BaleenAgent.DBReadOnlyUser, sub, 100);

                                    StringBuilder htmlSnippet = new StringBuilder();

                                    htmlSnippet.Append("<html><table>");
                                    htmlSnippet.Append("<tr><td style='font-family: Arial;'>");
                                    htmlSnippet.Append("<b>NPI Where Clause:</b> " + sub);
                                    htmlSnippet.Append("</td></tr>");
                                    htmlSnippet.Append("<tr><td>");
                                    htmlSnippet.Append(tbl);
                                    htmlSnippet.Append("</td></tr>");
                                    htmlSnippet.Append("</table></html>");

                                    Utility.EmailResponse.SmtpHtmlEmail(pmail, "npi@dendritica.com",
                                        htmlSnippet.ToString(), "NPI - Query Response",
                                        EmailAgent.SmtpEmailServer,
                                        EmailAgent.EmailUserName,
                                        EmailAgent.EmailPassword, null);
                                }
                            }
                        }
                    }
                    foreach (string del in delete)
                    {
                        File.Delete(del);
                    }
                }
            }
        }
        public static void MessageReceiptCycle()
        {
            Pop3Client popClient = null;
            string currentFromEmail = "";
            string currentToEmail = "";
            try
            {
                popClient = new Pop3Client();
                popClient.Connect(EmailAgent.Pop3EmailServer, EmailAgent.EmailUserName, EmailAgent.EmailPassword);
                List<Pop3Message> messages = popClient.List();
                int msgCount = 0;
                foreach (Pop3Message message in messages)
                {
                    msgCount++;
                    Console.WriteLine("Reading Msg: " + msgCount.ToString());
                    popClient.Retrieve(message);
                    string toPart = message.To;
                    string fromPart = message.From;
                    Console.WriteLine("From: " + fromPart);
                    string body = message.Body;
                    string b2 = System.Web.HttpUtility.HtmlDecode(body).Trim();
                    string msgID = Guid.NewGuid().ToString();

                    currentToEmail = toPart;
                    currentFromEmail = fromPart;

                    string[] toArr = currentToEmail.Split(new char[] {'[', ']', '{', '}', ';', '<', '>', ' ', ':', '"' }, StringSplitOptions.RemoveEmptyEntries);
                    string[] fromArr = currentFromEmail.Split(new char[] {'[', ']', '{', '}', ';', '<', '>', ' ', ':', '"' }, StringSplitOptions.RemoveEmptyEntries);

                    string toAddress = null;
                    string fromAddress = null;

                    foreach (string s in toArr)
                    {
                        if (s.Contains("@") && s.Contains("."))
                        {
                            toAddress = s;
                            break;
                        }
                    }

                    foreach (string s in fromArr)
                    {
                        if (s.Contains("@") && s.Contains("."))
                        {
                            fromAddress = s;
                            break;
                        }
                    }

                    if (toAddress == null || fromAddress == null) continue;

                    string senderQueue = SenderData + fromAddress + "\\";
                    if (!Directory.Exists(senderQueue))
                    {
                        Directory.CreateDirectory(senderQueue);
                    }
                    string msgQueue = senderQueue + toAddress + "\\";
                    if (!Directory.Exists(msgQueue))
                    {
                        Directory.CreateDirectory(msgQueue);
                    }
                    File.WriteAllText(msgQueue + msgID + ".txt", b2);
                    popClient.Delete(message);
                }
                Console.WriteLine("******************************");
                Console.WriteLine("Time: " + DateTime.Now.ToString());
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (popClient != null)
                {
                    popClient.Disconnect();
                }
            }
        }
    }
}