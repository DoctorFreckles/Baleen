//http://www.revenmerchantservices.com/page/Read-pop3-email-attachments-component.aspx
using System;
using System.Collections.Generic;
using System.Text;
using System.Net;
using System.Net.Sockets;
using System.Net.Security;
using System.IO;
using System.Threading;

namespace DendraLib.Web
{
    public class TCPclient
    {
        private string _popServer;
        public string PopServer
        {
            get { return _popServer; }
            set { _popServer = value; }
        }
        private int _popPort;
        public int PopPort
        {
            get { return _popPort; }
            set { _popPort = value; }

        }
        private string _loginName;
        public string LoginName
        {
            get { return _loginName; }
            set { _loginName = value; }
        }
        private string _password;
        public string Password
        {
            get { return _password; }
            set { _password = value; }
        }
        private string _email;
        private string Email
        {
            get { return _email; }
            set { _email = value; }
        }
        TcpClient tcpclient = new TcpClient();

        NetworkStream ntstrm;
        StreamReader strmR;

        StreamWriter strmW;
        public void Connect()
        {
            if (!tcpclient.Connected)
            {

                tcpclient.Connect(_popServer, _popPort);

                ntstrm = tcpclient.GetStream();
                strmR = new StreamReader(ntstrm);

                strmW = new StreamWriter(ntstrm); strmW.WriteLine(
                 "USER " + _loginName);

                strmW.Flush();
                strmW.WriteLine("PASS " + _password);

                strmW.Flush();

            }

        }
        public string SendCommand(string command)
        {
            string strTemp = command;

            //foreach(string str in parm)

            //{

            // command+=" " ;

            // command+=str;

            //}

            //strmW.WriteLine("LIST");

            //strmW.Flush();

            strmW.WriteLine(command);

            strmW.Flush();
            return GetResponse(command);

        }
        private string GetResponse(string command)
        {
            string line = string.Empty;

            Thread.Sleep(2000);
            if (command == "STAT")
            {

                line = strmR.ReadLine();

            }

            else
            {
                Thread.Sleep(3000); byte[] arrResponse = new byte[10000000];

                ntstrm.Read(arrResponse, 0, arrResponse.Length);

                string str = System.Text.Encoding.ASCII.GetString(arrResponse);
                return str;

            }


            return line;

        }
        public void CloseConnection()
        {

            tcpclient.Close();

            ntstrm.Close();

            strmR.Close();

            strmW.Close();

        }
    }

    public class SmtpConnect
    {

    }
}
