using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace BaleenLib.BaleenParse
{
    public class FastDataWarehouse
    {
        public static string Run(string directory, long startDimSeq)
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
                    
                    StreamWriter sw = null;
                    
                    try
                    {
                        string[] nameParts = fi.Name.Split('.');

                        string fname = nameParts[0];

                        sw = new StreamWriter(outputDirectory + "BLN_" + fname + ".tab");

                        StreamReader sr = new StreamReader(fi.FullName);

                        string hdrLine = sr.ReadLine();

                        string[] hdr = null;

                        hdr = hdrLine.Split(splitter);

                        if (isCsv)
                        {
                            sw.WriteLine(hdrLine.Replace(',', '\t'));
                        }
                        else
                        {
                            sw.WriteLine(hdrLine);
                        }

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

                                        bool isMemo = val.Length > 500;

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
                                            string valShort = val.Substring(0, 500);
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
                                        rec.Append(fkey.ToString()).Append('\t');
                                    }
                                    else
                                    {
                                        rec.Append("-1").Append('\t');
                                    }
                                }

                                string dline = rec.ToString().Substring(0, rec.Length - 1);

                                sw.WriteLine(dline);

                            }
                        }

                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine(ex.Message);
                    }
                    finally
                    {
                        if (sw != null) sw.Close();
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

                                StringBuilder rec = new StringBuilder();

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

                                        bool isMemo = val.Length > 500;

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
                                            string valShort = val.Substring(0, 500);
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
                                        rec.Append(fkey.ToString()).Append('\t');
                                    }
                                    else
                                    {
                                        rec.Append("-1").Append('\t');
                                    }
                                }

                                string dline = rec.ToString().Substring(0, rec.Length - 1);

                                sw.WriteLine(dline);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.Message);
                    }
                    finally
                    {
                        if (sw != null) sw.Close();
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

            return outputDirectory;
        }
        public static void BuildDB(
            string baleenDBName,
            string baleenSrcFileDir,
            string MasterDBConnect,
            string DBFilesDir)
        {
           
            SqlConnection c = null;
            
            try
            {
                string dbName = "BLN_" + baleenDBName.Replace("  ", " ").Trim().Replace(' ', '_');

                //create db

                string dbDDL_CreateDB = @"
CREATE DATABASE [<<BLN_DB>>] ON  PRIMARY 
( NAME = N'<<BLN_DB>>', FILENAME = N'<<DB_FILES_DIR>><<BLN_DB>>.mdf' , SIZE = 2000KB , MAXSIZE = UNLIMITED, FILEGROWTH = 30% )
 LOG ON 
( NAME = N'<<BLN_DB>>_log', FILENAME = N'<<DB_FILES_DIR>><<BLN_DB>>_log.ldf' , SIZE = 1000KB , MAXSIZE = UNLIMITED , FILEGROWTH = 30%)

ALTER DATABASE [<<BLN_DB>>] SET COMPATIBILITY_LEVEL = 100

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [<<BLN_DB>>].[dbo].[sp_fulltext_database] @action = 'enable'
end

ALTER DATABASE [<<BLN_DB>>] SET ANSI_NULL_DEFAULT OFF

ALTER DATABASE [<<BLN_DB>>] SET ANSI_NULLS OFF

ALTER DATABASE [<<BLN_DB>>] SET ANSI_PADDING OFF

ALTER DATABASE [<<BLN_DB>>] SET ANSI_WARNINGS OFF

ALTER DATABASE [<<BLN_DB>>] SET ARITHABORT OFF

ALTER DATABASE [<<BLN_DB>>] SET AUTO_CLOSE OFF

ALTER DATABASE [<<BLN_DB>>] SET AUTO_CREATE_STATISTICS ON

ALTER DATABASE [<<BLN_DB>>] SET AUTO_SHRINK ON

ALTER DATABASE [<<BLN_DB>>] SET AUTO_UPDATE_STATISTICS ON

ALTER DATABASE [<<BLN_DB>>] SET CURSOR_CLOSE_ON_COMMIT OFF

ALTER DATABASE [<<BLN_DB>>] SET CURSOR_DEFAULT  GLOBAL

ALTER DATABASE [<<BLN_DB>>] SET CONCAT_NULL_YIELDS_NULL OFF

ALTER DATABASE [<<BLN_DB>>] SET NUMERIC_ROUNDABORT OFF

ALTER DATABASE [<<BLN_DB>>] SET QUOTED_IDENTIFIER OFF

ALTER DATABASE [<<BLN_DB>>] SET RECURSIVE_TRIGGERS OFF

ALTER DATABASE [<<BLN_DB>>] SET  DISABLE_BROKER

ALTER DATABASE [<<BLN_DB>>] SET AUTO_UPDATE_STATISTICS_ASYNC OFF

ALTER DATABASE [<<BLN_DB>>] SET DATE_CORRELATION_OPTIMIZATION OFF

ALTER DATABASE [<<BLN_DB>>] SET TRUSTWORTHY OFF

ALTER DATABASE [<<BLN_DB>>] SET ALLOW_SNAPSHOT_ISOLATION OFF

ALTER DATABASE [<<BLN_DB>>] SET PARAMETERIZATION SIMPLE

ALTER DATABASE [<<BLN_DB>>] SET READ_COMMITTED_SNAPSHOT OFF

ALTER DATABASE [<<BLN_DB>>] SET HONOR_BROKER_PRIORITY OFF

ALTER DATABASE [<<BLN_DB>>] SET  READ_WRITE

ALTER DATABASE [<<BLN_DB>>] SET RECOVERY SIMPLE

ALTER DATABASE [<<BLN_DB>>] SET  MULTI_USER

ALTER DATABASE [<<BLN_DB>>] SET PAGE_VERIFY CHECKSUM

ALTER DATABASE [<<BLN_DB>>] SET DB_CHAINING OFF
".Replace("<<BLN_DB>>", dbName).Replace("<<DB_FILES_DIR>>", DBFilesDir);

                string dbDDL_CreateEntities = @"
USE [<<BLN_DB>>]

CREATE TABLE [dbo].[dim_datetime](
	[DimKey] [bigint] NOT NULL,
	[Date-Time] [datetime] NULL,
 CONSTRAINT [PK_dim_datetime] PRIMARY KEY CLUSTERED 
(
	[DimKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[dim_double](
	[DimKey] [bigint] NOT NULL,
	[Double-Number] [float] NULL,
 CONSTRAINT [PK_dim_double] PRIMARY KEY CLUSTERED 
(
	[DimKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[dim_long](
	[DimKey] [bigint] NOT NULL,
	[Long-Integer] [bigint] NULL,
 CONSTRAINT [PK_dim_long] PRIMARY KEY CLUSTERED 
(
	[DimKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[dim_memo](
	[DimKey] [bigint] NOT NULL,
	[Large-Text] [text] NULL,
 CONSTRAINT [PK_dim_memo] PRIMARY KEY CLUSTERED 
(
	[DimKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE TABLE [dbo].[dim_text](
	[DimKey] [bigint] NOT NULL,
	[Small-Text] [varchar](550) NULL,
 CONSTRAINT [PK_dim_text] PRIMARY KEY CLUSTERED 
(
	[DimKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [idx_datetime] ON [dbo].[dim_datetime] 
(
	[Date-Time] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [idx_double] ON [dbo].[dim_double] 
(
	[Double-Number] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [idx_long_integer] ON [dbo].[dim_long] 
(
	[Long-Integer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [idx_text] ON [dbo].[dim_text] 
(
	[Small-Text] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

".Replace("<<BLN_DB>>", dbName);

                string dbCheckForExistence = @"
select COUNT(*) as CountOf 
from sys.databases where name = '<<BLN_DB>>'
".Replace("<<BLN_DB>>", dbName);

                c = new SqlConnection(MasterDBConnect);

                c.Open();

                SqlCommand cmd = new SqlCommand(dbCheckForExistence, c);

                cmd.CommandTimeout = 120;

                object exists = cmd.ExecuteScalar();

                int exst = (int)exists;

                if (exst > 0) return;

                cmd = new SqlCommand(dbDDL_CreateDB, c);

                cmd.CommandTimeout = 120;

                int createDBResult = cmd.ExecuteNonQuery();

                cmd = new SqlCommand(dbDDL_CreateEntities, c);

                cmd.CommandTimeout = 120;

                int createEntityResult = cmd.ExecuteNonQuery();

                ////////////////////

                //run parse

                int loadTimeout = 60 * 60 * 12;

                string loadDir = FastDataWarehouse.Run(baleenSrcFileDir, 0);

                //allow OS and filesystem a pause before running next steps

                System.Threading.Thread.Sleep(3 * 1000);

                DirectoryInfo blnLoadFiles = new DirectoryInfo(loadDir);

                FileInfo[] loadFiles = blnLoadFiles.GetFiles("BLN_*.tab");

                foreach (FileInfo f in loadFiles)
                {
                    string[] fparts = f.Name.Split('.');

                    string tableName = fparts[0].Trim();

                    StreamReader sr = new StreamReader(f.FullName);

                    string hdr = sr.ReadLine();

                    sr.Close();

                    string[] flds = hdr.Split('\t');

                    StringBuilder fieldDefs = new StringBuilder();

                    foreach (string fld in flds)
                    {
                        fieldDefs.Append('[');
                        fieldDefs.Append(fld);
                        fieldDefs.Append(']');
                        fieldDefs.Append(' ');
                        fieldDefs.Append("[bigint]");
                        fieldDefs.Append(" NULL ");
                        fieldDefs.Append(',');
                    }

                    string fdef = fieldDefs.ToString().Substring(0, fieldDefs.Length - 1);

                    string templateSql = @"
USE [<<BLN_DB>>]

CREATE TABLE [dbo].[<<TABLE_NAME>>]
(
<<DATA_FIELDS>>
) ON [PRIMARY]

".Replace("<<BLN_DB>>", dbName).Replace("<<TABLE_NAME>>", tableName).Replace("<<DATA_FIELDS>>", fdef);


                    int tres = 0;

                    cmd = new SqlCommand(templateSql, c);

                    cmd.CommandTimeout = 120;

                    tres = cmd.ExecuteNonQuery();

                    string sqlLoadTable = @"
USE [<<BLN_DB>>]

bulk insert [<<TABLE_NAME>>]
from '<<FILE_NAME>>'
with
(
firstrow = 2
)
                    ".Replace("<<FILE_NAME>>", f.FullName).Replace("<<BLN_DB>>", dbName).Replace("<<TABLE_NAME>>", tableName);

                    try
                    {
                        cmd = new SqlCommand(sqlLoadTable, c);
                        cmd.CommandTimeout = loadTimeout;
                        tres = cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.Message);
                    }
                }

                string sql_load_dim_datetime = @"
USE [<<BLN_DB>>]

bulk insert dim_datetime
from '<<LOAD_DIR>>dim_datetime.tab'
with
(
firstrow = 2
)
".Replace("<<LOAD_DIR>>", loadDir).Replace("<<BLN_DB>>", dbName);

                cmd = new SqlCommand(sql_load_dim_datetime, c);

                cmd.CommandTimeout = loadTimeout;

                int loadDimDtmRes = cmd.ExecuteNonQuery();

                //load dim_double

                string sql_load_dim_double = @"
USE [<<BLN_DB>>]

bulk insert dim_double
from '<<LOAD_DIR>>dim_double.tab'
with
(
firstrow = 2
)
".Replace("<<LOAD_DIR>>", loadDir).Replace("<<BLN_DB>>", dbName);

                cmd = new SqlCommand(sql_load_dim_double, c);

                cmd.CommandTimeout = loadTimeout;

                int loadDimDblRes = cmd.ExecuteNonQuery();

                //load dim_long

                string sql_load_dim_long = @"
USE [<<BLN_DB>>]

bulk insert dim_long
from '<<LOAD_DIR>>dim_long.tab'
with
(
firstrow = 2
)
".Replace("<<LOAD_DIR>>", loadDir).Replace("<<BLN_DB>>", dbName);

                cmd = new SqlCommand(sql_load_dim_long, c);

                cmd.CommandTimeout = loadTimeout;

                int loadDimLngRes = cmd.ExecuteNonQuery();

                //load dim_memo

                string sql_load_dim_memo = @"
USE [<<BLN_DB>>]

bulk insert dim_memo
from '<<LOAD_DIR>>dim_memo.tab'
with
(
firstrow = 2
)
".Replace("<<LOAD_DIR>>", loadDir).Replace("<<BLN_DB>>", dbName);

                cmd = new SqlCommand(sql_load_dim_memo, c);

                cmd.CommandTimeout = loadTimeout;

                int loadDimMemoRes = cmd.ExecuteNonQuery();

                //load dim_text

                string sql_load_dim_text = @"
USE [<<BLN_DB>>]

bulk insert dim_text
from '<<LOAD_DIR>>dim_text.tab'
with
(
firstrow = 2
)
".Replace("<<LOAD_DIR>>", loadDir).Replace("<<BLN_DB>>", dbName);

                cmd = new SqlCommand(sql_load_dim_text, c);

                cmd.CommandTimeout = loadTimeout;

                int loadDimTextRes = cmd.ExecuteNonQuery();

                //shring log file

                System.Threading.Thread.Sleep(3 * 1000);

                string sqlShrinkLogFile = @"
USE [<<BLN_DB>>]

DBCC SHRINKFILE (<<BLN_DB>>_Log, 1)
".Replace("<<BLN_DB>>", dbName);

                cmd = new SqlCommand(sqlShrinkLogFile, c);

                cmd.CommandTimeout = loadTimeout;

                int shrinkRes = cmd.ExecuteNonQuery();

                //mark end load time

                File.WriteAllText(loadDir + "baleen_DB_load.done", DateTime.Now.ToString());
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (c != null)
                {
                    c.Close();
                }
            }
        }
        public static void BuildMultipleDB(
            string processDir, 
            string DBFilesDir,
            string MasterDBConnection)
        {
            DirectoryInfo di = new DirectoryInfo(processDir);
            DirectoryInfo[] dins = di.GetDirectories();
            foreach (DirectoryInfo d in dins)
            {
                string db = d.Name;
                Console.WriteLine(d.Name);
                BuildDB(db, d.FullName + "\\", MasterDBConnection, DBFilesDir);
            }
        }
    }
}
