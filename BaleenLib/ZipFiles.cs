using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using ICSharpCode.SharpZipLib.Zip;
using ICSharpCode.SharpZipLib.Checksums;
using ICSharpCode.SharpZipLib.GZip;

namespace BaleenLib.Utility
{
    public class ZipFiles
    {
        public static void ZipDir(string dirToZip, string destinationFolder)
        {
            if (!Directory.Exists(dirToZip))
            {
                return;
            }
            try
            {
                string yr = DateTime.Today.Year.ToString();
                string mo = DateTime.Today.Month.ToString();
                string dy = DateTime.Today.Day.ToString();

                string destinationFile = destinationFolder +
                    yr + "_" +
                    mo + "_" +
                    dy + "_DATA.zip";

                FastZip fz = new FastZip();
                fz.CreateZip(destinationFile, dirToZip, false, ".txt");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }
        public static void UnZipFile(string sourcePath, string destinationDir)
        {
            if (!(File.Exists(sourcePath))) return;
            try
            {
                FastZip unzip = new FastZip();
                unzip.ExtractZip(sourcePath, destinationDir, "");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }
        public static void ZipFile(string FilePathIn, string FilePathOut)
        {
            string filePath = FilePathIn;

            string[] splitFilePath = filePath.Split('\\');
            string fileName = splitFilePath[splitFilePath.Length - 1];
            string ZipFileName = FilePathOut;

            int CompressionLevel = 9;
            FileStream strmZipFile = null;
            try
            {
                File.Delete(ZipFileName);
                strmZipFile = File.Create(ZipFileName);
                ZipOutputStream strmZipStream = null;
                try
                {
                    strmZipStream = new ZipOutputStream(strmZipFile);
                    strmZipStream.SetLevel(CompressionLevel);
                    AddToZip(strmZipStream, filePath, fileName, "");
                }
                catch (Exception ex1)
                {
                    throw ex1;
                }
                finally
                {
                    if (null != strmZipStream)
                    {
                        strmZipStream.Finish();
                        strmZipStream.Close();
                    }
                }
                File.Delete(fileName);
            }
            catch (Exception ex2)
            {
                throw ex2;
            }
            finally
            {
                strmZipFile.Close();
            }
        }
        public static void AddToZip(ZipOutputStream ZipFile, string filePath, string fileName, string folder)
        {
            Crc32 crc = new Crc32();
            FileStream fs = File.OpenRead(filePath);
            byte[] buffer = new byte[fs.Length];
            fs.Read(buffer, 0, buffer.Length);
            ZipEntry entry = new ZipEntry(folder + fileName);
            entry.DateTime = DateTime.Now;
            entry.Size = fs.Length;
            fs.Close();
            crc.Reset();
            crc.Update(buffer);
            entry.Crc = crc.Value;
            ZipFile.PutNextEntry(entry);
            ZipFile.Write(buffer, 0, buffer.Length);
        }		
    }
}
