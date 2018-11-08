using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace BaleenLib.Logic.Prolog
{
    public class PrologServices
    {
        private static string UserFiles = "";
        private static string PLConExePath = "";
        private static int TimeoutSeconds = 30;
        private static Dictionary<string, LogicEXE> Engines = new Dictionary<string, LogicEXE>();
        static PrologServices()
        {

        }
    }
}
