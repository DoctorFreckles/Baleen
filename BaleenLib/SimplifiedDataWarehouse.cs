using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Configuration;
using System.Timers;

namespace BaleenLib
{
    public enum BaleenDataType
    {
        SmallText = 0,
        LargeText = 1,
        LongInteger = 2,
        Float = 3,
        DateTime = 4
    }
    public class SchemaInfo
    {
        public string ConnectionString = "";
        public string SchemaName = "";
    }
    public class DictionaryEntry
    {
        public static string GetAbbreviatedType(BaleenDataType dataType)
        {
            if (dataType == BaleenDataType.DateTime) return "DTM";
            if (dataType == BaleenDataType.Float) return "FLT";
            if (dataType == BaleenDataType.LargeText) return "LTXT";
            if (dataType == BaleenDataType.SmallText) return "STXT";
            if (dataType == BaleenDataType.LongInteger) return "LINT";
            throw new Exception("This data type is NOT defined!");
        }
        public long EntryID = -1;
        public string SourceSchemaName = "";
        public string SourceTableName = "";
        public string SourceColumnName = "";
        public string TargetSchemaName = "";
        public string TargetTableName = "";
        public string TargetColumnName = "";
        public int UIDisplayTabOrder = -1;
        public string ValidatingRegexPattern = "";
        public Regex ValidatingRegex = null;
        public BaleenDataType DataType = BaleenDataType.LargeText;
        public string AbbreviatedType
        {
            get
            {
                return GetAbbreviatedType(this.DataType);
            }
        }
        public string ShortDescription = "";
        public string HelpInformation = "";
        public DateTime EntryCreatedDate = DateTime.MinValue;
        public DateTime EntryLastUpdateDate = DateTime.MinValue;
        public string CreatedBy = "";
        public string UpdatedBy = "";
    }
    public class SimplifiedDataWarehouse
    {
        private static List<string> EntityLoadDirectories = new List<string>();
        private static List<DictionaryEntry> DataDictionary = new List<DictionaryEntry>();
        private static Dictionary<string, string> KeyWordMap = new Dictionary<string, string>();
        private static bool UpperCaseValues = true;
        static SimplifiedDataWarehouse()
        {
            Init();
        }
        public static void Init()
        {
            //load data dictionary from META database
            //load entity meta data by schema
            //load any other shared 'high level' by schema
            //data statistics/information
            //load Keyword Map
            //load entity LOAD directories list: list of folders where 
            //continuous feed data, from the external system, is dropped
        }
        public static string MapString(string Input)
        {
            //use this function to 'clean up' any
            //meta data (column) values being imported 
            //from files
            if (String.IsNullOrEmpty(Input)) return "";
            string keyword = Input.Trim();
            if (keyword.Length < 1) return "";
            if (KeyWordMap.ContainsKey(keyword))
            {
                return KeyWordMap[keyword];
            }
            else
            {
                return keyword;
            }
        }
        public static void CodeGenSimpleViewORM(
            string Schema)
        {

        }
        public static void AddRecords(
            string importFileName,
            string Schema,
            string TableName, 
            string CreatedBy,
            DateTime CreatedOn)
        {
            //on any specific column mapping failure
            //and error_table a seven tuple 
            //(record_id, table, column, small_val, 
            //large_val, error_description, error_date)
            //this function is called by a continuous
            //load process
        }
        public static void UpdateValue(
            string Schema, 
            string TableName, 
            string Column, 
            string Value,
            string UpdatedBy,
            DateTime UpdatedOn)
        {

        }
    }
}
