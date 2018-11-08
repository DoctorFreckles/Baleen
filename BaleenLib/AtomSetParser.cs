using System;
using System.Data.SqlClient;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Configuration;

namespace BaleenLib
{
    public class AtomSetParser
    {
        private static Regex CSVandQUOTESplit =
            new Regex(@""",""", RegexOptions.Compiled);
        private static string[] CsvQuoteSplit(string ln)
        {
            if (String.IsNullOrEmpty(ln)) return null;
            string ln2 = ln.Trim();
            if (ln2.Length < 1) return null;
            return CSVandQUOTESplit.Split(ln2);
        }
        public static void BulkLoadAtomizedFiles(
            string loadFolder, 
            string NewDBNameIn, 
            string MDFLocation, 
            string SqlServerConnection,
            int LoadTimeout)
        {
            if (!Directory.Exists(loadFolder)) return;

            string NewDBName = "BAL_" + NewDBNameIn.Replace("  ", " ").Trim().Replace(' ', '_');

            DirectoryInfo di = new DirectoryInfo(loadFolder);
            List<FileInfo> fins = (from f in di.GetFiles()
                                   orderby f.Length descending
                                   where
                                   f.Extension.ToLower() == ".tab"
                                   select f).ToList<FileInfo>();
            if (fins.Count < 1) return;
            SqlConnection c = null;
            try
            {
                string dbDDL_CreateDB = @"
CREATE DATABASE [<<BLN_DB>>] ON  PRIMARY 
( NAME = N'<<BLN_DB>>', FILENAME = N'<<DB_FILES_DIR>><<BLN_DB>>.mdf' , SIZE = 100MB , MAXSIZE = UNLIMITED, FILEGROWTH = 10% )
 LOG ON 
( NAME = N'<<BLN_DB>>_log', FILENAME = N'<<DB_FILES_DIR>><<BLN_DB>>_log.ldf' , SIZE = 100MB , MAXSIZE = UNLIMITED , FILEGROWTH = 10%)

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
".Replace("<<BLN_DB>>", NewDBName).Replace("<<DB_FILES_DIR>>", MDFLocation);

                string dbCheckForExistence = @"
select COUNT(*) as CountOf 
from sys.databases where name = '<<BLN_DB>>'
".Replace("<<BLN_DB>>", NewDBName);

                c = new SqlConnection(SqlServerConnection);
                c.Open();
                SqlCommand cmd = new SqlCommand(dbCheckForExistence, c);
                cmd.CommandTimeout = 120;
                object exists = cmd.ExecuteScalar();
                int exst = (int)exists;
                if (exst > 0) return;
                cmd = new SqlCommand(dbDDL_CreateDB, c);
                cmd.CommandTimeout = 1000;
                Console.WriteLine("Creating DB: " + NewDBName);
                int createDBResult = cmd.ExecuteNonQuery();
                System.Threading.Thread.Sleep(500);
                foreach (FileInfo f in fins)
                {
                    string tableName = f.Name.Replace(f.Extension,"");
                    Console.WriteLine("Creating Table: " + tableName);
                    string sqlCreateTable = "";
                    string sqlCreateIndex = "";
                    if (tableName.Contains("-DTM"))
                    {
                        sqlCreateTable = @"
USE [<<BLN_DB>>]

CREATE TABLE [<<TABLE_NAME>>](
	[key] [bigint] NOT NULL,
	[val] [datetime] NULL,
 CONSTRAINT [pk_<<TABLE_NAME>>] PRIMARY KEY CLUSTERED 
(
	[key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, 
IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

";
                        sqlCreateIndex = @"
USE [<<BLN_DB>>]

CREATE NONCLUSTERED INDEX [idx_<<TABLE_NAME>>] ON [<<TABLE_NAME>>] 
(
[val] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, 
SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, 
ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

";
                    }
                    else if (tableName.Contains("-FLT"))
                    {
                        sqlCreateTable = @"
USE [<<BLN_DB>>]

CREATE TABLE [<<TABLE_NAME>>](
	[key] [bigint] NOT NULL,
	[val] [float](53) NULL,
 CONSTRAINT [pk_<<TABLE_NAME>>] PRIMARY KEY CLUSTERED 
(
	[key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, 
IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

";
                        sqlCreateIndex = @"
USE [<<BLN_DB>>]

CREATE NONCLUSTERED INDEX [idx_<<TABLE_NAME>>] ON [<<TABLE_NAME>>] 
(
[val] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, 
SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, 
ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

";
                    }
                    else if (tableName.Contains("-INT"))
                    {
                        sqlCreateTable = @"
USE [<<BLN_DB>>]

CREATE TABLE [<<TABLE_NAME>>](
	[key] [bigint] NOT NULL,
	[val] [bigint] NULL,
 CONSTRAINT [pk_<<TABLE_NAME>>] PRIMARY KEY CLUSTERED 
(
	[key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, 
IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

";
                        sqlCreateIndex = @"
USE [<<BLN_DB>>]

CREATE NONCLUSTERED INDEX [idx_<<TABLE_NAME>>] ON [<<TABLE_NAME>>] 
(
[val] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, 
SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, 
ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

";
                    }
                    else if (tableName.Contains("-TXTS"))
                    {
                        sqlCreateTable = @"
USE [<<BLN_DB>>]

CREATE TABLE [<<TABLE_NAME>>](
	[key] [bigint] NOT NULL,
	[val] [nvarchar](400) NULL,
 CONSTRAINT [pk_<<TABLE_NAME>>] PRIMARY KEY CLUSTERED 
(
	[key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, 
IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

";
                        sqlCreateIndex = @"
USE [<<BLN_DB>>]

CREATE NONCLUSTERED INDEX [idx_<<TABLE_NAME>>] ON [<<TABLE_NAME>>] 
(
[val] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, 
SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, 
ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
";
                    }
                    else if (tableName.Contains("-TXTL"))
                    {
                        sqlCreateTable = @"
USE [<<BLN_DB>>]

CREATE TABLE [<<TABLE_NAME>>](
	[key] [bigint] NOT NULL,
	[val] [ntext] NULL,
 CONSTRAINT [pk_<<TABLE_NAME>>] PRIMARY KEY CLUSTERED 
(
	[key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, 
IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

";
                        sqlCreateIndex = null;
                    }
                    else
                    {
                        continue;
                    }

                    sqlCreateTable = sqlCreateTable
                    .Replace("<<BLN_DB>>", NewDBName)
                    .Replace("<<TABLE_NAME>>", tableName);

                    if (sqlCreateIndex != null)
                    {
                        sqlCreateIndex = sqlCreateIndex
                        .Replace("<<BLN_DB>>", NewDBName)
                        .Replace("<<TABLE_NAME>>", tableName);
                    }

                    string sqlLoadTable = @"
USE [<<BLN_DB>>]

bulk insert [<<TABLE_NAME>>]
from '<<FILE_NAME>>'
with
(
firstrow = 1
)
                    ".Replace("<<FILE_NAME>>", f.FullName)
                     .Replace("<<BLN_DB>>", NewDBName)
                     .Replace("<<TABLE_NAME>>", tableName);

                    try
                    {
                        cmd = new SqlCommand(sqlCreateTable, c);
                        cmd.CommandTimeout = LoadTimeout;
                        int res = cmd.ExecuteNonQuery();
                        System.Threading.Thread.Sleep(500);
                        if (!string.IsNullOrEmpty(sqlCreateIndex))
                        {
                            cmd = new SqlCommand(sqlCreateIndex, c);
                            cmd.CommandTimeout = LoadTimeout;
                            res = cmd.ExecuteNonQuery();
                            System.Threading.Thread.Sleep(500);
                        }
                        cmd = new SqlCommand(sqlLoadTable, c);
                        cmd.CommandTimeout = LoadTimeout;
                        res = cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.Message);
                    }
                }

                //shrink log file

                System.Threading.Thread.Sleep(500);

                string sqlShrinkLogFile = @"
USE [<<BLN_DB>>]

DBCC SHRINKFILE (<<BLN_DB>>_Log, 1)
".Replace("<<BLN_DB>>", NewDBName);

                string sqlShrinkDBFile = @"
USE [<<BLN_DB>>]

DBCC SHRINKFILE (<<BLN_DB>>, 1)
".Replace("<<BLN_DB>>", NewDBName);

                cmd = new SqlCommand(sqlShrinkLogFile, c);
                cmd.CommandTimeout = LoadTimeout;
                int shrinkRes = cmd.ExecuteNonQuery();
                System.Threading.Thread.Sleep(500);
                cmd = new SqlCommand(sqlShrinkDBFile, c);
                cmd.CommandTimeout = LoadTimeout;
                shrinkRes = cmd.ExecuteNonQuery();
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
        public static void AtomizeDirectories(
            string dbSourcesPath,
            bool createDB,
            string sqlAdminConnection,
            int loadTimeout,
            int minYear,
            int maxYear)
        {
            if (!Directory.Exists(dbSourcesPath)) return;
            DirectoryInfo di = new DirectoryInfo(dbSourcesPath);
            DirectoryInfo[] dirs = di.GetDirectories();
            foreach (DirectoryInfo d in dirs)
            {
                Console.WriteLine("Building DB:" + d.Name);
                AtomizeDirectory(d.FullName, createDB, d.FullName + "\\", sqlAdminConnection, loadTimeout, minYear, maxYear);
            }
        }
        public static void AtomizeDirectory(
            string sourceDirectoryPath, 
            bool createDB, 
            string MDFLocation,
            string sqlAdminConnection,
            int loadTimeout,
            int minYear,
            int maxYear)
        {
            if (!Directory.Exists(sourceDirectoryPath)) return;
            DirectoryInfo di = new DirectoryInfo(sourceDirectoryPath);
            Dictionary<string, StreamWriter> writers = new Dictionary<string, StreamWriter>();
            long objectID = 0;
            List<FileInfo> fins = (from f in di.GetFiles()
                                   orderby f.Length descending
                                   where 
                                   f.Extension.ToLower() == ".csv" ||
                                   f.Extension.ToLower() == ".qcsv" ||
                                   f.Extension.ToLower() == ".tab" ||
                                   f.Extension.ToLower() == ".pipe" ||
                                   f.Extension.ToLower() == ".hat"
                                   select f).ToList<FileInfo>();
            if (fins.Count < 1) return;
            File.WriteAllText(sourceDirectoryPath + "\\create_baleen_sets.start", DateTime.Now.ToString());

            string atomFiles = di.FullName + "\\BALEEN_DATA\\";

            foreach (FileInfo f in fins)
            {
                AtomizeFile(f.FullName, ref objectID, writers, atomFiles, minYear, maxYear);
            }
            if (writers.Keys.Count > 0)
            {
                foreach (string key in writers.Keys)
                {
                    if (writers[key] != null)
                    {
                        writers[key].Close();
                    }
                }
            }
            if (createDB)
            {
                BulkLoadAtomizedFiles(atomFiles, di.Name, MDFLocation, sqlAdminConnection, loadTimeout);
            }
            File.WriteAllText(sourceDirectoryPath + "\\max_object_id.ido", objectID.ToString());
            File.WriteAllText(sourceDirectoryPath + "\\create_baleen_sets.end", DateTime.Now.ToString());
        }
        public static void AtomizeFile(
            string sourceFile, 
            ref long objectID, 
            Dictionary<string,StreamWriter> writers,
            string AtomFiles,
            int minYear,
            int maxYear)
        {
            if (!Directory.Exists(AtomFiles))
            {
                Directory.CreateDirectory(AtomFiles);
            }

            FileInfo f = new FileInfo(sourceFile);

            bool isCSVPlusQuoteDelim = false;

            char delim = ' ';

            if (f.Extension.ToLower() == ".qcsv")
            {
                isCSVPlusQuoteDelim = true;
            }
            else if (f.Extension.ToLower() == ".csv")
            {
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
            else return;

            string fn = f.Name.Trim();
            
            if (fn.Length > 100)
            {
                fn = fn.Substring(0, 100);
            }
            
            Console.WriteLine(f.Name);
            
            StreamReader sr = new StreamReader(f.FullName);
            
            string hdrLine = sr.ReadLine();
            
            string[] hdr = null;
            
            if (isCSVPlusQuoteDelim)
            {
                hdr = CsvQuoteSplit(hdrLine);
            }
            else
            {
                hdr = hdrLine.Split(delim);
            }

            while (!sr.EndOfStream)
            {
                try
                {
                    objectID++;
                    if (objectID % 1000 == 0)
                    {
                        Console.WriteLine("Processing File: " + f.Name);
                        Console.WriteLine("Fact Processing Object ID: " + objectID.ToString());
                    }
                    string datLine = sr.ReadLine();
                    string[] dat = null;
                    if (isCSVPlusQuoteDelim)
                    {
                        dat = CsvQuoteSplit(datLine);
                    }
                    else
                    {
                        dat = datLine.Split(delim);
                    }
                    if (dat != null && hdr != null && hdr.Length == dat.Length && dat.Length > 0)
                    {
                        for (int i = 0; i < hdr.Length; i++)
                        {
                            string h = hdr[i];
                            string d = dat[i];
                            if (String.IsNullOrEmpty(h)) continue;
                            if (String.IsNullOrEmpty(d)) continue;
                            if (isCSVPlusQuoteDelim)
                            {
                                h = h.Replace('"', ' ').Trim();
                                d = d.Replace('"', ' ').Trim();
                            }
                            if (d == null)
                            {
                                continue;
                            }
                            d = d.Replace('\t', ' ').Replace('`', ' ').Trim().ToUpper();
                            d = d.Replace("NULL", "").Replace("<NULL>", "");
                            h = h.Replace('`', ' ').Trim();
                            if (d.Length < 1) continue;
                            object type = null;
                            if (d.Length <= 400)
                            {
                                type = Utility.UtilityMain.GetConvertedValue(d, minYear, maxYear);
                                if (type == null) type = d;
                            }
                            else
                            {
                                type = d;
                            }
                            string wKey = "BSET_" + f.Name
                                .Replace(f.Extension, "")
                                .ToUpper()
                                .Trim()
                                .Replace('-', ' ')
                                .Replace(' ', '_')
                                .Replace("__", "_") + "-" +
                                h.ToUpper()
                                .Replace('-', ' ')
                                .Replace(')', ' ')
                                .Replace('(', ' ')
                                .Replace('.', ' ')
                                .Trim()
                                .Replace(' ', '_')
                                .Replace("__", "_");

                            string mappedType = Utility.FieldTypeLookup.GetType(wKey);

                            if (type is long && mappedType == "INT")
                            {
                                wKey = wKey + "-INT";
                            }
                            else if ((type is double || type is long || type is float || type is decimal) && mappedType == "FLT")
                            {
                                wKey = wKey + "-FLT";
                            }
                            else if (type is DateTime && mappedType == "DTM")
                            {
                                wKey = wKey + "-DTM";
                            }
                            else
                            {
                                if (d.Length <= 400)
                                {
                                    type = d;
                                    wKey = wKey + "-TXTS";
                                }
                                else
                                {
                                    type = d;
                                    wKey = wKey + "-TXTL";
                                }
                            }
                            if (!writers.ContainsKey(wKey))
                            {
                                string wn = AtomFiles + wKey + ".TAB";
                                writers.Add(wKey, new StreamWriter(wn));
                            }
                            writers[wKey].Write(objectID.ToString());
                            writers[wKey].Write('\t');
                            writers[wKey].Write(type.ToString());
                            writers[wKey].WriteLine();
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
            sr.Close();
        }
    }
}
