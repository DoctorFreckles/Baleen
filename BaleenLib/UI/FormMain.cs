using System;
using System.IO;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Configuration;
using System.Windows.Forms;


namespace BaleenLib.UI
{
    public partial class FormMain : Form
    {
        //private LogicEXE logEngine = new LogicEXE(Directory.GetCurrentDirectory(), @"C:\Program Files (x86)\pl\bin\plcon.exe", 60 * 1000);
        public FormMain()
        {
            InitializeComponent();
        }

        //private void buttonProcessFiles_Click(object sender, EventArgs e)
        //{
        //    FolderBrowserDialog fbd = new FolderBrowserDialog();

        //    fbd.RootFolder = Environment.SpecialFolder.Personal;

        //    if (fbd.ShowDialog() == DialogResult.OK)
        //    {
        //        string dir = fbd.SelectedPath;

        //        try
        //        {
        //            FileProcessor.Process(dir, this.textDropDir.Text, long.Parse(this.textFileSize.Text), this.textDropDir.Text + "INDEX\\");
        //        }
        //        catch (Exception ex)
        //        {
        //            System.Diagnostics.Debug.WriteLine(ex.Message);
        //        }
        //    }



        //}

        //private void buttonPickDropFolder_Click(object sender, EventArgs e)
        //{
        //    FolderBrowserDialog fbd = new FolderBrowserDialog();

        //    fbd.RootFolder = Environment.SpecialFolder.Personal;

        //    if (fbd.ShowDialog() == DialogResult.OK)
        //    {
        //        string dir = fbd.SelectedPath;


        //        this.textDropDir.Text = dir;

        //    }




        //    //OpenFileDialog ofd = new OpenFileDialog();

        //    //try
        //    //{
        //    //    ofd.InitialDirectory = ConfigurationManager.AppSettings["HomeDir"];
        //    //}
        //    //catch
        //    //{
        //    //    ofd.InitialDirectory = Directory.GetCurrentDirectory();
        //    //}

        //    //ofd.RestoreDirectory = true;

        //    //ofd.Multiselect = true;

        //    //if (ofd.ShowDialog() == DialogResult.OK)
        //    //{
        //    //    string[] files = ofd.FileNames;

        //    //    foreach (string f in files)
        //    //    {

        //    //    }


        //    //}

        //}

        private void FormMain_Load(object sender, EventArgs e)
        {
            this.DendraTree.ExpandAll();
            //this.ActionTimer.Interval = 1000 * 60 * 10;
            //this.ActionTimer.Enabled = true;
            //this.ActiveIndexingService.RunWorkerAsync();



//            DataTable dt = Utility.Data.GetData(@"
//
//use dendritica;
//
//SELECT * from file_index
//where token like 'murd%'
//;
//
//
//", @"server=localhost;User Id=root; Password=7t6ersss;Persist Security Info=True;database=mysql; default command timeout=400; Connection Timeout=500;");






        }

        //private void button1_Click(object sender, EventArgs e)
        //{
        //    this.textBox1.Text = (DateTime.Now.Millisecond).ToString();
        //}

        private void ActiveIndexingService_DoWork(object sender, DoWorkEventArgs e)
        {
            //Indexing.ActiveIndexer.Run();
        }

        private void ActionTimer_Tick(object sender, EventArgs e)
        {
            //this.ActionTimer.Enabled = false;
            //if (!this.ActiveIndexingService.IsBusy)
            //{
            //    this.ActiveIndexingService.RunWorkerAsync();
            //} 
            //this.ActionTimer.Enabled = true;
        }

        //private void buttonAssert_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        string res = this.logEngine.Assert(this.richTextBoxIn.Text);
        //        this.richTextBoxOut.Text = res;
        //    }
        //    catch { }
        //}

        //private void buttonQuery_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        string res = this.logEngine.Query(this.richTextBoxIn.Text, true);
        //        this.richTextBoxOut.Text = res;
        //    }
        //    catch { }
        //}
    }
}
