using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Configuration;

namespace BaleenLib
{
    public class VectoraParser
    {
        private static Regex CSVandQUOTESplit =
            new Regex(@""",""", RegexOptions.Compiled);
        private static Dictionary<string, long> Tokens = new Dictionary<string,long>();
        private static string[] CsvQuoteSplit(string ln)
        {
            if (String.IsNullOrEmpty(ln)) return null;
            string ln2 = ln.Trim();
            if (ln2.Length < 1) return null;
            return CSVandQUOTESplit.Split(ln2);
        }
        public static string FormattedBytesMB(long bytes)
        {
            double b2 = ((double)bytes) / 1000000;
            return ((int)b2).ToString();
        }
        public static int GetTableWidth(int recordSizeMax)
        {
            if (recordSizeMax <= 10) return 10;
            else if (recordSizeMax <= 20) return 20;
            else if (recordSizeMax <= 30) return 30;
            else if (recordSizeMax <= 40) return 40;
            else if (recordSizeMax <= 50) return 50;
            else if (recordSizeMax <= 60) return 60;
            else if (recordSizeMax <= 70) return 70;
            else if (recordSizeMax <= 80) return 80;
            else if (recordSizeMax <= 90) return 90;
            else if (recordSizeMax <= 100) return 100;
            else if (recordSizeMax > 100 && recordSizeMax <= 200) return 200;
            else if (recordSizeMax > 200 && recordSizeMax <= 400) return 400;
            throw new Exception("The record size is too large for this configuration.");
        }
        public static void LoadFact(
            string completeBaleenFilePath,
            string DBConnect)
        {
            SqlConnection c = null;
            try
            {
                c = new SqlConnection(DBConnect);
                c.Open();
                FileInfo fi = new FileInfo(completeBaleenFilePath);
                StreamReader sr = new StreamReader(completeBaleenFilePath);
                long lineCount = 0;
                long bytesLoaded = 0;
                StringBuilder sb = new StringBuilder();
                while (!sr.EndOfStream)
                {
                    string ln = sr.ReadLine();
                    sb.Append(ln).Append('\r').Append('\n');
                    bytesLoaded += ln.Length;
                    lineCount++;
                    if (lineCount >= 1000)
                    {
                        SqlCommand cmd = new SqlCommand(sb.ToString(), c);
                        int res = cmd.ExecuteNonQuery();
                        lineCount = 0;
                        sb = new StringBuilder();
                        Console.WriteLine("Insert Result: " + res.ToString());
                        Console.WriteLine("MB Bytes Loaded: " + FormattedBytesMB(bytesLoaded));
                    }
                }
                sr.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (c != null) c.Close();
            }
        }
        public static void Init(string dbConnect)
        {
            using (SqlConnection c = new SqlConnection(dbConnect))
            {
                c.Open();
                Init(c);
                c.Close();
            }
        }
        public static void Init(SqlConnection cn)
        {
            string sql = @"
SELECT [dim_id]
      ,[dim_value]
FROM [dim_text_small]
";
            SqlCommand cmd = new SqlCommand(sql, cn);
            cmd.CommandTimeout = 1000;
            SqlDataReader sdr = cmd.ExecuteReader();
            long tokenLoadCount = 0;
            while (sdr.Read())
            {
                tokenLoadCount++;
                if (tokenLoadCount % 1000 == 0) Console.WriteLine("Tokens Loaded: " + tokenLoadCount.ToString());
                long id = sdr.GetInt64(0);
                string val = sdr.GetString(1);
                Tokens[val] = id;
            }
            sdr.Close();

            //we will need to init header records as well...
        }
        public static List<long> MakeList(
            bool toUpper,
            string[] record, 
            int MinusYearsMinDate, 
            int PlusYearsMaxDate, 
            SqlConnection cn,
            bool isCsv,
            bool isCsvAndQuoteDelim)
        {
            List<long> ll = new List<long>();
            foreach (string s in record)
            {
                ll.Add(GetID(toUpper, s, MinusYearsMinDate, PlusYearsMaxDate, cn, isCsv, isCsvAndQuoteDelim));
            }
            return ll;
        }
        public static long GetID(
            bool toUpper,
            string val, 
            int MinusYearsMinDate, 
            int PlusYearsMaxDate, 
            SqlConnection cn,
            bool isCsv,
            bool isCsvAndQuoteDelim)
        {
            val = val.Trim();
 
            if (String.IsNullOrEmpty(val) || val.Length < 1)
            {
                return -1;
            }

            if (toUpper) val = val.ToUpper();

            bool firstIsQuote = false;
            bool secondIsQuote = false;
            bool firstQsecondQSame = false;

            char f1 = val.Substring(0, 1)[0];
            char f2 = val.Substring(val.Length - 1, 1)[0];

            firstQsecondQSame = f1 == f2;
            firstIsQuote = f1 == '"' || f1 == '\'';
            secondIsQuote = f2 == '"' || f2 == '\'';

            if ((isCsv && firstQsecondQSame && firstIsQuote && secondIsQuote) || isCsvAndQuoteDelim)
            {
                if (f1 == '"') val = val.Replace("\"", "");
                if (f1 == '\'') val = val.Replace("'", "");
            }

            if (Tokens.ContainsKey(val))
            {
                return Tokens[val];
            }

            long returnID = -1;
            DateTime saveDtm = DateTime.MinValue;
            double saveDbl = 0.0;
            long saveLng = 0;
            bool isMemo = val.Length > 300;
            bool isDateTime = DateTime.TryParse(val, out saveDtm);
            DateTime minDate = DateTime.Now.AddYears(-MinusYearsMinDate);
            DateTime maxDate = DateTime.Now.AddYears(PlusYearsMaxDate);
            isDateTime = !(saveDtm < minDate || saveDtm > maxDate) &&
                (val.Contains('-') || val.Contains('/') || val.Contains('\\') || val.Contains(':'));
            string dblTest = val.Replace("\"", "").Replace("$", "").Replace("(", "-").Replace(")", "");
            bool containsAlpha = false;
            foreach (char c in dblTest)
            {
                if (Char.IsLetter(c))
                {
                    containsAlpha = true;
                    break;
                }
            }
            bool isDouble = containsAlpha == false && double.TryParse(dblTest, out saveDbl);
            bool isLong = long.TryParse(val, out saveLng);
            string saveString = "";

            if (isMemo)
            {
                saveString = "LARGE_TEXT:" + Guid.NewGuid().ToString() + ":" + val.Substring(0,100);
            }
            else
            {
                saveString = val;
            }

            SqlCommand cmd = null;

            string sqlSmallText = @"
declare @lid bigint
set @lid = null
SELECT top 1 @lid = [dim_id]
FROM [dim_text_small]
where dim_value = @val
if(@lid is null)
begin
insert into dim_text_small
(dim_value) 
values
(@val)
SELECT top 1 @lid = ([dim_id] * -1)
FROM [dim_text_small]
where dim_value = @val
end
select @lid 
";
            cmd = new SqlCommand(sqlSmallText, cn);
            cmd.CommandTimeout = 1000;
            cmd.Parameters.Add(new SqlParameter("@val", saveString));
            object oi = cmd.ExecuteScalar();
            if (oi != null)
            {
                returnID = (long)oi;
            }
            else
            {
                throw new Exception("Error trying to get Small Text ID.");
            }
            if (returnID < 0)
            {
                returnID = returnID * -1;
                if (isMemo)
                {
                    string sqlMemo = @"
INSERT INTO [dim_text_large]
       ([dim_id]
       ,[dim_value])
VALUES
       (@lid
       ,@val)
";
                    cmd = new SqlCommand(sqlMemo, cn);
                    cmd.CommandTimeout = 1000;
                    cmd.Parameters.Add(new SqlParameter("@val", val));
                    cmd.Parameters.Add(new SqlParameter("@lid", returnID));
                    int res = cmd.ExecuteNonQuery();
                }
                if (isDateTime)
                {
                    string sqlDateTime = @"
INSERT INTO [dim_datetime]
   ([dim_id]
   ,[dim_value])
VALUES
   (@lid
   ,@val)
";
                    cmd = new SqlCommand(sqlDateTime, cn);
                    cmd.CommandTimeout = 1000;
                    cmd.Parameters.Add(new SqlParameter("@val", saveDtm));
                    cmd.Parameters.Add(new SqlParameter("@lid", returnID));
                    int res = cmd.ExecuteNonQuery();
                }
                else if (isLong)
                {
                    string sqlLong = @"
INSERT INTO [dim_integer]
   ([dim_id]
   ,[dim_value])
VALUES
   (@lid
   ,@val)
";
                    cmd = new SqlCommand(sqlLong, cn);
                    cmd.CommandTimeout = 1000;
                    cmd.Parameters.Add(new SqlParameter("@val", saveLng));
                    cmd.Parameters.Add(new SqlParameter("@lid", returnID));
                    int res = cmd.ExecuteNonQuery();
                }
                else if (isDouble)
                {
                    string sqlFloat = @"
INSERT INTO [dim_float]
   ([dim_id]
   ,[dim_value])
VALUES
   (@lid
   ,@val)
";
                    cmd = new SqlCommand(sqlFloat, cn);
                    cmd.CommandTimeout = 1000;
                    cmd.Parameters.Add(new SqlParameter("@val", saveDbl));
                    cmd.Parameters.Add(new SqlParameter("@lid", returnID));
                    int res = cmd.ExecuteNonQuery();
                }
            }
            Tokens[val] = returnID;
            return returnID;
        }
        public static Dictionary<long, long> MakeVector(
            bool toUpper,
            Dictionary<string,string> record, 
            int MinusYearsMinDate, 
            int PlusYearsMaxDate, 
            SqlConnection cn,
            bool isCsv,
            bool isCsvAndQuoteDelim)
        {
            Dictionary<long,long> rec = new Dictionary<long,long>();
            foreach (string key in record.Keys)
            {
                long fld = GetID(toUpper, key, MinusYearsMinDate, PlusYearsMaxDate, cn, isCsv, isCsvAndQuoteDelim);
                rec[fld] = GetID(toUpper, record[key].ToUpper().Trim(), MinusYearsMinDate,PlusYearsMaxDate, cn, isCsv, isCsvAndQuoteDelim);
            }
            return rec;
        }
        public static void ParseDims(string directory, long startDimSeq)
        {
            string outputDirectory = directory + @"OUT\";

            if (!Directory.Exists(outputDirectory))
            {
                Directory.CreateDirectory(outputDirectory);
            }

            File.WriteAllText(outputDirectory + "start_time.txt", DateTime.Now.ToString());

            long dimensionalSequence = startDimSeq;

            Dictionary<string, long> dimTxt = new Dictionary<string, long>();

            StreamWriter swDtm = new StreamWriter(outputDirectory + "dim_datetime.tab");
            StreamWriter swLng = new StreamWriter(outputDirectory + "dim_long.tab");
            StreamWriter swDbl = new StreamWriter(outputDirectory + "dim_double.tab");
            StreamWriter swMem = new StreamWriter(outputDirectory + "dim_memo.tab");

            swMem.Write("DimKey");
            swMem.Write('\t');
            swMem.WriteLine("Large-Text");

            swDtm.Write("DimKey");
            swDtm.Write('\t');
            swDtm.WriteLine("Date-Time");

            swLng.Write("DimKey");
            swLng.Write('\t');
            swLng.WriteLine("Long-Integer");

            swDbl.Write("DimKey");
            swDbl.Write('\t');
            swDbl.WriteLine("Double-Number");

            DirectoryInfo di = new DirectoryInfo(directory);

            FileInfo[] fins = di.GetFiles("*",
                SearchOption.TopDirectoryOnly);

            foreach (FileInfo fi in fins)
            {
                long lineNo = 0;

                char splitter = ' ';

                bool isXML = false;

                bool isTab = false;

                bool isCsv = false;

                if (fi.Extension.ToLower() == ".tab")
                {
                    isTab = true;
                    splitter = '\t';
                }
                else if (fi.Extension.ToLower() == ".csv")
                {
                    isCsv = true;
                    splitter = ',';
                }
                else if (fi.Extension.ToLower() == ".xml")
                {
                    isXML = true;
                }
                else
                {
                    continue;
                }

                Console.WriteLine(fi.Name);

                if (isTab || isCsv)
                {
                    try
                    {
                        StreamReader sr = new StreamReader(fi.FullName);

                        string hdrLine = sr.ReadLine();

                        string[] hdr = null;

                        hdr = hdrLine.Split(splitter);

                        while (!sr.EndOfStream)
                        {
                            lineNo++;

                            if (lineNo % 1000 == 0) Console.WriteLine("Line NO: " + lineNo.ToString());

                            string[] fld = sr.ReadLine().Split(splitter);

                            if (fld.Length == hdr.Length)
                            {
                                StringBuilder rec = new StringBuilder();

                                for (int i = 0; i < hdr.Length; i++)
                                {
                                    string val = fld[i].Trim();

                                    if (fi.Extension.ToLower() == ".csv")
                                    {
                                        val = val.Replace("\"", "");
                                    }

                                    if (val.Length > 0)
                                    {
                                        DateTime dtm = DateTime.MinValue;

                                        double dbl = 0.0;

                                        long lng = 0;

                                        bool isMemo = val.Length > 300;

                                        bool isDateTime = DateTime.TryParse(val, out dtm);

                                        DateTime minDate = DateTime.Parse("1/1/1901");

                                        DateTime maxDate = DateTime.Now.AddYears(20);

                                        isDateTime = !(dtm < minDate || dtm > maxDate);

                                        string dblTest = val.Replace("\"", "").Replace("$", "").Replace("(", "-").Replace(")", "");

                                        bool isDouble = double.TryParse(dblTest, out dbl);

                                        bool isLong = long.TryParse(val, out lng);

                                        long fkey = -1;

                                        if (isMemo)
                                        {
                                            dimensionalSequence++;
                                            string valShort = val.Substring(0, 300);
                                            string valLong = val;
                                            dimTxt.Add(valShort, dimensionalSequence);

                                            swMem.Write(dimensionalSequence);
                                            swMem.Write('\t');
                                            swMem.WriteLine(valLong);

                                            fkey = dimensionalSequence;
                                        }
                                        else
                                        {
                                            if (dimTxt.ContainsKey(val))
                                            {
                                                fkey = dimTxt[val];
                                            }
                                            else
                                            {
                                                dimensionalSequence++;
                                                dimTxt.Add(val, dimensionalSequence);
                                                fkey = dimensionalSequence;

                                                if (isDateTime)
                                                {
                                                    swDtm.Write(dimensionalSequence);
                                                    swDtm.Write('\t');
                                                    swDtm.WriteLine(dtm.ToString());
                                                }

                                                if (isDouble)
                                                {
                                                    swDbl.Write(dimensionalSequence);
                                                    swDbl.Write('\t');
                                                    swDbl.WriteLine(dbl.ToString());
                                                }

                                                if (isLong)
                                                {
                                                    swLng.Write(dimensionalSequence);
                                                    swLng.Write('\t');
                                                    swLng.WriteLine(lng.ToString());
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine(ex.Message);
                    }
                }
                else if (isXML)
                {
                    StreamWriter sw = null;

                    try
                    {
                        DataSet dtst = new DataSet();

                        dtst.ReadXml(fi.FullName);

                        DataTable dt = dtst.Tables[0];

                        if (dt.Rows.Count > 0)
                        {
                            string[] nameParts = fi.Name.Split('.');

                            string fname = nameParts[0];

                            sw = new StreamWriter(outputDirectory + "BLN_" + fname + ".tab");

                            StringBuilder hdr = new StringBuilder();

                            for (int d = 0; d < dt.Columns.Count; d++)
                            {
                                hdr.Append(dt.Columns[d].ColumnName).Append('\t');
                            }

                            string hline = hdr.ToString().Substring(0, hdr.Length - 1);

                            sw.WriteLine(hline);

                            foreach (DataRow dr in dt.Rows)
                            {
                                lineNo++;

                                if (lineNo % 1000 == 0) Console.WriteLine("Line NO: " + lineNo.ToString());

                                for (int c = 0; c < dt.Columns.Count; c++)
                                {
                                    string val = dr[c].ToString();

                                    if (fi.Extension.ToLower() == ".csv")
                                    {
                                        val = val.Replace("\"", "");
                                    }

                                    if (val.Length > 0)
                                    {
                                        DateTime dtm = DateTime.MinValue;

                                        double dbl = 0.0;

                                        long lng = 0;

                                        bool isMemo = val.Length > 300;

                                        bool isDateTime = DateTime.TryParse(val, out dtm);

                                        DateTime minDate = DateTime.Parse("1/1/1901");

                                        DateTime maxDate = DateTime.Now.AddYears(20);

                                        isDateTime = !(dtm < minDate || dtm > maxDate);

                                        string dblTest = val.Replace("\"", "").Replace("$", "").Replace("(", "-").Replace(")", "");

                                        bool isDouble = double.TryParse(dblTest, out dbl);

                                        bool isLong = long.TryParse(val, out lng);

                                        long fkey = -1;

                                        if (isMemo)
                                        {
                                            dimensionalSequence++;
                                            string valShort = val.Substring(0, 300);
                                            string valLong = val;
                                            dimTxt.Add(valShort, dimensionalSequence);

                                            swMem.Write(dimensionalSequence);
                                            swMem.Write('\t');
                                            swMem.WriteLine(valLong);

                                            fkey = dimensionalSequence;
                                        }
                                        else
                                        {
                                            if (dimTxt.ContainsKey(val))
                                            {
                                                fkey = dimTxt[val];
                                            }
                                            else
                                            {
                                                dimensionalSequence++;
                                                dimTxt.Add(val, dimensionalSequence);
                                                fkey = dimensionalSequence;

                                                if (isDateTime)
                                                {
                                                    swDtm.Write(dimensionalSequence);
                                                    swDtm.Write('\t');
                                                    swDtm.WriteLine(dtm.ToString());
                                                }

                                                if (isDouble)
                                                {
                                                    swDbl.Write(dimensionalSequence);
                                                    swDbl.Write('\t');
                                                    swDbl.WriteLine(dbl.ToString());
                                                }

                                                if (isLong)
                                                {
                                                    swLng.Write(dimensionalSequence);
                                                    swLng.Write('\t');
                                                    swLng.WriteLine(lng.ToString());
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.Message);
                    }
                }
            }
            swDtm.Close();
            swLng.Close();
            swDbl.Close();
            swMem.Close();
            StreamWriter swTxt = new StreamWriter(outputDirectory + "dim_text.tab");
            swTxt.Write("DimKey");
            swTxt.Write('\t');
            swTxt.WriteLine("Small-Text");
            foreach (string key in dimTxt.Keys)
            {
                swTxt.Write(dimTxt[key].ToString());
                swTxt.Write('\t');
                swTxt.WriteLine(key);
            }
            swTxt.Close();
            File.WriteAllText(outputDirectory + "max_dimkey.kyf", dimensionalSequence.ToString());
            File.WriteAllText(outputDirectory + "end_time.txt", DateTime.Now.ToString());
        }
        public static void WriteRecord(
            List<long> rec, 
            StreamWriter sw,
            string createdOn,
            string createdBy,
            string objectOrFileName,
            SqlConnection cn,
            bool isCsv,
            bool isLine1,
            bool isCsvAndQuoteDelim)
        {
            if (rec == null || rec.Count < 1) return;
            long fni = GetID(true, objectOrFileName, 100, 50, cn, isCsv, isCsvAndQuoteDelim);
            long cri = GetID(true, createdOn, 100, 50, cn, isCsv, isCsvAndQuoteDelim);
            long byi = GetID(true, createdBy, 100, 50, cn, isCsv, isCsvAndQuoteDelim);
            int tn = GetTableWidth(rec.Count);
            string tblName = "baleen_" + tn.ToString().PadLeft(3, '0');
            StringBuilder sbd = new StringBuilder();
            StringBuilder sbc = new StringBuilder();
            for (int i = 0; i < rec.Count; i++)
            {
                sbc.Append("a_" + i.ToString()).Append(',');
                sbd.Append(rec[i].ToString()).Append(',');
            }
            string c = sbc.ToString();
            string d = sbd.ToString();

            string lnv = "0";

            if (isLine1) lnv = "1";

            string combined = "INSERT INTO " + tblName + " (" + c + 
            "created_on_key,created_by_key,updated_on_key,updated_by_key,type_or_file_key, is_line_1) values (" + d 
               + cri.ToString() + ',' +  
               byi.ToString() + ','
               + cri.ToString() + ',' +
               byi.ToString() + ',' +
               fni.ToString() + ',' +
               lnv + ")";    
            sw.WriteLine(combined);
        }
        public static void RunDictionary(
            string DropDirectory,
            string DBConnect,
            string UserName,
            bool toUpper,
            int subtractYearLimit,
            int addYearLimit,
            SqlConnection c)
        {

        }
        public static void RunDataSet(
            string DropDirectory,
            string DBConnect,
            string UserName,
            bool toUpper,
            int subtractYearLimit,
            int addYearLimit,
            SqlConnection c)
        {

        }
        public static void RunCharDelim(
            string DropDirectory,
            string DBConnect,
            string UserName,
            bool toUpper,
            int subtractYearLimit,
            int addYearLimit,
            SqlConnection c,
            int ReportLineCountInterval,
            bool isCSVPlusQuoteDelim)
        {
            DirectoryInfo di = new DirectoryInfo(DropDirectory);
            string bakDir = di.FullName + "\\BAK\\";
            if (!Directory.Exists(bakDir))
            {
                Directory.CreateDirectory(bakDir);
            }
            FileInfo[] fins = di.GetFiles("*.*", SearchOption.TopDirectoryOnly);
            List<FileInfo> fins2 = (from ff in fins
                                    where (
                                    ff.Extension.ToLower() == ".csv" ||
                                    ff.Extension.ToLower() == ".tab" ||
                                    ff.Extension.ToLower() == ".pipe" ||
                                    ff.Extension.ToLower() == ".hat") &&
                                    ff.LastWriteTime < DateTime.Now.AddSeconds(-0.5)
                                    orderby ff.Length descending
                                    select ff).ToList<FileInfo>();
            if (fins2.Count < 1) return;
            DateTime stm = DateTime.Now;
            File.WriteAllText(DropDirectory + "start.time", stm.ToString());   
            foreach (FileInfo f in fins2)
            {
                bool isCsv = false;
                char delim = ' ';

                if (f.Extension.ToLower() == ".csv")
                {
                    isCsv = true;
                    delim = ',';
                }
                else if (f.Extension.ToLower() == ".tab")
                {
                    delim = '\t';
                }
                else if (f.Extension.ToLower() == ".pipe")
                {
                    delim = '|';
                }
                else if (f.Extension.ToLower() == ".hat")
                {
                    delim = '^';
                }
                else continue;

                string fn = f.Name.Trim();
                if (fn.Length > 100)
                {
                    fn = fn.Substring(0, 100);
                }
                Console.WriteLine(f.Name);
                long lineCount = 0;
                StreamReader sr = new StreamReader(f.FullName);
                string fid = Guid.NewGuid().ToString();
                string blnFact = "baleen_" + fid + ".fact";
                string blnSize = "baleen_" + fid + ".size";
                StreamWriter bf = new StreamWriter(di.FullName + "\\" + blnFact);
                string cron = DateTime.Now.ToString();

                List<long> hdr = null;

                string hdrLine = sr.ReadLine();

                if (isCSVPlusQuoteDelim)
                {
                    string[] ssplit = CsvQuoteSplit(hdrLine);
                    hdr = VectoraParser.MakeList(true, ssplit, subtractYearLimit, addYearLimit, c, isCsv, isCSVPlusQuoteDelim);
                }
                else
                {
                    hdr = VectoraParser.MakeList(true, hdrLine.Split(delim), subtractYearLimit, addYearLimit, c, isCsv, isCSVPlusQuoteDelim);
                }

                bool wroteLineOne = false;
                if (hdr != null)
                {
                    if (hdr.Count > 0)
                    {
                        WriteRecord(hdr, bf, cron, UserName, fn, c, isCsv, true, isCSVPlusQuoteDelim);
                        wroteLineOne = true;
                    }
                }
                while (!sr.EndOfStream)
                {
                    lineCount++;
                    if (lineCount % ReportLineCountInterval == 0)
                    {
                        Console.WriteLine("Processing File: " + f.Name);
                        Console.WriteLine("Fact Processing Line No: " + lineCount.ToString());
                    }

                    List<long> dat = null;

                    string datLine = sr.ReadLine();

                    if (isCSVPlusQuoteDelim)
                    {
                        string[] ssplit = CsvQuoteSplit(datLine);
                        dat = VectoraParser.MakeList(true, ssplit, subtractYearLimit, addYearLimit, c, isCsv, isCSVPlusQuoteDelim);
                    }
                    else
                    {
                        dat = VectoraParser.MakeList(true, datLine.Split(delim), subtractYearLimit, addYearLimit, c, isCsv, isCSVPlusQuoteDelim);
                    }
                    
                    if (dat != null)
                    {
                        if (dat.Count > 0)
                        {
                            if (!wroteLineOne)
                            {
                                WriteRecord(dat, bf, cron, UserName, fn, c, isCsv, true, isCSVPlusQuoteDelim);
                                wroteLineOne = true;
                            }
                            else
                            {
                                WriteRecord(dat, bf, cron, UserName, fn, c, isCsv, false, isCSVPlusQuoteDelim);
                            }
                        }
                    }
                }
                bf.Close();
                sr.Close();
                File.Copy(f.FullName, bakDir + f.Name, true);
                File.Delete(f.FullName);
                LoadFact(di.FullName + "\\" + blnFact, DBConnect);
                File.Delete(di.FullName + "\\" + blnFact);
            }
            File.WriteAllText(DropDirectory + "end.time", DateTime.Now.ToString());
        }
        public static void ShapeTextFiles(string directory, int textLineWidth, bool RemoveQuotes)
        {
            DirectoryInfo di = new DirectoryInfo(directory);

            string bakTxt = di.FullName + "\\BAK_TXT\\";

            if(!Directory.Exists(bakTxt))
            {
                Directory.CreateDirectory(bakTxt);
            }
            
            FileInfo[] fins = di.GetFiles();
            //regex helper
            List<FileInfo> fins2 = (from ff in fins
                                    where (
                                    ff.Extension.ToLower() == ".txt") &&
                                    ff.LastWriteTime < DateTime.Now.AddSeconds(-0.5) &&
                                    ff.Length > 0
                                    orderby ff.Length descending
                                    select ff).ToList<FileInfo>();
            foreach (FileInfo f in fins2)
            {
                bool splitComma = false;    
                Console.WriteLine(f.Name);
                if (f.Name.Contains("SCOMMA"))
                {
                    splitComma = true;
                }
                string fname2 = f.Name.ToUpper().Replace(".TXT", "").Replace("SCOMMA","") + ".tab";
                StreamReader sr = new StreamReader(f.FullName);
                StreamWriter sw = new StreamWriter(di.FullName + "\\" + fname2);
                List<string> line = new List<string>();
                int lineNumber = 0;
                while (!sr.EndOfStream)
                {
                    string ln = sr.ReadLine().Trim();
                    if (splitComma)
                    {
                        ln = ln.Replace(",", " , ");
                        ln = ln.Replace('"', ' ');
                    }
                    StringBuilder ln2 = new StringBuilder();
                    foreach (char c in ln)
                    {
                        int ci = (int)c;
                        if (ci <= 256)
                        {
                            ln2.Append(c);
                        }
                        else
                        {
                            ln2.Append(" <").Append(ci.ToString()).Append("> ");
                        }
                    }
                    if (RemoveQuotes)
                    {
                        ln2 = ln2.Replace('"', ' ');
                    }
                    string ln3 = ln2.ToString().Trim();
                    if (String.IsNullOrEmpty(ln3)) continue;
                    string[] parts = RegexHelper.SplitWS.Split(ln3);
                    if (parts == null || parts.Length < 1) continue;
                    foreach (string s in parts)
                    {
                        line.Add(s);
                        if (line.Count == textLineWidth)
                        {
                            lineNumber++;
                            if (lineNumber % 1000 == 0) Console.WriteLine("Line: " + lineNumber.ToString());
                            sw.Write(lineNumber.ToString());
                            for (int i = 0; i < textLineWidth; i++)
                            {
                                sw.Write('\t');
                                if (i < line.Count)
                                {
                                    sw.Write(line[i]);
                                }
                            }
                            sw.WriteLine();
                            line = new List<string>();
                        }
                    }
                    if (line.Count > 0)
                    {
                        lineNumber++;
                        if (lineNumber % 1000 == 0) Console.WriteLine("Line: " + lineNumber.ToString());
                        sw.Write(lineNumber.ToString());
                        for (int i = 0; i < textLineWidth; i++)
                        {
                            sw.Write('\t');
                            if (i < line.Count)
                            {
                                sw.Write(line[i]);
                            }
                        }
                        sw.WriteLine();
                        line = new List<string>();
                    }
                }
                sw.Close();
                sr.Close();
                File.Copy(f.FullName, bakTxt + f.Name, true);
                File.Delete(f.FullName);
            }
        }
        public static void Run(
            string DropDirectory,
            string DBConnect,
            string UserName,
            bool toUpper,
            int subtractYearLimit,
            int addYearLimit,
            int textLineWidth,
            int reportLineCountInterval,
            bool isCsvQuoteDelim,
            bool removeQuotesFromTextFile)
        {
            using (SqlConnection c = new SqlConnection(DBConnect))
            {
                c.Open();
                ShapeTextFiles(DropDirectory, textLineWidth, removeQuotesFromTextFile);
                System.Threading.Thread.Sleep(1000);
                try
                {
                    RunCharDelim(DropDirectory, 
                        DBConnect, 
                        UserName, 
                        toUpper, 
                        subtractYearLimit, 
                        addYearLimit, 
                        c, 
                        reportLineCountInterval, 
                        isCsvQuoteDelim);
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
                if (c != null)
                {
                    c.Close();
                }
            }
        }
    }
}