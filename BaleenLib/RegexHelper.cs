using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace BaleenLib
{
    public class RegexHelper
    {
        public static Regex MatchEmailRequestBlock =
            new Regex(@"([\<][\^][\>])", RegexOptions.Compiled);
        public static Regex CSVandQUOTESplit = new Regex(@""",""", RegexOptions.Compiled);
        public static Regex SplitWS = new Regex(@"\s+", RegexOptions.Compiled | RegexOptions.IgnoreCase);
        public static Regex matchIsA = new Regex(@"
(\w{5,})
\s+
(is|has|was|will|won't|can't|should|should'nt|know|known|his|hers|for|ours|on|off|in|near|far)
\s+
(\w{5,})
", RegexOptions.Compiled | RegexOptions.IgnorePatternWhitespace);
        public static Regex matchLatLong = new Regex(@"[-]?\d+[\.]\d+\s*[,]\s*[""]?\s*[-]?\d+[\.]\d+", RegexOptions.Compiled);
        public static Regex matchLatLong2 = new Regex(@"
[-]?\d+[\.]\d+[,][-]?\d+[\.]\d+
", RegexOptions.Compiled | RegexOptions.IgnorePatternWhitespace);
        public static Regex matchEmailLenient = new Regex(@"\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*", RegexOptions.Compiled);
        public static Regex matchEmailStrict = new Regex(@"^(([^<>()[\]\\.,;:\s@\""]+"
                        + @"(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@"
                        + @"((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
                        + @"\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+"
                        + @"[a-zA-Z]{2,}))$", RegexOptions.Compiled);
        public static Regex matchPhoneNumber = new Regex(@"\W*([2-9][0-8][0-9])\W*([2-9][0-9]{2})\W*([0-9]{4})(\se?x?t?(\d*))", RegexOptions.Compiled);
        public static Regex matchZipCode = new Regex("\\s(\\d{5})(-\\d{4})?\\D", RegexOptions.Compiled);
    }
}
